class HomeCategoriesData {
  late bool status;
  late DetailsCategories data;
  HomeCategoriesData.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    data = DetailsCategories.fromJson(json["data"]);
  }
}

class DetailsCategories {
  List<InfoCategories> infoCategories = [];

  DetailsCategories.fromJson(Map<String, dynamic> json){
    json["data"].forEach((value) {
      infoCategories.add(InfoCategories.fromJson(value));
    });
  }
}


class InfoCategories {
  late int id ;
  late String name ;
  late String image;

  InfoCategories.fromJson(Map<String, dynamic> json){
    id=json["id"];
    name=json["name"];
    image=json["image"];

  }

}