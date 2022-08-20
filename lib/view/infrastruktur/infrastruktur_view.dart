import 'package:flutter/material.dart';
import 'package:reportin/service/infrastruktur_service.dart';
import 'package:reportin/model/infrastruktur_model.dart';
import 'package:reportin/view/infrastruktur/infrastruktur_detail.dart';

class InfrastrukturList extends StatefulWidget {
  @override
  _InfrastrukturListState createState() => _InfrastrukturListState();
}

class _InfrastrukturListState extends State<InfrastrukturList> with SingleTickerProviderStateMixin{
  InfrastrukturApiService apiService;
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
    apiService = InfrastrukturApiService();
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
      future: apiService.getInfrastrukturBaru(),
      builder: (BuildContext context, AsyncSnapshot<List<Infrastruktur>> snapshot) {
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
          final List<Infrastruktur> infrastruktur = snapshot.data;
          if (infrastruktur != null){
            return ListView.separated(
              separatorBuilder: (BuildContext context, int x) => Divider(color: Colors.grey[400]),
              itemCount: infrastruktur.length,
              itemBuilder: (context, index) {
                Infrastruktur i = infrastruktur[index];
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
                    ],),
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
      future: apiService.getInfrastrukturDiterima(),
      builder: (BuildContext context, AsyncSnapshot<List<Infrastruktur>> snapshot) {
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
          final List<Infrastruktur> infrastruktur = snapshot.data;
          if (infrastruktur != null){
            return ListView.separated(
              separatorBuilder: (BuildContext context, int x) => Divider(color: Colors.grey[400]),
              itemCount: infrastruktur.length,
              itemBuilder: (context, index) {
                Infrastruktur i = infrastruktur[index];
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
                    ],),
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
      future: apiService.getInfrastrukturDiproses(),
      builder: (BuildContext context, AsyncSnapshot<List<Infrastruktur>> snapshot) {
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
          final List<Infrastruktur> infrastruktur = snapshot.data;
          if (infrastruktur != null){
            return ListView.separated(
              separatorBuilder: (BuildContext context, int x) => Divider(color: Colors.grey[400]),
              itemCount: infrastruktur.length,
              itemBuilder: (context, index) {
                Infrastruktur i = infrastruktur[index];
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
                    ],),
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
      future: apiService.getInfrastrukturSelesai(),
      builder: (BuildContext context, AsyncSnapshot<List<Infrastruktur>> snapshot) {
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
          final List<Infrastruktur> infrastruktur = snapshot.data;
          if (infrastruktur != null){
            return ListView.separated(
              separatorBuilder: (BuildContext context, int x) => Divider(color: Colors.grey[400]),
              itemCount: infrastruktur.length,
              itemBuilder: (context, index) {
                Infrastruktur i = infrastruktur[index];
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
                    ],),
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