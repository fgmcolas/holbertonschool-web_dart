import "4-util.dart";
import "dart:convert";

Future<double> calculateTotal() async {
  try {
    String userData = await fetchUserData();
    Map<String, dynamic> userJson = json.decode(userData);
    String userId = userJson["id"];
    String ordersData = await fetchUserOrders(userId);
    List<dynamic> products = json.decode(ordersData);
    List<Future<String>> priceFutures = products.map((product) => fetchProductPrice(product)).toList();
    List<String> pricesData = await Future.wait(priceFutures);
    double totalPrice = pricesData.map((price) => json.decode(price)).fold(0.0, (sum, price) => sum + price);

    return totalPrice;
  } catch (e) {
    return -1;
  }
}
