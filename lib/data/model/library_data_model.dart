import 'package:flutter/material.dart';

class LibraryDataModel {
  String name;
  String license;
  String url;

  LibraryDataModel({
    @required this.name,
    @required this.license,
    @required this.url,
  });

  factory LibraryDataModel.fromJson(Map<String, dynamic> json) {
    return LibraryDataModel(
      name: json["name"] as String,
      license: json["license"] as String,
      url: json["url"] as String,
    );
  }
}
