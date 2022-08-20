import "dart:convert";

class Comment {
  String commentId;
  String commentIsi;
  String commentBahaya;
  String commentInfra;
  String commentSosial;
  String usersID;
  String nama;
  String deskripsi;
  String tglKomen;

  Comment({this.commentId,
      this.commentIsi,
      this.nama,
      this.deskripsi,
      this.tglKomen});

  factory Comment.fromJson(Map<String, dynamic> map) {
    return Comment(
      commentId: map["comment_id"],
      commentIsi: map["comment_isi"],
      nama: map["nama"],
      deskripsi: map["deskripsi"],
      tglKomen: map["tgl_komen"],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "nama" : nama,
      "comment_isi": commentIsi, 
      "comment_bahaya": commentBahaya,
      "comment_infra": commentInfra,
      "comment_sosial": commentSosial,
    };
  }

  @override
  String toString() {
    return 'Comment{nama: $nama,comment: $commentIsi,contentBahayaID: $commentBahaya,contentInfraID: $commentInfra,contentSosialID: $commentSosial}';
  }
}

List<Comment> commentFromJson(String jsonData) {
  final data = json.decode(jsonData)['data'];
  return List<Comment>.from(data.map((item) => Comment.fromJson(item)));
}

String commentToJson(Comment data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}