import "4-util.dart";
import "dart:convert";

Future<double> calculateTotal() async {
  try {
    return fetchUserData().then((user) {
      String id = json.decode(user)["id"];
      return fetchUserOrders(id).then((products) async {
        double totalPrice = 0.0;
        for (String product in json.decode(products)) {
          await fetchProductPrice(product).then((price) {
            totalPrice += json.decode(price);
          });
        }
        return totalPrice;
      });
    });
  } catch (e) {
    return -1;
  }
}
