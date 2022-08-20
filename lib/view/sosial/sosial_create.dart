import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:reportin/service/sosial_service.dart';
import 'package:reportin/model/sosial_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reportin/service/location_service.dart';

class SosialForm extends StatefulWidget {
  @override
  _SosialFormState createState() => _SosialFormState();
}

class _SosialFormState extends State<SosialForm> {
  SosialApiService apiService;
  final _key = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  File _gambarFile;
  String nik, nama, judul, deskripsi, alamat;
  double longitude, latitude;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nama = preferences.getString('nama');
      nik = preferences.getString('nik');
    });
  }

  _getImage() async {
    var gambar = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxHeight: 1920.0,
      maxWidth: 1080.0
    );
    setState(() {
      _gambarFile = File(gambar.path);
    });
  }

  @override
  void initState(){
    super.initState();
    getPref();
    apiService = SosialApiService();
  }

  _showSnackBar(message){
    final snackbar = SnackBar(content: Text(message),);
    _scaffoldkey.currentState.showSnackBar(snackbar);
  }

  Widget build(BuildContext context) {
    var placeholder = Container(
      width: double.infinity,
      height: 150.0,
      child: Icon(Icons.add_a_photo, size: 50),
    );
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text("Form Laporan Sosial"),
      ),
      body: Form(
        key: _key,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget> [
            SizedBox(height: 10.0),
            TextFormField(
              readOnly: true,
              controller: TextEditingController(text: '$nama'),
              onSaved: (String value){
                nama = value;
              },
              decoration: new InputDecoration(
                hintText: "masukan nama lengkap anda",
                labelText: "Nama Lengkap",
                icon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(15.0)
                ),
              ),
            ),
            SizedBox(height: 25.0),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return "Perihal Laporan harus diisi";
                }
                return null;                
              },
              onSaved: (String value){
                judul = value;
              },
              decoration: new InputDecoration(
                hintText: "Perihal Laporan",
                labelText: "Perihal Laporan",
                icon: Icon(Icons.title),
                border: OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(15.0)
                ),
              ),
            ),
            SizedBox(height: 25.0),
            TextFormField(
              maxLines: 5,
              validator: (value) {
                if (value.isEmpty) {
                  return "Deskripsi harus diisi";
                }
                return null;                
              },
              onSaved: (String value){
                deskripsi = value;
              },
              decoration: new InputDecoration(
                hintText: "Deskripsi Laporan anda",
                labelText: "Deskripsi Laporan",
                icon: Icon(Icons.text_snippet_outlined),
                border: OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(15.0)
                ),
              ),
            ),
            Visibility(
              visible: true,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget> [
                  FutureBuilder(
                    future: LocationService().getLat(),
                    builder: (context,snapshot){
                      if(snapshot.hasData){
                        latitude = snapshot.data;                  
                        return Text("lat = "+latitude.toString());
                      } else {
                        return Text("Getting Latitude");
                      }
                    },
                  ),
                  FutureBuilder(
                    future: LocationService().getLong(),
                    builder: (context,snapshot){
                      if(snapshot.hasData){
                        longitude = snapshot.data;                  
                        return Text("long = "+longitude.toString());
                      } else {
                        return Text("Getting Longitude");
                      }
                    },
                  ),
                ],
              )
            ),
            SizedBox(height: 25.0),
            FutureBuilder(
              future: LocationService().getCoordinate(),
              builder: (context,snapshot){
                if (snapshot.hasData){
                  return TextFormField(
                    initialValue: snapshot.data.toString(),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Alamat harus diisi";
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      alamat = value;
                    },
                    decoration: new InputDecoration(
                      hintText: "Alamat",
                      labelText: "Alamat Laporan",
                      icon: Icon(Icons.location_on),
                      border: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(15.0)
                      ),
                    ),
                  );
                } else {
                  return Text("Loading Address");
                }
              },
            ),
            SizedBox(height: 25.0),
            Text('Ambil Gambar',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              width: double.infinity,
              height: 150.0,
              child: InkWell(
                onTap: (){
                  _getImage();
                },
                child: _gambarFile == null
                    ? placeholder
                    : Image.file(
                      _gambarFile,
                      fit: BoxFit.fill
                    ),
              ),
            ),
            SizedBox(height: 25.0),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed:() {
                  final form = _key.currentState;
                  if (form.validate() && _gambarFile != null){
                    form.save();
                    Sosial data = Sosial();

                    data.nik = '$nik';
                    data.nama = nama;
                    data.judul = judul;
                    data.deskripsi = deskripsi;
                    data.alamat = alamat;
                    data.latitude = latitude;
                    data.longitude = longitude;
                    data.gambar = base64Encode(_gambarFile.readAsBytesSync());
                    print(data);

                    final onSuccess = (Object success) => Navigator.pop(context,"data disimpan");
                    final onError = (Object error) => _showSnackBar("Tidak bisa simpan data");

                    apiService.postSosial(data).then(onSuccess).catchError(onError);                    
                  } else {
                    _showSnackBar("Form dan Gambar tidak boleh kosong!");
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