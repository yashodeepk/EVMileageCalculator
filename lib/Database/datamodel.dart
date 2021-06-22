class DataModel {
  final int? id;
  final String? title;
  final String? distance;
  final String? savecharging;
  final String? dateTimeadd;
  final String? petrol;
  final String? electricity;

  DataModel(
      {this.id,
      this.title,
      this.distance,
      this.savecharging,
      this.dateTimeadd,
      this.electricity,
      this.petrol});

  factory DataModel.fromMap(Map<String, dynamic> json) => DataModel(
      id: json["id"],
      title: json["title"],
      distance: json["distance"],
      savecharging: json["savecharging"],
      dateTimeadd: json["dateTimeadd"],
      electricity: json["electricity"],
      petrol: json["petrol"]);

  Map<String, dynamic> tomap() => {
        "id": id,
        "title": title,
        "distance": distance,
        "savecharging": savecharging,
        "dateTimeadd": dateTimeadd,
        "petrol": petrol,
        "electricity": electricity
      };
}
