class Safe {
  int id;
  String name;
  String password;

  Safe({this.id, this.name, this.password});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["name"] = name;
    map["password"] = password;
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  Safe.fromObject(dynamic o) {
    this.id = int.tryParse(o["id"].toString());
    this.name = o["name"];
    this.password = o["password"];
  }
}
