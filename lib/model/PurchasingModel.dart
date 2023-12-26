class PurchasingModel {
  List<List<dynamic>>? products;
  String? time;
  String? reduction;
  String? userName;
  String? phone;
  bool? isServer;

  PurchasingModel(
      {this.products,
      this.time,
      this.userName,
      this.reduction,
      this.phone,
      this.isServer});

  PurchasingModel.fromJson(Map<String, dynamic> json) {
    products = json['products'];
    time = json['timestamp'];
    reduction = json['reduction'];
    userName = json['userName'];
    phone = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['products'] = products;
    data['timestamp'] = time;
    data['reduction'] = reduction;
    data['userName'] = userName;
    data['phoneNumber'] = phone;
    return data;
  }
}
