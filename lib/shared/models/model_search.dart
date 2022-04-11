class ListSearch {
  late bool status;
  late ListSearch1 data;
  ListSearch.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    //   print(json["data"]);
    data = ListSearch1.fromJson(json["data"]);
    // print(data);
  }
}

class ListSearch1 {
  List<DetailsSearch> data1 = [];

  ListSearch1.fromJson(Map<String, dynamic> json) {
    // print(json["data"]);
    json["data"].forEach((value) {
      // print(value);
      data1.add(DetailsSearch.fromJson(value));
    });  }
}


class DetailsSearch {
  late int id;
  late dynamic price;
  late String image;
  late String name;
  late bool inFavorites;

  DetailsSearch.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    price = json["price"];
    image = json["image"];
    name = json["name"];
    inFavorites = json["in_favorites"];
  }
}



