import 'package:flutter/material.dart';
import 'package:reportin/service/sosial_service.dart';
import 'package:reportin/model/sosial_model.dart';
import 'package:reportin/view/sosial/sosial_detail.dart';

class SosialList extends StatefulWidget {
  @override
  _SosialListState createState() => _SosialListState();
}

class _SosialListState extends State<SosialList> with SingleTickerProviderStateMixin{
  SosialApiService apiService;
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
    apiService = SosialApiService();
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
      future: apiService.getSosialBaru(),
      builder:
          (BuildContext context, AsyncSnapshot<List<Sosial>> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
                "Something wrong with message: ${snapshot.error.toString()}"),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          final List<Sosial> sosial = snapshot.data;
          if (sosial != null){
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text("Status"),
                      Text(s.ket, style: TextStyle(fontWeight: FontWeight.bold, color: _setColor(s.ket)))
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
                  Image.asset('assets/images/database.png', scale: 5),
                  SizedBox(height:20),
                  Text("Server sedang bermasalah.")
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
      future: apiService.getSosialDiterima(),
      builder:
          (BuildContext context, AsyncSnapshot<List<Sosial>> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
                "Something wrong with message: ${snapshot.error.toString()}"),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          final List<Sosial> sosial = snapshot.data;
          if (sosial != null){
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text("Status"),
                      Text(s.ket, style: TextStyle(fontWeight: FontWeight.bold, color: _setColor(s.ket)))
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
                  Image.asset('assets/images/database.png', scale: 5),
                  SizedBox(height:20),
                  Text("Server sedang bermasalah.")
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
      future: apiService.getSosialDiproses(),
      builder:
          (BuildContext context, AsyncSnapshot<List<Sosial>> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
                "Something wrong with message: ${snapshot.error.toString()}"),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          final List<Sosial> sosial = snapshot.data;
          if (sosial != null){
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text("Status"),
                      Text(s.ket, style: TextStyle(fontWeight: FontWeight.bold, color: _setColor(s.ket)))
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
                  Image.asset('assets/images/database.png', scale: 5),
                  SizedBox(height:20),
                  Text("Server sedang bermasalah.")
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
      future: apiService.getSosialSelesai(),
      builder:
          (BuildContext context, AsyncSnapshot<List<Sosial>> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
                "Something wrong with message: ${snapshot.error.toString()}"),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          final List<Sosial> sosial = snapshot.data;
          if (sosial != null){
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text("Status"),
                      Text(s.ket, style: TextStyle(fontWeight: FontWeight.bold, color: _setColor(s.ket)))
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
                  Image.asset('assets/images/database.png', scale: 5),
                  SizedBox(height:20),
                  Text("Server sedang bermasalah.")
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
