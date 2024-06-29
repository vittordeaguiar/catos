import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cat_image.dart';

class CatApiService {
  static const String _baseUrl = 'https://api.thecatapi.com/v1/images/search';

  Future<List<CatImage>> getImages() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (!(response.statusCode == 200)) throw Exception('Failed to load images');

    List<dynamic> body = json.decode(response.body);
    return body.map((dynamic item) => CatImage.fromJson(item)).toList();
  }
}
