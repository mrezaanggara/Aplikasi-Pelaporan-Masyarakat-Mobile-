import 'dart:convert';

class Infrastruktur{
  int infrastrukturid;
  String usersID;
  String nik;
  String judul;
  String deskripsi;
  String alamat;
  double latitude;
  double longitude;
  String gambar;
  String tglUpload;
  String nama;
  String ket;
  String estimasi;

  Infrastruktur({this.infrastrukturid,
      this.usersID,
      this.nik,
      this.judul,
      this.deskripsi,
      this.alamat,
      this.latitude,
      this.longitude,
      this.gambar,
      this.tglUpload,
      this.nama,
      this.ket,
      this.estimasi});

  factory Infrastruktur.fromJson(Map<String, dynamic> map){
    return Infrastruktur(
      infrastrukturid: map["infrastrukturid"],
      usersID: map["usersID"],
      nik: map["nik"],
      nama: map["nama"],
      judul: map["judul"],
      deskripsi: map["deskripsi"],
      gambar: map['gambar'],
      alamat: map["alamat"],
      latitude: map["latitude"],
      longitude: map["longitude"],
      tglUpload: map["tgl_upload"],
      ket: map['ket'],
      estimasi: map['estimasi']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "nik" : nik,
      "nama" : nama,
      "judul": judul, 
      "deskripsi": deskripsi, 
      "alamat": alamat,
      "latitude": latitude,
      "longitude": longitude,
    };
  }

  @override
  String toString() {
    return 'Infrastruktur{nik: $nik,nama: $nama,judul: $judul,deskripsi: $deskripsi,alamat: $alamat,latitude: $latitude,longitude: $longitude}';
  }
}

List<Infrastruktur> infrastrukturFromJson(String jsonData){
  final data = json.decode(jsonData)['data'];
  return List<Infrastruktur>.from(data.map((item) => Infrastruktur.fromJson(item)));
}

String infrastrukturToJson(Infrastruktur data){
  final jsonData = data.toJson();
  return json.encode(jsonData);
}