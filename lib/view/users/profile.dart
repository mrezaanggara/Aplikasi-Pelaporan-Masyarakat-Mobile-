import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UsersProfile extends StatefulWidget {
  @override
  _UsersProfileState createState() => _UsersProfileState();
}


class _UsersProfileState extends State<UsersProfile> {
  
  int value; String userID; String nama; String jk; String alamat; String pekerjaan; String dusun; String tempatLahir; String tanggalLahir; String regis;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");
      userID = preferences.getString("userID");
      nama = preferences.getString("nama");
      jk = preferences.getString("jk");
      alamat = preferences.getString("alamat");
      pekerjaan = preferences.getString("pekerjaan");
      dusun = preferences.getString("dusun");
      tempatLahir = preferences.getString("tempatLahir");
      tanggalLahir = preferences.getString("tanggalLahir");
      regis = preferences.getString("regis");    
    });
  }

  @override
  void initState(){
    super.initState();
    getPref();
  }
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil"),
        centerTitle: true,        
      ),
      body: Form(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            SizedBox(height: 20.0,),
            CircleAvatar(
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
            ListTile(
              leading: Icon(Icons.title_rounded),
              title: const Text('Nama'),
              subtitle: Text('$nama'),
            ),            
            ListTile(
              leading: Icon(Icons.date_range),
              title: const Text('Tempat/Tgl Lahir'),
              subtitle: Text('$tempatLahir,'+' $tanggalLahir'),
            ),
            ListTile(
              leading: Icon(Icons.location_city_rounded),
              title: const Text('Alamat'),
              subtitle: Text('$alamat'),
            ),
            ListTile(
              leading: Icon(Icons.person_rounded),
              title: const Text('Jenis Kelamin'),
              subtitle: Text('$jk'),
            ),
            ListTile(
              leading: Icon(Icons.security_rounded),
              title: const Text('Pekerjaan'),
              subtitle: Text('$pekerjaan'),
            ),
            ListTile(
              leading: Icon(Icons.date_range_rounded),
              title: const Text('Tanggal Bergabung'),
              subtitle: Text('$regis'),
            ),
          ],
        ),
      ),
    );
  }
}