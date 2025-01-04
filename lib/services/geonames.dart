import 'dart:convert';

import 'package:http/http.dart' as http;

class GeoNamesService {
  final String _baseURL = 'http://api.geonames.org/searchJSON';
  final String _username = 'agrarian';

  Future<List<String>> getLocations(String query) async {
    if (query.isEmpty) return [];

    final response = await http.get(Uri.parse(
        '$_baseURL?q=${Uri.encodeComponent(query)}&maxRows=10&username=$_username'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final locations = (data['geonames'] as List)
          .map((item) => item['name'] as String)
          .toList();
      return locations;
    } else {
      throw Exception('Failed to fetch locations');
    }
  }
}
