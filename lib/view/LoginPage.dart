import 'dart:convert';
import 'package:reportin/view/WebView.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:reportin/view/FrontPage.dart';
import 'package:flutter/material.dart';
import 'package:reportin/model/auth_model.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

enum LoginStatus{
  notSignIn,
  signIn
}

class _LoginPageState extends State<LoginPage> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  String nik;
  final _key = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  bool _secureText = true;

  showHide(){
    setState(() {
        _secureText = !_secureText;
    });
  }
  
  check(){
    final form = _key.currentState;
    if (form.validate()){
      form.save();
      proccesLogin();
    }
  }

  void proccesLogin()async{
    String apiURL = "https://testing.wonodadi.id/kependudukan/nik/";
    final response = await http.get(Uri.parse(apiURL+nik));
    final params = Auth.fromJson(json.decode(response.body));
    
    if(params.status == "success"){
      int value = 1 ;
      String message = "Berhasil Login";
      String userID = params.data.id;
      String nama = params.data.nama;
      String nik = params.data.nik;
      String jk = params.data.jk;
      String tempatLahir = params.data.tempatLahir;
      String tanggalLahir = params.data.tanggalLahir;
      String alamat = params.data.alamatTt;
      String pekerjaan = params.data.pekerjaan;
      String dusun = params.data.dusun;
      String regis = params.data.tglRegister;    
      final snackbar = SnackBar(content: Text(message),);
      _scaffoldkey.currentState.showSnackBar(snackbar);
      await Future.delayed(Duration(seconds: 2));
      print(message);
      print(value);
      setState(() {
        _loginStatus = LoginStatus.signIn;
        savePref(value, userID, nama, nik, jk, alamat, pekerjaan, dusun, regis, tempatLahir, tanggalLahir);
      });      
    }else if(params.status == "error"){
      String message = "NIK yang anda masukkan salah atau tidak terdaftar!";
      final snackbar = SnackBar(content: Text(message),);
      _scaffoldkey.currentState.showSnackBar(snackbar);
      print(message);
    }   
  }

  savePref(int value, String userID, String nama, String nik, String jk, String alamat, String pekerjaan, String dusun, String regis, String tempatLahir, String tanggalLahir) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setString("userID", userID);
      preferences.setString("nama", nama);
      preferences.setString("nik", nik);
      preferences.setString("jk", jk);
      preferences.setString("alamat", alamat);
      preferences.setString("pekerjaan", pekerjaan);
      preferences.setString("dusun", dusun);      
      preferences.setString("tempatLahir", tempatLahir);
      preferences.setString("tanggalLahir", tanggalLahir);
      preferences.setString("regis", regis);
      // ignore: deprecated_member_use
      preferences.commit();
    });
  }
  
  var value, userID, nama, jk, alamat, pekerjaan, dusun, regis, tempatLahir, tanggalLahir;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");
      userID = preferences.getString("userID");
      nama = preferences.getString("nama");
      nik = preferences.getString("nik");
      jk = preferences.getString("jk");
      alamat = preferences.getString("alamat");
      pekerjaan = preferences.getString("pekerjaan");
      dusun = preferences.getString("dusun");
      tempatLahir = preferences.getString("tempatLahir");
      tanggalLahir = preferences.getString("tanggalLahir");
      regis = preferences.getString("regis");
      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;      
    });
  }

  @override
  void initState(){
    super.initState();
    getPref();
  }

  
  Widget build(BuildContext context) {
    switch (_loginStatus){
      case LoginStatus.notSignIn:
      return Scaffold(
        key: _scaffoldkey,
        body: Form(
          key: _key,        
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              SizedBox(height: 40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        textStyle: TextStyle(color: Colors.black),
                        backgroundColor: Colors.blue[900],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                        )
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return SIAPweb();
                        }));
                      },
                      icon: Icon(Icons.web_outlined, color: Colors.white,),
                      label: Text("SIAP Wonodadi", style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.orange[400])),
                    ),
                  ),
                  Image.asset('assets/images/logo_pekon.png',scale: 5,),
                ],
              ),
              SizedBox(height: 40.0),
              Image.asset('assets/images/appicon2.png',scale: 3,),
              Text(
                "Aplikasi Pelaporan Masyarakat",
                textAlign: TextAlign.center ,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange[400]),
              ),
              SizedBox(height: 50.0),
              TextFormField(
                // ignore: missing_return
                validator: (e){
                  if (e.isEmpty){
                    return "Masukkan NIK anda untuk Login";
                  }
                },
                onSaved: (e)=>nik = e,
                keyboardType: TextInputType.text,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: '16 digit KTP',
                  labelText: "Nomor Induk Kependudukan",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0))
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: TextButton(
                  onPressed: () {
                  check();
                },
                style: TextButton.styleFrom(
                  textStyle: TextStyle(color: Colors.black),
                  backgroundColor: Colors.blue[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                  )
                ),
                child: Text("Login", style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.orange[400])),
                ),
              ),
              SizedBox(height: 50.0),
              Text('*Aplikasi ini Khusus untuk Daerah Pekon Wonodadi',textAlign: TextAlign.center, style: TextStyle(fontSize: 11),),
              Text('Jika NIK tidak dapat Login harap hubungi Admin Pekon',textAlign: TextAlign.center, style: TextStyle(fontSize: 11),)              
            ],
          )
        ),
      );
      break;
      case LoginStatus.signIn:
      return FrontPage();
    }
    return null;
  } 
}