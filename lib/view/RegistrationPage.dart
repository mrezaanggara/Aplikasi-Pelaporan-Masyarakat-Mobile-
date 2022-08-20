
import "package:flutter/material.dart";
import 'package:reportin/model/user_model.dart';
import 'package:reportin/service/auth_service.dart';


class RegistrationPage extends StatefulWidget { 
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  AuthApiService apiService;
  final _key = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String _nik, _username, _password, _nama, jk, _noTlp, _alamatTt, fotodiri, ktp;
  
  bool _secureText = true;

  showHide(){
    setState(() {
        _secureText = !_secureText;
    });
  }

  @override
  void initState(){
    super.initState();
    apiService = AuthApiService();
  }

  _showSnackBar(message){
    final snackbar = SnackBar(content: Text(message),);
    _scaffoldkey.currentState.showSnackBar(snackbar);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text("Registrasi Akun"),
      ),
      body: Form(
        key: _key,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[            
            SizedBox(height: 10.0),
            TextFormField(
              validator: (value){
                if (value.isEmpty){
                  return "isi username";
                }
                return null;
              },
              onSaved: (String value) { _username = value;},
              decoration: InputDecoration(
                hintText: 'Username',
                icon: Icon(Icons.person)
              ),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              validator: (value){
                if (value.isEmpty){
                  return "isi password";
                }
                return null;
              },
              onSaved: (String value){ _password = value;},
              obscureText: _secureText,
              decoration: InputDecoration(
                hintText: 'Password',
                icon: Icon(Icons.security),
                suffixIcon: IconButton(
                  onPressed:  showHide,
                  icon:Icon(_secureText ? Icons.visibility : Icons.visibility_off)
                ),
              ),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              validator: (value) {
                if (value.isEmpty){
                  return "isi nik sesuai ktp";
                }
                return null;
              },
              onSaved: (String value){_nik = value;},
              decoration: InputDecoration(
                hintText: 'NIK sesuai KTP',
                icon: Icon(Icons.credit_card)
              ),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              validator: (value){
                if (value.isEmpty){
                  return "isi nama sesuai ktp";
                }
                return null;
              },
              onSaved: (String value){_nama = value;},
              decoration: InputDecoration(
                hintText: 'Nama sesuai KTP',
                icon: Icon(Icons.text_fields)
              ),
            ),SizedBox(height: 10.0),
            TextFormField(
              validator: (value){
                if (value.isEmpty){
                  return "isi alamat sesuai ktp";
                }
                return null;
              },
              onSaved: (value) => _alamatTt = value,
              decoration: InputDecoration(
                hintText: 'Alamat sesuai KTP',
                icon: Icon(Icons.location_city)
              ),
            ),SizedBox(height: 10.0),
            TextFormField(
              validator: (value){
                if (value.isEmpty){
                  return "isi no telepon";
                }
                return null;
              },
              onSaved: (String value){_noTlp = value;},
              decoration: InputDecoration(
                hintText: 'No Telepon',
                icon: Icon(Icons.phone)
              ),
            ),
            SizedBox(height: 25.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
              Text('Jenis Kelamin', style: TextStyle(fontWeight: FontWeight.bold),),
              Text('Laki-laki'),
              Radio(
                  value: '1',
                  groupValue: jk,
                  onChanged:  (value) {
                    setState(() {
                      jk = value;
                    });
                  },
                ),
                Text('Perempuan'),
                Radio(
                    value: '2',
                    groupValue: jk,
                    onChanged:  (value) {
                      setState(() {
                        jk = value;
                      });
                    },
                  )
              ],              
            ),
            SizedBox(height: 25.0),
            Text('Foto KTP',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            IconButton(              
              onPressed: (){},
              tooltip: 'Ambil Gambar',
              icon: Icon(Icons.add_a_photo, size: 50),
            ),
            SizedBox(height: 25.0),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed:() {
                  final form = _key.currentState;
                  if (form.validate()){
                    form.save();
                    User data = User();
                    
                    data.username = _username;
                    data.password = _password;
                    data.nik = _nik;
                    data.nama = _nama;
                    data.alamat_tt = _alamatTt;
                    data.no_tlp = _noTlp;
                    data.jkID = jk;
                    print(data);

                    final onSuccess = (Object success) => Navigator.pop(context,"data disimpan");
                    final onError = (Object error) => _showSnackBar("Tidak bisa simpan data");

                    apiService.postUsers(data).then(onSuccess).catchError(onError);                    
                  }
                },child: Text("Submit"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}