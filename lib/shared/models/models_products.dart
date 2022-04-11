class HomeProductsData {
  late bool status;
  late DetailsProducts data;

  HomeProductsData.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    data = DetailsProducts.fromJson(json["data"]);
  }
}

class DetailsProducts {
  List<Banners> banners = [];
  List<Products> products = [];

  DetailsProducts.fromJson(Map<String, dynamic> json) {
    json["products"].forEach((value) {
      products.add(Products.fromJson(value));

    });
    json["banners"].forEach((value) {
      banners.add(Banners.fromJson(value));
    });
  }
}

class Banners {
  late int id;
  late String image;

  Banners.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    image = json["image"];
  }
}

class Products {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late String image;
  late String name;
  late bool inFavorites;
  late bool inCart;

  Products.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    price = json["price"];
    oldPrice = json["old_price"];
    image = json["image"];
    name = json["name"];
    inFavorites = json["in_favorites"];
    inCart = json["in_cart"];
  }
}
