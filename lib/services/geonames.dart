import 'dart:convert';

import 'package:http/http.dart' as http;

class GeoNamesService {
  final String _baseURL = 'http://api.geonames.org/searchJSON';
  final String _username = 'agrarian';

  // Auto-completion - debouncing, search query, display suggestions

  // fuzzy matching (fuse.js or flutter equivalent)

  // Validation - no match, suggest alts

  // Geocoding - store lat & long for additional functionality (e.g. nearby users)

  // Optimization - caching, storing results locally (session storage or IndexedDB)

  Future<List<String>> getLocations(String query) async {
    if (query.isEmpty) return [];

    final response = await http.get(Uri.parse(
        '$_baseURL?q=${Uri.encodeComponent(query)}&maxRows=10&username=$_username'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final locations = (data['geonames'] as List)
          .map((item) => item['name'] as String)
          .toSet() // Convert to Set to remove duplicates
          .toList(); // Convert back to List
      return locations;
    } else {
      throw Exception('Failed to fetch locations');
    }
  }
}
