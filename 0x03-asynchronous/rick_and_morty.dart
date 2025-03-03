import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> printRmCharacters() async {
  try {
    final response = await http.get(Uri.parse('https://rickandmortyapi.com/api/character'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['results'] is List) {
        for (var character in data['results']) {
          print('${character['name']}');
        }
      } else {
        print('Invalid API response format.');
      }
    } else {
      print('Failed to fetch data. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print('Error caught: $error');
  }
}
