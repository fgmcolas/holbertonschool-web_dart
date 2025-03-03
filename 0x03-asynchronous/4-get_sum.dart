import "4-util.dart";
import "dart:convert";

Future<double> calculateTotal() async {
  try {
    String userData = await fetchUserData();
    Map<String, dynamic> userJson = json.decode(userData);
    String userId = userJson["id"];

    String ordersData = await fetchUserOrders(userId);
    if (ordersData == "null" || ordersData.isEmpty) {
      return 0.0;
    }

    List<dynamic>? products;
    try {
      products = json.decode(ordersData);
    } catch (e) {
      return -1;
    }

    if (products == null || products.isEmpty) {
      return 0.0;
    }

    List<Future<String>> priceFutures = products.map((product) => fetchProductPrice(product)).toList();
    List<String> pricesData = await Future.wait(priceFutures);

    double totalPrice = 0.0;

    for (int i = 0; i < pricesData.length; i++) {
      String price = pricesData[i];
      if (price == "null" || price.isEmpty) {
        continue;
      }

      double? parsedPrice;
      try {
        parsedPrice = json.decode(price);
      } catch (e) {
        return -1;
      }

      if (parsedPrice != null) {
        totalPrice += parsedPrice;
      }
    }

    return totalPrice;
  } catch (e) {
    return -1;
  }
}
