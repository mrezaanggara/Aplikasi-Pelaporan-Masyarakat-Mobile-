import 'dart:convert';
import 'package:reportin/model/priority_model.dart';
import 'package:http/http.dart' as http;

class PrioritasApiService{
  //bahaya
  Future<Prioritas> getPrioritasBahayaCount(int bahayaid) async {
    String apiUrl = "https://reportcases.000webhostapp.com/api/priority/countbahaya?content_bahaya="+ bahayaid.toString();
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200){
      return Prioritas.fromJson(json.decode(response.body)['data']);
    } else {
      return null;
    }
  }
  Future<bool> postPrioritasBahaya(Prioritas data) async {
    final response = await http.post(Uri.parse("https://reportcases.000webhostapp.com/api/priority/bahaya"),
    body: {
      "nik" : data.nik.toString(),
      "content_bahaya": data.contentBahaya.toString(),
      }
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
  Future<bool> deletePrioritasBahaya(Prioritas data) async {
    final response = await http.post(Uri.parse("https://reportcases.000webhostapp.com/api/priority/bahayadelete"),
    body: {
      "nik" : data.nik.toString(),
      "content_bahaya": data.contentBahaya.toString(),
      }
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
  //infra
  Future<Prioritas> getPrioritasInfraCount(int infrastrukturid) async {
    String apiUrl = "https://reportcases.000webhostapp.com/api/priority/countinfra?content_infra="+ infrastrukturid.toString();
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200){
      return Prioritas.fromJson(json.decode(response.body)['data']);
    } else {
      return null;
    }
  }
  Future<bool> postPrioritasInfra(Prioritas data) async {
    final response = await http.post(Uri.parse("https://reportcases.000webhostapp.com/api/priority/infra"),
    body: {
      "nik" : data.nik.toString(),
      "content_infra": data.contentInfra.toString(),
      }
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
  Future<bool> deletePrioritasInfra(Prioritas data) async {
    final response = await http.post(Uri.parse("https://reportcases.000webhostapp.com/api/priority/infradelete"),
    body: {
      "nik" : data.nik.toString(),
      "content_infra": data.contentInfra.toString(),
      }
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
  //sosial
  Future<Prioritas> getPrioritasSosialCount(int sosialid) async {
    String apiUrl = "https://reportcases.000webhostapp.com/api/priority/countsosial?content_sosial="+ sosialid.toString();
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200){
      return Prioritas.fromJson(json.decode(response.body)['data']);
    } else {
      return null;
    }
  }
  Future<bool> postPrioritasSosial(Prioritas data) async {
    final response = await http.post(Uri.parse("https://reportcases.000webhostapp.com/api/priority/sosial"),
    body: {
      "nik" : data.nik.toString(),
      "content_sosial": data.contentSosial.toString(),
      }
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
  Future<bool> deletePrioritasSosial(Prioritas data) async {
    final response = await http.post(Uri.parse("https://reportcases.000webhostapp.com/api/priority/sosialdelete"),
    body: {
      "nik" : data.nik.toString(),
      "content_sosial": data.contentSosial.toString(),
      }
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

}