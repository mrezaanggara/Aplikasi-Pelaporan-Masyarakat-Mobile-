import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:reportin/model/user_model.dart';

class AuthApiService{
  Future<User> login(String username, String password) async {
    String apiURL = "http://10.20.36.221/rest-api/api/login";
    final response = await http.post(Uri.parse(apiURL), body: {
      "username" : username,
      "password" : password
    });
    if (response.statusCode == 200) {
    return User.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }
  Future<bool> postUsers(User data) async {
    final response = await http.post(Uri.parse("http://10.20.36.221/rest-api/api/users"),
    body: {
      "username" : data.username,
      "password": data.password, 
      "nik": data.nik, 
      "nama": data.nama,
      "alamat_tt": data.alamat_tt,
      "no_tlp": data.no_tlp,
      "jkID": data.jkID
      }
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}