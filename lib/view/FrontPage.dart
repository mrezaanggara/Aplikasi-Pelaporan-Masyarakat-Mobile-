import 'package:flutter/material.dart';
import 'package:reportin/view/MyReport.dart';
import 'package:reportin/view/WebView.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:reportin/view/about.dart';
import 'sosial/sosial_view.dart' as sosial;
import 'infrastruktur/infrastruktur_view.dart' as infrastruktur;
import 'bahaya/bahaya_view.dart' as bahaya;
import 'users/profile.dart';
import 'LoginPage.dart';
import 'FormPage.dart';

class FrontPage extends StatefulWidget {
  @override
  _FrontPageState createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> with SingleTickerProviderStateMixin{
  TabController controller;
  String nama, nik;
  
  void signOut() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", null); 
      preferences.setInt("userID", null);
      preferences.setString("nama", null);
      preferences.setString("jk", null);
      preferences.setString("alamat", null);
      preferences.setString("pekerjaan", null);
      preferences.setString("dusun", null);      
      preferences.setString("tempatLahir", null);
      preferences.setString("tanggalLahir", null);
      preferences.setString("regis", null);
      // ignore: deprecated_member_use
      preferences.commit();  
    });
    print('berhasil logout');
  }
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nama = preferences.getString("nama");
      nik = preferences.getString("nik");        
    });
  }

  @override
  void initState() {
    controller = new TabController(length: 3, vsync: this);
    super.initState();
    getPref();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/logo_pekon.png',scale: 5,),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: TabBar(
            controller: controller,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.people_rounded, size: 25,),text: "Sosial",),
              Tab(icon: Icon(Icons.house_rounded, size: 25,),text: "Infrastruktur"),
              Tab(icon: Icon(Icons.warning_rounded, size: 25,),text: "Bahaya"),
            ],
          ),
        )
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          sosial.SosialList(),
          infrastruktur.InfrastrukturList(),
          bahaya.BahayaList(),
        ],
      ),
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width/1.2,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(color:Colors.grey[50]),
                currentAccountPicture: CircleAvatar(
                  radius: 50.0,
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: "https://reportcases.000webhostapp.com/data/images/users/default.jpg",
                      placeholder: (context, url) =>CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Text("Koneksi Error"),
                      fit: BoxFit.cover,
                    )
                  ),
                  backgroundColor: Colors.transparent,
                ),
                accountName: Text('$nama', style: TextStyle(color: Colors.black87,fontSize: 15)),
                accountEmail: Text('$nik', style: TextStyle(color: Colors.black87))
              ),
              ListTile(
                leading: Icon(Icons.person_outline),
                title: Text("Profil"),
                onTap: () {          
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return UsersProfile();
                  }));
                },                
              ),
              ListTile(
                leading: Icon(Icons.assignment_outlined),
                title: Text("Laporan Saya"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MyReport(nik: '$nik', key: ValueKey('$nik') )));
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.web_outlined),
                title: Text("SIAP Wonodadi"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return SIAPweb();
                  }));
                },
              ),
              ListTile(
                leading: Icon(Icons.info_outline),
                title: Text("Tentang"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return About();
                  }));
                },
              ),
              Divider(),
              ListTile(
                leading: null,
                title: Text("Logout"),
                trailing: Icon(Icons.logout),
                onTap: () {
                  signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
              ),
            ],
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {          
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return FormPage();
          }));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.redAccent[700]
      ),
    );
  }
}