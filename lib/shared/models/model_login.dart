class LoginInfo {
  late bool status;
  late String message;
  late DataUserInfo data;

  LoginInfo({required this.status,required this.message,required this.data,});

  LoginInfo.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = status
        ? DataUserInfo.fromJson(json["data"])
        : DataUserInfo(id: 0, name: "", email: "", phone: "", image: "", points: 0, credit: 0, token: "");
  }
}

class DataUserInfo {
  late int id ;
  late String name ;
  late String email;
  late String phone;
  late String image;
  late int points ;
  late int credit ;
  late String token ;
  DataUserInfo(
      {required this.id,
      required this.name,
      required this.email,
        required this.phone,
        required this.image,
        required this.points,
        required this.credit,
        required this.token});


  DataUserInfo.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    email = json["email"];
    phone = json["phone"];
    image = json["image"];
    points = json["points"];
    credit = json["credit"];
    token = json["token"];
  }
}
