import "dart:convert";

class User {
  int usersID;
  String nik;
  String nama;
  String username;
  String password;
  String jkID;
  String jk;
  String no_tlp;
  String alamat_tt;
  String fotodiri;
  String ktp;
  String tglRegister;
  String role;

  User({this.usersID,
      this.nik,
      this.nama,
      this.username,
      this.password,
      this.jkID,
      this.jk,
      this.no_tlp,
      this.alamat_tt,
      this.fotodiri,
      this.ktp,
      this.tglRegister,
      this.role});

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      usersID : map['usersID'],
      nik : map['nik'],
      nama : map['nama'],
      username : map['username'],
      password : map['password'],
      jkID : map['jkID'],
      jk : map['jk'],
      no_tlp : map['no_tlp'],
      alamat_tt : map['alamat_tt'],
      fotodiri : map['foto_diri'],
      ktp : map['ktp'],
      tglRegister : map['tgl_register'],
      role : map['role'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "nik" : nik,
      "nama": nama, 
      "username": username, 
      "password": password,
      "no_tlp": no_tlp,
      "alamat_tt": alamat_tt,
      "jkID": jkID,
    };
  }
   @override
  String toString() {
    return 'User{nik: $nik,nama: $nama,username: $username,password: $password,no_telp: $no_tlp ,jkID: $jkID,alamat: $alamat_tt}';
  }
  
}

List<User> userFromJson(String jsonData) {
  final data = json.decode(jsonData)['data'];
  return List<User>.from(data.map((item) => User.fromJson(item)));
}

String userToJson(User data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}