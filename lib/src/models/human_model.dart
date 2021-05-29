import 'dart:convert';

List<Human> humanFromJson(String str) =>
    List<Human>.from(json.decode(str).map((x) => Human.fromJson(x)));

String humanToJson(List<Human> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Human {
  int id;
  String email;
  String name;
  String job;

  Human({
    this.id,
    this.email,
    this.name,
    this.job,
  });

  factory Human.fromJson(Map<String, dynamic> json) => Human(
        id: json["id"],
        email: json["email"],
        name: json["name"],
        job: json["job"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "job": job,
      };
}
