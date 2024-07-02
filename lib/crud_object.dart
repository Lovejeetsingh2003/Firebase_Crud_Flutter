class CrudObject {
  String? name;
  int? age;
  String? address;

  CrudObject({
    this.name,
    this.age,
    this.address,
  });

  factory CrudObject.fromJson(Map<String, dynamic> json) => CrudObject(
        name: json["name"],
        age: json["age"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "age": age,
        "address": address,
      };
}
