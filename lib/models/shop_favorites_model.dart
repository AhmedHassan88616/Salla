class ShopFavoritesModel {
  ShopFavoritesModel({
      bool status, 
      dynamic message, 
      Data data,}){
    _status = status;
    _message = message;
    _data = data;
}

  ShopFavoritesModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool _status;
  dynamic _message;
  Data _data;

  bool get status => _status;
  dynamic get message => _message;
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
      int currentPage, 
      List<DataItemModel> data,
      String firstPageUrl, 
      int from, 
      int lastPage, 
      String lastPageUrl, 
      dynamic nextPageUrl, 
      String path, 
      int perPage, 
      dynamic prevPageUrl, 
      int to, 
      int total,}){
    _currentPage = currentPage;
    _data = data;
    _firstPageUrl = firstPageUrl;
    _from = from;
    _lastPage = lastPage;
    _lastPageUrl = lastPageUrl;
    _nextPageUrl = nextPageUrl;
    _path = path;
    _perPage = perPage;
    _prevPageUrl = prevPageUrl;
    _to = to;
    _total = total;
}

  Data.fromJson(dynamic json) {
    _currentPage = json['current_page'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data.add(DataItemModel.fromJson(v));
      });
    }
    _firstPageUrl = json['first_page_url'];
    _from = json['from'];
    _lastPage = json['last_page'];
    _lastPageUrl = json['last_page_url'];
    _nextPageUrl = json['next_page_url'];
    _path = json['path'];
    _perPage = json['per_page'];
    _prevPageUrl = json['prev_page_url'];
    _to = json['to'];
    _total = json['total'];
  }
  int _currentPage;
  List<DataItemModel> _data;
  String _firstPageUrl;
  int _from;
  int _lastPage;
  String _lastPageUrl;
  dynamic _nextPageUrl;
  String _path;
  int _perPage;
  dynamic _prevPageUrl;
  int _to;
  int _total;

  int get currentPage => _currentPage;
  List<DataItemModel> get data => _data;
  String get firstPageUrl => _firstPageUrl;
  int get from => _from;
  int get lastPage => _lastPage;
  String get lastPageUrl => _lastPageUrl;
  dynamic get nextPageUrl => _nextPageUrl;
  String get path => _path;
  int get perPage => _perPage;
  dynamic get prevPageUrl => _prevPageUrl;
  int get to => _to;
  int get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = _currentPage;
    if (_data != null) {
      map['data'] = _data.map((v) => v.toJson()).toList();
    }
    map['first_page_url'] = _firstPageUrl;
    map['from'] = _from;
    map['last_page'] = _lastPage;
    map['last_page_url'] = _lastPageUrl;
    map['next_page_url'] = _nextPageUrl;
    map['path'] = _path;
    map['per_page'] = _perPage;
    map['prev_page_url'] = _prevPageUrl;
    map['to'] = _to;
    map['total'] = _total;
    return map;
  }

}

class DataItemModel {
  DataItemModel({
      int id, 
      Product product,}){
    _id = id;
    _product = product;
}

  DataItemModel.fromJson(dynamic json) {
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

class Product {
  Product({
      int id, 
      int price, 
      int oldPrice, 
      int discount, 
      String image, 
      String name, 
      String description,}){
    _id = id;
    _price = price;
    _oldPrice = oldPrice;
    _discount = discount;
    _image = image;
    _name = name;
    _description = description;
}

  Product.fromJson(dynamic json) {
    _id = json['id'];
    _price = json['price'];
    _oldPrice = json['old_price'];
    _discount = json['discount'];
    _image = json['image'];
    _name = json['name'];
    _description = json['description'];
  }
  int _id;
  int _price;
  int _oldPrice;
  int _discount;
  String _image;
  String _name;
  String _description;

  int get id => _id;
  int get price => _price;
  int get oldPrice => _oldPrice;
  int get discount => _discount;
  String get image => _image;
  String get name => _name;
  String get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['price'] = _price;
    map['old_price'] = _oldPrice;
    map['discount'] = _discount;
    map['image'] = _image;
    map['name'] = _name;
    map['description'] = _description;
    return map;
  }

}