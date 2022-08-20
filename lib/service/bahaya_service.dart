import 'dart:convert';
import 'package:reportin/model/bahaya_model.dart';
import 'package:http/http.dart' as http;

class BahayaApiService{
  Future<List<Bahaya>> getBahayaBaru() async {
    final response = await http.get(Uri.parse("https://reportcases.000webhostapp.com/api/bahaya/bahayaBaru"));
    if (response.statusCode == 200) {
      return bahayaFromJson(response.body);
    } else {
      return null;
    }
  }
  Future<List<Bahaya>> getBahayaDiterima() async {
    final response = await http.get(Uri.parse("https://reportcases.000webhostapp.com/api/bahaya/bahayaDiterima"));
    if (response.statusCode == 200) {
      return bahayaFromJson(response.body);
    } else {
      return null;
    }
  }
  Future<List<Bahaya>> getBahayaDiproses() async {
    final response = await http.get(Uri.parse("https://reportcases.000webhostapp.com/api/bahaya/bahayaDiproses"));
    if (response.statusCode == 200) {
      return bahayaFromJson(response.body);
    } else {
      return null;
    }
  }
  Future<List<Bahaya>> getBahayaSelesai() async {
    final response = await http.get(Uri.parse("https://reportcases.000webhostapp.com/api/bahaya/bahayaSelesai"));
    if (response.statusCode == 200) {
      return bahayaFromJson(response.body);
    } else {
      return null;
    }
  }
  Future<List<Bahaya>> getBahayaSaya(String nik) async {
    final response = await http.get(Uri.parse("https://reportcases.000webhostapp.com/api/bahaya/laporansaya?nik="+ nik));
    if (response.statusCode == 200) {
      return bahayaFromJson(response.body);
    } else {
      return null;
    }
  }
  Future<Bahaya> getBahayaBy(int bahayaid) async {
    String apiURL = "https://reportcases.000webhostapp.com/api/bahaya?bahayaid="+ bahayaid.toString() ;
    final response = await http.get(Uri.parse(apiURL));
    if (response.statusCode == 200) {
    return Bahaya.fromJson(json.decode(response.body)['data']);
    } else {
      return null;
    }
  }
  Future<bool> postBahaya(Bahaya data) async {
    final response = await http.post(Uri.parse("https://reportcases.000webhostapp.com/api/bahaya"),
    body: {
      "nama" : data.nama,
      "nik" : data.nik,
      "judul": data.judul, 
      "deskripsi": data.deskripsi, 
      "alamat": data.alamat,
      "latitude": data.latitude.toString(),
      "longitude": data.longitude.toString(),
      "gambar": data.gambar,
      }
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}