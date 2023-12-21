import 'dart:developer';

import 'package:live_pharmacy/Unit/Language.dart';
import 'package:live_pharmacy/Unit/UrlData.dart';
import 'package:live_pharmacy/Unit/const.dart';
import 'package:get/get.dart';

import '../model/ProductModel.dart';
import '../server/DioSever.dart';

class StoreController extends GetxController with DioServer {
  RxBool isLoading = false.obs;
  RxString errorMessag = "".obs;
  RxString errorPopMessag = "".obs;
  RxBool Synchroniz = false.obs;
  RxBool isAdd = false.obs;
  RxBool isPutProdact = false.obs;
  Rx<Details> putProdact = Details().obs;
  Rx<ProductModel> listStoregProdact = ProductModel().obs;
  Rx<ProductModel> listnotificationProdact = ProductModel().obs;

  RxList<Details> listOrderProdact = <Details>[].obs;
  Rx<ProductModel> apiProducts = ProductModel().obs;
  RxList<Map<String, dynamic>> carts = <Map<String, dynamic>>[].obs;

  void getByKey({required String key}) {
    listOrderProdact([]);

    if (storeBox.containsKey(key)) {
      listOrderProdact.value
          .add(Details.fromJson(storeBox.get(key) as Map<String, dynamic>));
    } else {
      errorMessag(language[modeControll.LanguageValue]["notFound"]);
    }
  }

  void searchByName({required String name}) {
    listOrderProdact([]);
    storeBox.values.toList().forEach((element) {
      if (element["name"].contains(name)) {
        Map<String, dynamic> map = element.cast();

        listOrderProdact.value.add(Details.fromJson(map));
      }
    });

    if (listOrderProdact.isEmpty) {
      errorMessag(language[modeControll.LanguageValue]["notFound"]);
    }
  }

  void getByBarCode({required String barCode}) {
    listOrderProdact([]);
    storeBox.values.toList().forEach((element) {
      if (element["barCode"] == barCode) {
        listOrderProdact.value
            .add(Details.fromJson(element as Map<String, dynamic>));
      }
    });

    if (listOrderProdact.isEmpty) {
      errorMessag(language[modeControll.LanguageValue]["notFound"]);
    }
  }

  Future<void> getByNumber({required int number}) async {
    runLoadeing();
    await get(url: "url/$number", key: "getByNumber", apiKey: true);
  }

  Future<void> getProduct() async {
    await get(url: UrlData.allProducts, key: "getProduct", apiKey: true);
  }

  Future<void> getMyProduct() async {
    await get(url: UrlData.products, key: "MyProduct", apiKey: true);
  }

  Future<void> getAlarmProduct({int number = 10}) async {
    await get(
        url: UrlData.alarmProduct(number),
        key: "getAlarmProduct",
        apiKey: true);
  }

  Future<void> getAlarmDateProduct({int number = 90}) async {
    runLoadeing();

    await get(
        url: UrlData.alarmDateProduct(number),
        key: "getAlarmProduct",
        apiKey: true);
  }

  Future<void> searchAPIByName({required String name}) async {
    runLoadeing();
    await get(
        url: UrlData.apiSearch,
        key: "searchAPIByName",
        apiKey: true,
        data: {"key": name});
  }

  Future<void> searchStoregByName({required String name}) async {
    runLoadeing();
    await get(
        url: UrlData.search,
        key: "searchStoregByName",
        apiKey: true,
        data: {"key": name});
  }

  Future<void> setProduct({required Map<String, dynamic> product}) async {
    runLoadeing();
    if (!storeBox.containsKey(product["id"])) {
      product["imageUrl"] = await downloadImage(product["imageUrl"]);

      await post(
          apiKey: true,
          url: UrlData.products,
          key: "setProdact",
          outIn: true,
          data: {
            "products": [
              [product["name"], product["number"]]
            ]
          },
          outPutdata: (data) async {
            await storeBox.put(product["id"], product.cast());
          },
          errorData: (error) {
            errorPopMessag(error);
          });
    } else {
      errorPopMessag(language[modeControll.LanguageValue]["exist"]);
    }
    stopLoadeing();
  }

  Future<void> putProduct({required Map<String, dynamic> product}) async {
    runLoadeing();

    await put(
        apiKey: true,
        url: UrlData.putProducts(product["id"]),
        key: "putProducts",
        outIn: true,
        data: product,
        outPutdata: (data) async {
          Map<String, dynamic> map = storeBox.get(product["id"])!.cast();
          map["number"] = product["number"];
          map["active"] = product["active"] == "on";
          map["exDate"] = product["exDate"];
          log(map.toString());
          await storeBox.put(map["id"], map);
        },
        errorData: (error) {
          errorPopMessag(error);
        });

    stopLoadeing();
  }

  Future<void> updateAllProdact(
      {required List<Map<String, dynamic>> prodacts}) async {
    runLoadeing();

    for (var prodact in prodacts) {
      Map<String, dynamic> map = storeBox.get(prodact["id"])!.cast();
      map["number"] = prodact["number"];
      await storeBox.put(map["id"], map);
    }

    stopLoadeing();
  }

  Future<void> deleteProdact({required String id}) async {
    runLoadeing();
    await delete(
        url: UrlData.putProducts(id),
        apiKey: true,
        key: "deleteProdact",
        outIn: true,
        outPutdata: (data) async {
          await storeBox.delete(id);
        },
        errorData: (error) {
          errorPopMessag(error);
        });
    stopLoadeing();
  }

  AddtoCard(Map<String, dynamic> item) {
    carts.add(item);
  }

  removeAll() {
    carts([]);
  }

  removeCart(int index) {
    carts.removeAt(index);
  }

  Add(int index) {
    Map<String, dynamic> item = carts.value[index];

    item["number"] = (item["number"]) + 1;
    removeCart(index);

    carts.insert(index, item);
  }

  Reduce(int index) {
    Map<String, dynamic> item = carts.value[index];
    if (item["number"] != 0) {
      item["number"] = (item["number"]) - 1;
      removeCart(index);
      carts.insert(index, item);
    } else {
      removeCart(index);
    }
  }

  double getTotal() {
    double total = 0;
    for (var element in carts) {
      total = total + (element["price"] * element["number"]);
    }
    return total;
  }

  Future<String> downloadImage(String imageUrl) async {
    try {
      // إنشاء مسار لحفظ الصورة في مسار المشروع
      String directory = 'assets/image/';
      String fileName = imageUrl.substring(imageUrl.lastIndexOf('/') + 1);
      String savePath = "$directory$fileName.png";

      // تحميل الصورة باستخدام Dio
      await dio.download(UrlData.imageUrl(imageUrl), savePath);

      // إرجاع المسار الجديد للصورة
      return savePath;
    } catch (e) {
      return 'assets/image/noImage.png';
    }
  }

  runLoadeing() {
    isLoading(true);
    errorMessag("");
  }

  stopLoadeing() {
    isLoading(false);
  }

  @override
  void error(String error) {
    // TODO: implement error
    super.error(error);

    errorMessag(error);
    stopLoadeing();
  }

  @override
  void output(String key, data) async {
    // TODO: implement output
    super.output(key, data);
    switch (key) {
      case "getProduct":
        apiProducts(ProductModel.fromJson(data));

        break;

      case "searchAPIByName":
        apiProducts(ProductModel.fromJson(data));

        break;

      case "MyProduct":
        listStoregProdact(ProductModel.fromJson(data));
        await updateAllProdact(prodacts: listStoregProdact.toJson()["details"]);

        break;

      case "getAlarmProduct":
        listnotificationProdact(ProductModel.fromJson(data));

        break;
      case "searchStoregByName":
        listStoregProdact(ProductModel.fromJson(data));

        break;

      case "getByNumber":
        apiProducts(ProductModel.fromJson(data));
        break;

      default:
    }
    stopLoadeing();
  }
}
