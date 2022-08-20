import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  bool isPressed = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tentang"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 5),
          ListTile(
            title: Text('Aplikasi Pelaporan Masyarakat', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),),
          ),
          ListTile(
            subtitle: Text('Merupakan sebuah Aplikasi Pelaporan berbasis Mobile dengan tujuan yaitu "Mempermudah masyarakat dalam memberikan laporan pengaduan terkait permasalahan yang terjadi secara langsung kepada perangkat desa".',
            textAlign: TextAlign.justify,),
          ),
          SizedBox(height: 5),
          ListTile(
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Terdapat 3 jenis laporan yaitu:"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Icon(Icons.people_alt_rounded,size: 100,color: Colors.greenAccent[700]),
                        Text('Sosial')
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.house_rounded,size: 100,color: Colors.orange[700]),
                        Text('Infrastruktur')
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.warning_rounded,size: 100,color: Colors.redAccent[700],),
                        Text('Bahaya')
                      ],
                    ),
                ],)
              ],
            ),
          ),
          SizedBox(height: 5),
          ListTile(
            subtitle: Text('Pengguna dapat membuat laporan secara Real-Time dengan memberikan lampiran berupa gambar melalui kamera dan juga menampilkan lokasi berdasarkan laporan tersebut dibuat.',
            textAlign: TextAlign.justify),
          ),
          SizedBox(height: 5),
          ListTile(
            subtitle: Text('Aplikasi ini merupakan wujud pengabdian Universitas Lampung sebagai Institut Perguruan Tinggi Negeri kepada Provinsi Lampung, Khusunya Kabupaten Pringsewu - Pekon Wonodadi.',
            textAlign: TextAlign.justify),
          ),
          SizedBox(height: 10),
          ListTile(
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Image.asset('assets/images/logo_pekon.png',scale: 3,),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset('assets/images/logo_unila.png',scale: 13,),
                      ],
                    ),
                ],)
              ],
            ),
          ),
          SizedBox(height: 10),
          ListTile(
            subtitle: Text('Diharapkan dengan adanya Aplikasi Pelaporan Masyarakat dapat membantu dan memudahkan Masyarakat Desa dalam memberikan laporan pengaduan sehingga dapat menjadi acuan dalam Pembangunan Desa dan Peningkatan Pelayanan Publik.',
            textAlign: TextAlign.justify),
          ),
          SizedBox(height: 60),
          Text('Copyright © Aplikasi Pelaporan Masyarakat 2022',textAlign: TextAlign.center, style: TextStyle(fontSize: 10),)
        ],
      )
    );
  }
}