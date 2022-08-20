import 'dart:convert';
import 'package:reportin/model/sosial_model.dart';
import 'package:http/http.dart' as http;

class SosialApiService{
  Future<List<Sosial>> getSosialBaru() async {
    final response = await http.get(Uri.parse("https://reportcases.000webhostapp.com/api/sosial/sosialBaru"));
    if (response.statusCode == 200) {
      return sosialFromJson(response.body);
    } else {
      return null;
    }
  }
  Future<List<Sosial>> getSosialDiterima() async {
    final response = await http.get(Uri.parse("https://reportcases.000webhostapp.com/api/sosial/sosialditerima"));
    if (response.statusCode == 200) {
      return sosialFromJson(response.body);
    } else {
      return null;
    }
  }
  Future<List<Sosial>> getSosialDiproses() async {
    final response = await http.get(Uri.parse("https://reportcases.000webhostapp.com/api/sosial/sosialDiproses"));
    if (response.statusCode == 200) {
      return sosialFromJson(response.body);
    } else {
      return null;
    }
  }
  Future<List<Sosial>> getSosialSelesai() async {
    final response = await http.get(Uri.parse("https://reportcases.000webhostapp.com/api/sosial/sosialSelesai"));
    if (response.statusCode == 200) {
      return sosialFromJson(response.body);
    } else {
      return null;
    }
  }
  Future<List<Sosial>> getSosialSaya(String nik) async {
    final response = await http.get(Uri.parse("https://reportcases.000webhostapp.com/api/Sosial/laporansaya?nik="+ nik));
    if (response.statusCode == 200) {
      return sosialFromJson(response.body);
    } else {
      return null;
    }
  }
  Future<Sosial> getSosialBy(int sosialid) async {
    String apiURL = "https://reportcases.000webhostapp.com/api/sosial?sosialid="+ sosialid.toString() ;
    final response = await http.get(Uri.parse(apiURL));
    if (response.statusCode == 200) {
      return Sosial.fromJson(json.decode(response.body)['data']);
    } else {
      return null;
    }
  }
  Future<bool> postSosial(Sosial data) async {
    final response = await http.post(Uri.parse("https://reportcases.000webhostapp.com/api/sosial"),
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