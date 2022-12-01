class Ups {
  String? id;
  String? name;
  String? description;
  String? statoBatteria;
  String? connessione;
  String? stato;
  String? usoUps;

  Ups(
      {this.id,
      this.name,
      this.description,
      this.statoBatteria,
      this.stato,
      this.usoUps,
      this.connessione});

  Ups.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    statoBatteria = json['stato batteria'];
    connessione = json['connessione'];
    stato = json['stato'];
    usoUps = json['uso ups'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['stato batteria'] = this.statoBatteria;
    data['stato'] = this.stato;
    data['uso ups'] = this.usoUps;
    data['connessione'] = this.connessione;
    data['description'] = this.description;
    return data;
  }
}
