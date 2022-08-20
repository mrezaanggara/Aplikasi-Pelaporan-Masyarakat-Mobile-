
import 'package:reportin/model/comment_model.dart';
import 'package:http/http.dart' as http;

class CommentApiService{
  //bahaya
  Future<List<Comment>> getBahayaCommentBy(int bahayaid) async {
    String apiURL = "https://reportcases.000webhostapp.com/api/comment/bahaya?comment_bahaya="+ bahayaid.toString() ;
    final response = await http.get(Uri.parse(apiURL));
    if (response.statusCode == 200) {
      return commentFromJson(response.body);
    } else {
      return null;
    }
  }
  Future<bool> postCommentBahaya(Comment data) async {
    final response = await http.post(Uri.parse("https://reportcases.000webhostapp.com/api/comment/bahaya"),
    body: {
      "nama" : data.nama,
      "comment_isi": data.commentIsi, 
      "comment_bahaya": data.commentBahaya,      
      }
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
  //infra
  Future<List<Comment>> getInfraCommentBy(int infrastrukturid) async {
    String apiURL = "https://reportcases.000webhostapp.com/api/comment/infra?comment_infra="+ infrastrukturid.toString() ;
    final response = await http.get(Uri.parse(apiURL));
    if (response.statusCode == 200) {
      return commentFromJson(response.body);
    } else {
      return null;
    }
  }
  Future<bool> postCommentInfra(Comment data) async {
    final response = await http.post(Uri.parse("https://reportcases.000webhostapp.com/api/comment/infra"),
    body: {
      "nama" : data.nama,
      "comment_isi": data.commentIsi, 
      "comment_infra": data.commentInfra,      
      }
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
  //sosial
  Future<List<Comment>> getSosialCommentBy(int sosialid) async {
    String apiURL = "https://reportcases.000webhostapp.com/api/comment/sosial?comment_sosial="+ sosialid.toString() ;
    final response = await http.get(Uri.parse(apiURL));
    if (response.statusCode == 200) {
      return commentFromJson(response.body);
    } else {
      return null;
    }
  }
  Future<bool> postCommentSosial(Comment data) async {
    final response = await http.post(Uri.parse("https://reportcases.000webhostapp.com/api/comment/sosial"),
    body: {
      "nama" : data.nama,
      "comment_isi": data.commentIsi, 
      "comment_sosial": data.commentSosial,      
      }
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}