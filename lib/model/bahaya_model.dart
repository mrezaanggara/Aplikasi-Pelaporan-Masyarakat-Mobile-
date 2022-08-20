import "dart:convert";

class Bahaya {
  int bahayaid;
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

  Bahaya({this.bahayaid,      
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

  factory Bahaya.fromJson(Map<String, dynamic> map) {
    return Bahaya(
      bahayaid: map["bahayaid"],
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
      "nama" : nama,
      "nik" : nik,
      "judul": judul, 
      "deskripsi": deskripsi, 
      "alamat": alamat,
      "latitude": latitude,
      "longitude": longitude,
    };
  }

  @override
  String toString() {
    return 'Bahaya{nik: $nik, nama: $nama,judul: $judul,deskripsi: $deskripsi,alamat: $alamat,latitude: $latitude,longitude: $longitude}';
  }
}

List<Bahaya> bahayaFromJson(String jsonData) {
  final data = json.decode(jsonData)['data'];
  return List<Bahaya>.from(data.map((item) => Bahaya.fromJson(item)));
}

String bahayaToJson(Bahaya data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}