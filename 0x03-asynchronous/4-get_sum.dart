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

    List<dynamic> products = json.decode(ordersData);
    if (products.isEmpty) {
      return 0.0;
    }

    List<Future<String>> priceFutures = products.map((product) => fetchProductPrice(product)).toList();
    List<String> pricesData = await Future.wait(priceFutures);

    double totalPrice = 0.0;
    for (String price in pricesData) {
      if (price == "null" || price.isEmpty) {
        continue;
      }
      totalPrice += json.decode(price) ?? 0.0;
    }

    return totalPrice;
  } catch (e) {
    return -1;
  }
}
