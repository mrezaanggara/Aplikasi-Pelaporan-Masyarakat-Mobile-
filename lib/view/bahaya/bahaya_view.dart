import 'package:flutter/material.dart';
import 'package:reportin/service/bahaya_service.dart';
import 'package:reportin/model/bahaya_model.dart';
import 'package:reportin/view/bahaya/bahaya_detail.dart';

class BahayaList extends StatefulWidget {
  @override
  _BahayaListState createState() => _BahayaListState();
}

class _BahayaListState extends State<BahayaList> with SingleTickerProviderStateMixin{
  BahayaApiService apiService;
  TabController controller;
  
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

  @override
  void initState() {
    super.initState();
    apiService = BahayaApiService();
    controller = TabController(length: 4, vsync: this);
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
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          title: TabBar(
            controller: controller,
            tabs: [
              Tab(text: "Baru",),
              Tab(text: "Diterima",),
              Tab(text: "Diproses",),
              Tab(text: "Selesai",)
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          _laporanBaru(),
          _laporanDiterima(),
          _laporanDiproses(),
          _laporanSelesai(),
        ]
      )
    );
  }

  Widget _laporanBaru() {
    return FutureBuilder(
      future: apiService.getBahayaBaru(),
      builder: (BuildContext context, AsyncSnapshot<List<Bahaya>> snapshot) {
        if (snapshot.hasError) {
          return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/database.png', scale: 5),
                  SizedBox(height:20),
                  Text("Server sedang bermasalah.")
                ],
              ),
            );
        } else if (snapshot.connectionState == ConnectionState.done) {
          final List<Bahaya> bahaya = snapshot.data;
          if (bahaya != null){
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
              },
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/no_data.jpg', scale: 6),
                  SizedBox(height:20),
                  Text("Belum ada Laporan.")
                ],
              ),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _laporanDiterima() {
    return FutureBuilder(
      future: apiService.getBahayaDiterima(),
      builder: (BuildContext context, AsyncSnapshot<List<Bahaya>> snapshot) {
        if (snapshot.hasError) {
          return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/database.png', scale: 5),
                  SizedBox(height:20),
                  Text("Server sedang bermasalah.")
                ],
              ),
            );
        } else if (snapshot.connectionState == ConnectionState.done) {
          final List<Bahaya> bahaya = snapshot.data;
          if (bahaya != null){
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
              },
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/no_data.jpg', scale: 6),
                  SizedBox(height:20),
                  Text("Belum ada Laporan.")
                ],
              ),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _laporanDiproses() {
    return FutureBuilder(
      future: apiService.getBahayaDiproses(),
      builder: (BuildContext context, AsyncSnapshot<List<Bahaya>> snapshot) {
        if (snapshot.hasError) {
          return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/database.png', scale: 5),
                  SizedBox(height:20),
                  Text("Server sedang bermasalah.")
                ],
              ),
            );
        } else if (snapshot.connectionState == ConnectionState.done) {
          final List<Bahaya> bahaya = snapshot.data;
          if (bahaya != null){
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
              },
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/no_data.jpg', scale: 6),
                  SizedBox(height:20),
                  Text("Belum ada Laporan.")
                ],
              ),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _laporanSelesai() {
    return FutureBuilder(
      future: apiService.getBahayaSelesai(),
      builder: (BuildContext context, AsyncSnapshot<List<Bahaya>> snapshot) {
        if (snapshot.hasError) {
          return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/database.png', scale: 5),
                  SizedBox(height:20),
                  Text("Server sedang bermasalah.")
                ],
              ),
            );
        } else if (snapshot.connectionState == ConnectionState.done) {
          final List<Bahaya> bahaya = snapshot.data;
          if (bahaya != null){
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
              },
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/no_data.jpg', scale: 6),
                  SizedBox(height:20),
                  Text("Belum ada Laporan.")
                ],
              ),
            );
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