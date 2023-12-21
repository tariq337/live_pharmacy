class UrlData {
  static String url = "http://lifepharm.pythonanywhere.com/";
  static String point = "api/v1/";

  static String login = "$url${point}pharmacies/auth/login";

  //image
  static String imageUrl(String image) {
    return "$url${point}images/$image";
  }

  //store
  static String allProducts = "$url${point}pharmacies/products/all";
  static String apiSearch = "$allProducts/search";
  static String products = "$url${point}pharmacies/products";
  static String putProducts(String id) => "$products/$id";
  static String search = "$products/search";

  static String alarmProduct(int number) =>
      "$url${point}pharmacies/synchronization/alarm/$number";
  static String alarmDateProduct(int number) =>
      "$url${point}pharmacies/synchronization/alarm/date/$number";

  static String sales = "$url${point}pharmacies/sales";

  static String records = "$url${point}pharmacies/records";

  static String salesClines = "$sales/clines";
}
