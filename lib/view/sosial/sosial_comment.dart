import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:reportin/model/comment_model.dart';
import 'package:reportin/service/comment_service.dart';


class SosialComment extends StatefulWidget {
  final int sosialid;
  SosialComment({@required this.sosialid ,Key key }) : super(key: key);

  @override
  _SosialCommentState createState() => _SosialCommentState();
}

class _SosialCommentState extends State<SosialComment> {
  final _key = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  CommentApiService apiService;
  String commentIsi, nama;
  

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nama = preferences.getString("nama");
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
    apiService = CommentApiService();
  }

  _showSnackBar(message){
    final snackbar = SnackBar(content: Text(message),);
    _scaffoldkey.currentState.showSnackBar(snackbar);
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: _scaffoldkey,
        title: Text("Comment"),
      ),
      body: FutureBuilder(
        future: apiService.getSosialCommentBy(widget.sosialid),
        builder: (BuildContext context, AsyncSnapshot<List<Comment>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<Comment> comment = snapshot.data;
            return Column(
              children: [
                Expanded(
                  child: _buildListView(comment),
                ),
                Divider(),
                Form(
                  key: _key,
                  child: ListTile(
                    title: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Kolom komentar"
                      ),
                      validator: (value){
                        if (value.isEmpty){
                          return "kolom harus diisi";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (String value){
                        commentIsi = value;
                      },
                    ),
                    trailing: OutlinedButton(
                      onPressed: (){
                        final form = _key.currentState;
                        if (form.validate()){
                          form.save();
                          Comment data = Comment();

                          data.commentIsi = commentIsi;
                          data.commentSosial = widget.sosialid.toString();
                          data.nama = nama;
                          print(data);

                          final onSuccess = (Object success) => Navigator.pop(context,"data disimpan");
                          final onError = (Object error) => _showSnackBar("Tidak bisa simpan data");

                          apiService.postCommentSosial(data).then(onSuccess).catchError(onError);
                        } else {
                          final onError = (Object error) => _showSnackBar("form tidak boleh kosong");
                          return onError;
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide.none,
                      ),
                      child: Text("kirim"),
                    ),
                  ),
                )
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )
    );
  }

  Widget _buildListView(List<Comment> comment) {
    return comment==null ? Center(child: Text('Empty')) : ListView.separated(
      separatorBuilder: (BuildContext context, int x) => Divider(color: Colors.grey[400]),
      itemCount: comment.length,
      itemBuilder: (context, index) {
        Comment c = comment[index];
        return ListTile(
          leading: Icon(Icons.person, size: 50, color: Colors.blue[900],),
          title: Text(c.commentIsi, style: TextStyle(fontWeight: FontWeight.bold), ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(c.nama, style: TextStyle(fontSize: 12),),
              Text(c.tglKomen, style: TextStyle(fontSize: 10))
            ],
          ),
        ); 
      },
    );
  }
}