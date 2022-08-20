import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:reportin/model/priority_model.dart';
import 'package:reportin/service/bahaya_service.dart';
import 'package:reportin/model/bahaya_model.dart';
import 'package:reportin/service/priority_service.dart';
import 'bahaya_comment.dart';


class DetailBahaya extends StatefulWidget {
  final int bahayaid;
  DetailBahaya({@required this.bahayaid, Key key }) : super(key: key);

  @override
  _DetailBahayaState createState() => _DetailBahayaState();
}

class _DetailBahayaState extends State<DetailBahaya> {
  BahayaApiService apiService;
  PrioritasApiService apiService2;
  Bahaya b;
  Prioritas p;
  String nik;
  bool isPressed = true;
  
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nik = preferences.getString("nik");
    });
  }

  void like() async {
    Prioritas data = Prioritas();
    data.nik = nik;
    data.contentBahaya = b.bahayaid;
    print(data);
    print("berhasil like");
    apiService2.postPrioritasBahaya(data);
  }

  void dislike() async {
    Prioritas data = Prioritas();
    data.nik = nik;
    data.contentBahaya = b.bahayaid;
    print(data);
    print("berhasil dislike");
    apiService2.deletePrioritasBahaya(data);
  }

  Color _setTextColor(String status) {
  if (status == 'Baru') {
      return Color(0xFF664d03);
    } else if (status == 'Diterima') {
      return Color(0xFF084298);
    } else if (status == 'Diproses') {
      return Color(0xFF055160);
    } else {
      return Color(0xFF0f5132);
    }
  }

  Color _setBoxColor(String status) {
  if (status == 'Baru') {
      return Color(0xFFfff3cd);
    } else if (status == 'Diterima') {
      return Color(0xFFcfe2ff);
    } else if (status == 'Diproses') {
      return Color(0xFFcff4fc);
    } else {
      return Color(0xd1e7dd);
    }
  }


  @override
  void initState() {
    super.initState();
    getPref();
    apiService = BahayaApiService();
    apiService2 = PrioritasApiService();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail laporan Bahaya"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => {
            Navigator.pop(context),
          },
        ),
      ),
      body: Center(
        child: FutureBuilder<Bahaya>(
          // panggil function getUserBy(int id)
          future: apiService.getBahayaBy(widget.bahayaid),
          builder: (context, snapshot) {
            // jika connection none atau data = null
            if (snapshot.connectionState == ConnectionState.none &&
                snapshot.hasData == null) {
              return LinearProgressIndicator();
             
            // jika connection berhasil
            } else if (snapshot.connectionState == ConnectionState.done) {
               
              // tampung data dari server
              b = snapshot.data;
 
              // jika data ada / tidak null
              if(b.bahayaid != 0){
                var placeholder = Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: _setBoxColor(b.ket),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(child: Text("Laporan dalam Status '"+b.ket+"'",style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: _setTextColor(b.ket))),)
                );
                return ListView(
                  children: <Widget>[
                    Column(
                      children: <Widget> [
                        Container(
                          height: 350,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40),
                            ),
                            child: CachedNetworkImage(
                              imageUrl:
                                  "https://reportcases.000webhostapp.com/data/docs/laporan/bahaya/${b.gambar}.jpg",
                              progressIndicatorBuilder: (context, url, downloadProgress) => 
                                  CircularProgressIndicator(value: downloadProgress.progress),
                              errorWidget: (context, url, error) => Text("Gambar gagal ditampilkan",textAlign: TextAlign.center,),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(                          
                        child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Spacer(),
                                    IconButton(
                                      icon: Icon(Icons.comment_rounded, size: 20,),
                                      onPressed: (){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (BuildContext context) => BahayaComment(bahayaid: b.bahayaid, key: ValueKey(b.bahayaid)))
                                        );
                                      }
                                    ),
                                    IconButton(
                                      icon: new Icon(isPressed
                                          ? Icons.priority_high_rounded
                                          : Icons.priority_high_rounded),
                                      color: isPressed ? Colors.black : Colors.black,
                                      onPressed: (){
                                        setState(() {
                                          isPressed =! isPressed;                                          
                                        });
                                        isPressed ? like() : dislike();                                     
                                      }
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: FutureBuilder(
                                  future: apiService2.getPrioritasBahayaCount(b.bahayaid),
                                  builder: (context,snapshot){
                                    if (snapshot.connectionState == ConnectionState.none &&
                                    snapshot.hasData == null){
                                          return LinearProgressIndicator();
                                    } else if (snapshot.connectionState == ConnectionState.done) {
                                      p = snapshot.data;
                                      if (p != null){
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "Prioritize by "+p.total.toString()+" people",
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        );
                                      } else {
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "Prioritize by 0 people",
                                              style: TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        );
                                      }
                                    } else {
                                      return Center(
                                        child: Container(),
                                      );
                                    }
                                  },
                                ),
                              ),
                              SizedBox(height: 15),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Perihal Laporan',style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),                                    
                                  ],
                                ), 
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(16,0,16,0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(b.judul,style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18)),
                                    SizedBox(height: 15,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Icon(Icons.date_range,size: 12,),
                                        Text(" "+b.tglUpload,style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
                                        Text("    "),
                                        Icon(Icons.info,size: 12,),
                                        Text(" "+b.ket,style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12,color: _setTextColor(b.ket))),
                                        
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                      Icon(Icons.person,size: 12,color: Colors.blue,),
                                      Text(" "+b.nama,style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
                                      ]
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFd2f4e8),
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: b.estimasi == "-" ? placeholder : Center(child: Text(" "+b.estimasi,style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Color(0xFF0f6848))),)
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              ListTile(
                                title: const Text('Deskripsi', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                                subtitle: Text(b.deskripsi[0].toUpperCase()+b.deskripsi.substring(1),style: TextStyle(fontSize: 15)),
                              ),
                              SizedBox(height: 5),
                              ListTile(
                                title: const Text('Lokasi', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                                subtitle: Text(b.alamat, style: TextStyle(fontSize: 15)),
                              ),
                              SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.fromLTRB(16,0,16,0),
                                height: 200,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: MapboxMap(                          
                                    initialCameraPosition: CameraPosition(
                                      target: LatLng(b.latitude,b.longitude),
                                      zoom: 15.0
                                    ),
                                  ),
                                )
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                );
              // jika data null / tidak ada
              } else {
                return Text("User Not Found");
              }
             
            // tampilkan container kosong jika terjadi hal lainnya
            } else {
              return Center(
                child: Container(),
              );
            }
          }
        ),
      ),
    );
  }
}