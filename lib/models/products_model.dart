class ProductModel {
  Id? id;
  Price? price;
  Id? image;
  Id? title;

  ProductModel({this.id, this.price, this.image, this.title});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? Id.fromJson(json['id']) : null;
    price = json['price'] != null ? Price.fromJson(json['price']) : null;
    image = json['image'] != null ? Id.fromJson(json['image']) : null;
    title = json['title'] != null ? Id.fromJson(json['title']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) {
      data['id'] = id!.toJson();
    }
    if (price != null) {
      data['price'] = price!.toJson();
    }
    if (image != null) {
      data['image'] = image!.toJson();
    }
    if (title != null) {
      data['title'] = title!.toJson();
    }
    return data;
  }
}

class Id {
  String? s;

  Id({this.s});

  Id.fromJson(Map<String, dynamic> json) {
    s = json['S'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['S'] = s;
    return data;
  }
}

class Price {
  String? n;

  Price({this.n});

  Price.fromJson(Map<String, dynamic> json) {
    n = json['N'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['N'] = n;
    return data;
  }
}


