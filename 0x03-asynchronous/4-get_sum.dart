import "4-util.dart";
import "dart:convert";

Future<double> calculateTotal() async {
  try {
    String userData = await fetchUserData();
    Map<String, dynamic> userJson = jsonDecode(userData);
    String userId = userJson["id"];
    String ordersData = await fetchUserOrders(userId);
    List<dynamic> orders = jsonDecode(ordersData);
    List<Future<String>> priceFutures = orders.map((product) => fetchProductPrice(product)).toList();
    List<String> pricesData = await Future.wait(priceFutures);
    double total = pricesData.map((price) => jsonDecode(price) as double).fold(0.0, (sum, price) => sum + price);

    return total;
  } catch (e) {
    return -1;
  }
}
