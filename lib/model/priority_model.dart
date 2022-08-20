import "dart:convert";

class Prioritas {
  int id;
  int contentBahaya;
  int contentInfra;
  int contentSosial;
  String nik;
  int total;

  Prioritas({
    this.id,
    this.contentBahaya,
    this.contentInfra,
    this.contentSosial,
    this.nik,
    this.total
  });

  factory Prioritas.fromJson(Map<String, dynamic> map) {
    return Prioritas(
      id: map["id"],
      contentBahaya: map["content_bahaya"],
      contentInfra: map["content_infra"],
      contentSosial: map["content_sosial"],
      nik: map["nik"],
      total: map["total"]
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "nik" :nik,
      "content_bahaya" : contentBahaya,
      "content_infra": contentInfra,
      "content_sosial": contentSosial
    };
  }

  @override
  String toString() {
    return 'Prioritas{nik: $nik, content_bahaya: $contentBahaya, content_infra: $contentInfra, content_sosial: $contentSosial}';
  }
}

List<Prioritas> priorityFromJson(String jsonData) {
  final data = json.decode(jsonData)['data'];
  return List<Prioritas>.from(data.map((item) => Prioritas.fromJson(item)));
}

String priorityToJson(Prioritas data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}