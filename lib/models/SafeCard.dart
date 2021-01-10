class SafeCard {
  int id;
  String name;
  String description;
  String email;
  String password;
  int safeId;

  SafeCard({this.name, this.description, this.password, this.email, this.safeId});

  Map<String, dynamic> toMap(){
      var map = Map<String,dynamic>();
      map["name"]=name;
      map["description"]=description;
      map["email"]=email;
      print(description);
      map["password"]=password;
      if(id!=null){
        map["id"]=id;
      }
      if (safeId!=null) {
        map['safeId']=safeId;
      }
      return map;
    }

    SafeCard.fromObject(dynamic o){
      this.id=int.tryParse(o["id"].toString());
      this.name=o["name"];
      this.description=o["description"];
      this.email=o["email"];
      this.password=o["password"];
      this.safeId=int.tryParse(o["safeId"].toString());
    }
}


