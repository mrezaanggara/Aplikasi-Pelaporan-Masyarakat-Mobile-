import "dart:convert";

class Sosial {
  int sosialid;
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

  Sosial({this.sosialid,
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

  factory Sosial.fromJson(Map<String, dynamic> map) {
    return Sosial(
      sosialid: map["sosialid"],
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
    return 'Sosial{nik: $nik,nama: $nama,judul: $judul,deskripsi: $deskripsi,alamat: $alamat,latitude: $latitude,longitude: $longitude}';
  }
}

List<Sosial> sosialFromJson(String jsonData) {
  final data = json.decode(jsonData)['data'];
  return List<Sosial>.from(data.map((item) => Sosial.fromJson(item)));
}

String sosialToJson(Sosial data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}