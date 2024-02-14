import 'dart:convert';
import 'package:http/http.dart' as http;

class WorldTime {
  final String url;
  DateTime time = DateTime.now();

  WorldTime({required this.url});

  Future<void> getTime() async {
    try {
      var response = await http
          .get(Uri.https('worldtimeapi.org', '/api/timezone/Africa/$url'));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        time = DateTime.parse(data['datetime']);
      } else {
        throw Exception('Failed to get time: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching time: $e');
    }
  }
}
