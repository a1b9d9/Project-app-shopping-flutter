class ListFavourites {
  late bool status;
  late ListFavourites1 data;
  ListFavourites.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    //   print(json["data"]);
    data = ListFavourites1.fromJson(json["data"]);
    // print(data);
  }
}

class ListFavourites1 {
  List<ItemFavourites> data1 = [];

  ListFavourites1.fromJson(Map<String, dynamic> json) {
    // print(json["data"]);
    json["data"].forEach((value) {
      // print(value);
      data1.add(ItemFavourites.fromJson(value));
    });
  }
}

class ItemFavourites {
  late DetailsFavourites data2;

  ItemFavourites.fromJson(Map<String, dynamic> json) {
    // print(json);
    data2 = DetailsFavourites.fromJson(json["product"]);
  }
}

class DetailsFavourites {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late String image;
  late String name;

  DetailsFavourites.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    price = json["price"];
    oldPrice = json["old_price"];
    image = json["image"];
    name = json["name"];
  }
}



class AddOrDeleteFavourites {
  late bool status;
  late String message;
  AddOrDeleteFavourites.fromJson(Map<String, dynamic> json) {

    status=json["status"];
    message=json["message"];
}}