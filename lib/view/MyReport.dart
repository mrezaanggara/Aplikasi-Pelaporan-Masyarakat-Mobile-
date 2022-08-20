import 'package:flutter/material.dart';
import 'package:reportin/model/bahaya_model.dart';
import 'package:reportin/model/infrastruktur_model.dart';
import 'package:reportin/model/sosial_model.dart';
import 'package:reportin/service/bahaya_service.dart';
import 'package:reportin/service/infrastruktur_service.dart';
import 'package:reportin/service/sosial_service.dart';
import 'package:reportin/view/bahaya/bahaya_detail.dart';
import 'package:reportin/view/infrastruktur/infrastruktur_detail.dart';
import 'package:reportin/view/sosial/sosial_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyReport extends StatefulWidget {
  final String nik;
  MyReport({@required this.nik, Key key }) : super(key: key);

  @override
  State<MyReport> createState() => _MyReportState();
}

class _MyReportState extends State<MyReport> with SingleTickerProviderStateMixin{
  BahayaApiService apiService1;
  InfrastrukturApiService apiService2;
  SosialApiService apiService3;
  TabController controller;
  String nik;

  Color _setColor(String status) {
  if (status == 'Baru') {
      return Color(0xFFf6c23e);
    } else if (status == 'Diterima') {
      return Color(0xFF4e73df);
    } else if (status == 'Diproses') {
      return Color(0xFF36b9cc);
    } else {
      return Color(0xFF1cc88a);
    }
  }

  getPref() async {
    SharedPreferences preferences =  await SharedPreferences.getInstance();
    setState(() {
      nik = preferences.getString('nik');
    });
  }

  @override
  void initState() {
    super.initState();
    apiService1 = BahayaApiService();
    apiService2 = InfrastrukturApiService();
    apiService3 = SosialApiService();
    getPref();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          title: Text("Laporan Saya"),
          centerTitle: true,
          bottom: TabBar(
            controller: controller,
            tabs: [
              Tab(text: "Sosial"),
              Tab(text: "Infrastruktur"),
              Tab(text: "Bahaya")
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          _laporanSosial(),
          _laporanInfra(),
          _laporanBahaya()
        ],
      ),
    );
  }

  Widget _laporanSosial() {
    return FutureBuilder(
      future: apiService3.getSosialSaya(widget.nik),
      builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.none && snapshot.hasData == null){
          return LinearProgressIndicator();
        } else if (snapshot.connectionState == ConnectionState.done) {
          List<Sosial> sosial = snapshot.data;
          if(sosial != null){
            return ListView.separated(
              separatorBuilder: (BuildContext context, int x) => Divider(color: Colors.grey[400]), 
              itemCount: sosial.length, 
              itemBuilder: (context, index) {
                Sosial s = sosial[index];
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) => DetailSosial(sosialid: s.sosialid, key: ValueKey(s.sosialid)))
                    );
                  },
                  leading: Icon(Icons.people_rounded, size: 50,color: Colors.greenAccent[700]),
                  title: Text(s.judul, style: TextStyle(fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                  subtitle: Text(s.nama),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text("Status"),
                      Text(s.ket, style: TextStyle(fontWeight: FontWeight.bold, color: _setColor(s.ket)))
                    ],
                  ),
                ); 
              }
            );
          } else {
            return Text('Tidak ada Laporan', textAlign: TextAlign.center,);
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _laporanInfra() {
    return FutureBuilder(
      future: apiService2.getInfraSaya(widget.nik),
      builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData == null){
          return LinearProgressIndicator();
        } else if (snapshot.connectionState == ConnectionState.done) {
          List<Infrastruktur> infra = snapshot.data;
          if(infra != null){
            return ListView.separated(
              separatorBuilder: (BuildContext context, int x) => Divider(color: Colors.grey[400]), 
              itemCount: infra.length, 
              itemBuilder: (context, index) {
                Infrastruktur i = infra[index];
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) => DetailInfra(infrastrukturid: i.infrastrukturid, key: ValueKey(i.infrastrukturid)))
                    );
                  },
                  leading: Icon(Icons.house_rounded, size: 50, color: Colors.orange[400],),
                  title: Text(i.judul, style: TextStyle(fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                  subtitle: Text(i.nama),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text("Status"),
                      Text(i.ket, style: TextStyle(fontWeight: FontWeight.bold, color: _setColor(i.ket)))
                    ],
                  ),
                ); 
              }
            );
          } else {
            return Text('Tidak ada Laporan', textAlign: TextAlign.center,);
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _laporanBahaya() {
    return FutureBuilder(
      future: apiService1.getBahayaSaya(widget.nik),
      builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData == null){
          return LinearProgressIndicator();
        } else if (snapshot.connectionState == ConnectionState.done) {
          List<Bahaya> bahaya = snapshot.data;
          if(bahaya != null){
            return ListView.separated(
              separatorBuilder: (BuildContext context, int x) => Divider(color: Colors.grey[400]), 
              itemCount: bahaya.length, 
              itemBuilder: (context, index) {
                Bahaya b = bahaya[index];
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) => DetailBahaya(bahayaid: b.bahayaid, key: ValueKey(b.bahayaid)))
                    );
                  },
                  leading: Icon(Icons.warning_rounded, size: 50, color: Colors.redAccent[700],),
                  title: Text(b.judul, style: TextStyle(fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                  subtitle: Text(b.nama),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text("Status"),
                      Text(b.ket, style: TextStyle(fontWeight: FontWeight.bold, color: _setColor(b.ket)))
                    ],
                  ),
                ); 
              }
            );
          } else {
            return Text('Tidak ada Laporan', textAlign: TextAlign.center,);
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}