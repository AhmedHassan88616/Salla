class ShopHomeModel {
  ShopHomeModel({
    bool status,
    dynamic message,
    Data data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  ShopHomeModel.fromJson(dynamic json) {
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
    List<Banners> banners,
    List<Product> products,
    String ad,
  }) {
    _banners = banners;
    _products = products;
    _ad = ad;
  }

  Data.fromJson(dynamic json) {
    if (json['banners'] != null) {
      _banners = [];
      json['banners'].forEach((v) {
        _banners.add(Banners.fromJson(v));
      });
    }
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products.add(Product.fromJson(v));
      });
    }
    _ad = json['ad'];
  }

  List<Banners> _banners;
  List<Product> _products;
  String _ad;

  List<Banners> get banners => _banners;

  List<Product> get products => _products;

  String get ad => _ad;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_banners != null) {
      map['banners'] = _banners.map((v) => v.toJson()).toList();
    }
    if (_products != null) {
      map['products'] = _products.map((v) => v.toJson()).toList();
    }
    map['ad'] = _ad;
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
    String description,
    List<String> images,
    bool inFavorites,
    bool inCart,
  }) {
    _id = id;
    _price = price;
    _oldPrice = oldPrice;
    _discount = discount;
    _image = image;
    _name = name;
    _description = description;
    _images = images;
    _inFavorites = inFavorites;
    _inCart = inCart;
  }

  Product.fromJson(dynamic json) {
    _id = json['id'];
    _price = json['price'];
    _oldPrice = json['old_price'];
    _discount = json['discount'];
    _image = json['image'];
    _name = json['name'];
    _description = json['description'];
    _images = json['images'] != null ? json['images'].cast<String>() : [];
    _inFavorites = json['in_favorites'];
    _inCart = json['in_cart'];
  }

  int _id;
  int _price;
  int _oldPrice;
  int _discount;
  String _image;
  String _name;
  String _description;
  List<String> _images;
  bool _inFavorites;
  bool _inCart;

  int get id => _id;

  int get price => _price;

  int get oldPrice => _oldPrice;

  int get discount => _discount;

  String get image => _image;

  String get name => _name;

  String get description => _description;

  List<String> get images => _images;

  bool get inFavorites => _inFavorites;

  bool get inCart => _inCart;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['price'] = _price;
    map['old_price'] = _oldPrice;
    map['discount'] = _discount;
    map['image'] = _image;
    map['name'] = _name;
    map['description'] = _description;
    map['images'] = _images;
    map['in_favorites'] = _inFavorites;
    map['in_cart'] = _inCart;
    return map;
  }
}

class Banners {
  Banners({
    int id,
    String image,
    dynamic category,
    dynamic product,
  }) {
    _id = id;
    _image = image;
    _category = category;
    _product = product;
  }

  Banners.fromJson(dynamic json) {
    _id = json['id'];
    _image = json['image'];
    _category = json['category'];
    _product = json['product'];
  }

  int _id;
  String _image;
  dynamic _category;
  dynamic _product;

  int get id => _id;

  String get image => _image;

  dynamic get category => _category;

  dynamic get product => _product;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['image'] = _image;
    map['category'] = _category;
    map['product'] = _product;
    return map;
  }
}
