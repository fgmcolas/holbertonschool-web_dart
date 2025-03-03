import '4-util.dart';
import 'dart:convert';

Future<num> calculateTotal() async {
  try {
    Map userData = jsonDecode(await fetchUserData());
    String userId = userData['id'];

    List<dynamic> userOrder = jsonDecode(await fetchUserOrders(userId));

    double total = 0.0;
    for (var product in userOrder) {
      total += double.parse(await fetchProductPrice(product));
    }
    return total;
  } catch (error) {
    return -1;
  }
}
