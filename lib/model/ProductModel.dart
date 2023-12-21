class ProductModel {
  List<Details>? details;
  bool? hasNext;
  bool? hasPrev;
  int? page;
  int? pages;

  ProductModel(
      {this.details, this.hasNext, this.hasPrev, this.page, this.pages});

  ProductModel.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(Details.fromJson(v));
      });
    }
    hasNext = json['hasNext'];
    hasPrev = json['hasPrev'];
    page = json['page'];
    pages = json['pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (details != null) {
      data['details'] = details!.map((v) => v.toJson()).toList();
    }
    data['hasNext'] = hasNext;
    data['hasPrev'] = hasPrev;
    data['page'] = page;
    data['pages'] = pages;
    return data;
  }
}

class Details {
  bool? active;
  String? barCode;
  String? category;
  String? exDate;
  String? id;
  String? imageUrl;
  String? name;
  int? number;
  double? price;

  Details(
      {this.active,
      this.barCode,
      this.category,
      this.exDate,
      this.id,
      this.imageUrl,
      this.name,
      this.number,
      this.price});

  Details.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    barCode = json['barCode'];
    category = json['category'];
    exDate = json['exDate'];
    id = json['id'];
    imageUrl = json['imageUrl'];
    name = json['name'];
    number = json['number'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['active'] = active;
    data['barCode'] = barCode;
    data['category'] = category;
    data['exDate'] = exDate;
    data['id'] = id;
    data['imageUrl'] = imageUrl;
    data['name'] = name;
    data['number'] = number;
    data['price'] = price;
    return data;
  }
}
