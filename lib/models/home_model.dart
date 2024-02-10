import 'package:flutter/foundation.dart';

class HomeModel {
  late bool status;
  HomeDataModel? data;
  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  List<BannersModel> banners = [];
  List<ProductsModel> products = [];
  HomeDataModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(BannersModel.fromJson(element));
    });

    json['products'].forEach((element) {
      products.add(ProductsModel.fromJson(element));
    });
  }
}

class BannersModel {
  int id;
  String image;

  BannersModel({
    required this.id,
    required this.image,
  });
  factory BannersModel.fromJson(Map<String, dynamic> json) {
    return BannersModel(
      id: json['id'],
      image: json['image'],
    );
  }
}

class ProductsModel {
  final int id;
  final dynamic price;
  final dynamic discount;
  final dynamic old_price;
  final String image;
  final String name;
  final String description;
  final bool in_favorites;
  final bool in_cart;

  ProductsModel({
    required this.id,
    required this.price,
    required this.discount,
    required this.old_price,
    required this.image,
    required this.name,
    required this.description,
   
    required this.in_favorites,
    required this.in_cart,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      id: json['id'],
      price: json['price'],
      discount: json['discount'],
      old_price: json['old_price'],
      image: json['image'],
      name: json['name'],
      description: json['description'],
      
      in_favorites: json['in_favorites'],
      in_cart: json['in_cart'],
    );
  }
}
