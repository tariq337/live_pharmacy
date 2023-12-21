class SalesModel {
  List<Details>? details;
  bool? hasNext;
  bool? hasPrev;
  int? page;
  int? pages;

  SalesModel({this.details, this.hasNext, this.hasPrev, this.page, this.pages});

  SalesModel.fromJson(Map<String, dynamic> json) {
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
  List<Fields>? fields;
  String? id;
  String? phoneNumber;
  String? timestamp;
  String? userName;

  Details(
      {this.fields, this.id, this.phoneNumber, this.timestamp, this.userName});

  Details.fromJson(Map<String, dynamic> json) {
    if (json['fields'] != null) {
      fields = <Fields>[];
      json['fields'].forEach((v) {
        fields!.add(Fields.fromJson(v));
      });
    }
    id = json['id'];
    phoneNumber = json['phoneNumber'];
    timestamp = json['timestamp'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (fields != null) {
      data['fields'] = fields!.map((v) => v.toJson()).toList();
    }
    data['id'] = id;
    data['phoneNumber'] = phoneNumber;
    data['timestamp'] = timestamp;
    data['userName'] = userName;
    return data;
  }
}

class Fields {
  String? imageUrl;
  String? name;
  String? number;
  String? total;

  Fields({this.imageUrl, this.name, this.number, this.total});

  Fields.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    name = json['name'];
    number = json['number'].toString();
    total = json['total'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imageUrl'] = imageUrl;
    data['name'] = name;
    data['number'] = number;
    data['total'] = total;
    return data;
  }
}
