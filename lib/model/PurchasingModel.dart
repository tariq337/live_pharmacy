class PurchasingModel {
  List<List<dynamic>>? products;
  String? time;
  String? userName;
  String? phone;
  bool? isServer;

  PurchasingModel(
      {this.products, this.time, this.userName, this.phone, this.isServer});

  PurchasingModel.fromJson(Map<String, dynamic> json) {
    products = json['products'];
    time = json['timestamp'];
    userName = json['userName'];
    phone = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['products'] = products;
    data['timestamp'] = time;
    data['userName'] = userName;
    data['phoneNumber'] = phone;
    return data;
  }
}
