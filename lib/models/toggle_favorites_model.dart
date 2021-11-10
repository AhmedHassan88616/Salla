

import 'package:Salla/models/shop_favorites_model.dart';

class ToggleFavoritesModel {
  ToggleFavoritesModel({
      bool status, 
      String message, 
      Data data,}){
    _status = status;
    _message = message;
    _data = data;
}

  ToggleFavoritesModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool _status;
  String _message;
  Data _data;

  bool get status => _status;
  String get message => _message;
  Data get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data.toJson();
    }
    return map;
  }

}

class Data {
  Data({
      int id, 
      Product product,}){
    _id = id;
    _product = product;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _product = json['product'] != null ? Product.fromJson(json['product']) : null;
  }
  int _id;
  Product _product;

  int get id => _id;
  Product get product => _product;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if (_product != null) {
      map['product'] = _product.toJson();
    }
    return map;
  }

}

