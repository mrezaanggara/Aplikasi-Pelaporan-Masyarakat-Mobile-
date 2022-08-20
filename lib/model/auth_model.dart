class Auth {
  String status;
  String message;
  int value;
  Data data;

  Auth({this.status, this.message, this.value, this.data});

  Auth.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    value = json['value'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  String id;
  String nama;
  String nik;
  String jk;
  String tempatLahir;
  String tanggalLahir;
  String alamatTt;
  String dusun;
  String tglRegister;
  String pekerjaan;

  Data(
      {this.id,
      this.nik,
      this.nama,
      this.jk,
      this.tempatLahir,
      this.tanggalLahir,
      this.alamatTt,
      this.dusun,
      this.tglRegister,
      this.pekerjaan});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    nik = json['nik'];
    jk = json['jenis_kelamin'];
    tempatLahir = json['tempat_lahir'];
    tanggalLahir = json['tanggal_lahir'];
    alamatTt = json['alamat'];
    dusun = json['dusun'];
    tglRegister = json['created_at'];
    pekerjaan = json['pekerjaan'];
  }
}
