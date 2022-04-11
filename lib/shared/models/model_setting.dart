
import 'package:flutter/material.dart';

class Setting {
  late bool status;
  late SettingInfo data;

  Setting.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    data =  SettingInfo.fromJson(json["data"]);
  }
}

class SettingInfo {
  late String name;
  late String email;
  late String image;
  late String phone;
  SettingInfo.fromJson(Map<String, dynamic> json) {

    name=json["name"];
    email=json["email"];
    phone=json["phone"];
    image=json["image"];

  }

  }








 class SettingIcon{
    IconData icon;
    String title;
    SettingIcon({required this.icon,required this.title});
  }