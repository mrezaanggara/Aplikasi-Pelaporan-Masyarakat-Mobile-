import 'dart:convert';
import 'package:reportin/model/infrastruktur_model.dart';
import 'package:http/http.dart' as http;

class InfrastrukturApiService{
  Future<List<Infrastruktur>> getInfrastrukturBaru() async {
    final response = await http.get(Uri.parse("https://reportcases.000webhostapp.com/api/infrastruktur/infraBaru"));
    if (response.statusCode == 200) {
      return infrastrukturFromJson(response.body);
    } else {
      return null;
    }
  }
  Future<List<Infrastruktur>> getInfrastrukturDiterima() async {
    final response = await http.get(Uri.parse("https://reportcases.000webhostapp.com/api/infrastruktur/infraDiterima"));
    if (response.statusCode == 200) {
      return infrastrukturFromJson(response.body);
    } else {
      return null;
    }
  }
  Future<List<Infrastruktur>> getInfrastrukturDiproses() async {
    final response = await http.get(Uri.parse("https://reportcases.000webhostapp.com/api/infrastruktur/infraDiproses"));
    if (response.statusCode == 200) {
      return infrastrukturFromJson(response.body);
    } else {
      return null;
    }
  }
  Future<List<Infrastruktur>> getInfrastrukturSelesai() async {
    final response = await http.get(Uri.parse("https://reportcases.000webhostapp.com/api/infrastruktur/infraSelesai"));
    if (response.statusCode == 200) {
      return infrastrukturFromJson(response.body);
    } else {
      return null;
    }
  }
  Future<List<Infrastruktur>> getInfraSaya(String nik) async {
    final response = await http.get(Uri.parse("https://reportcases.000webhostapp.com/api/Infrastruktur/laporansaya?nik="+ nik));
    if (response.statusCode == 200) {
      return infrastrukturFromJson(response.body);
    } else {
      return null;
    }
  }
  Future<Infrastruktur> getInfraBy(int infrastrukturid) async {
    String apiURL = "https://reportcases.000webhostapp.com/api/infrastruktur?infrastrukturid="+ infrastrukturid.toString() ;
    final response = await http.get(Uri.parse(apiURL));
    if (response.statusCode == 200) {
    return Infrastruktur.fromJson(json.decode(response.body)['data']);
    } else {
      return null;
    }
  }
  Future<bool> postInfrastruktur(Infrastruktur data) async {
    final response = await http.post(Uri.parse("https://reportcases.000webhostapp.com/api/infrastruktur"),
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