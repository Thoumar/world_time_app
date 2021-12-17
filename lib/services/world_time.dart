import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String? location;
  String? time;
  String? flag;
  String? url;
  bool? isDaytime;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      var response = await http.get(
          Uri.https('worldtimeapi.org', '/api/timezone/$url', {'q': '{http}'}));
      if (response.statusCode == 200) {
        Map jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        String dateTime = jsonResponse['datetime'];
        String offset = jsonResponse['utc_offset'].substring(1, 3);
        DateTime now = DateTime.parse(dateTime);
        now = now.add(Duration(hours: int.parse(offset)));

        isDaytime = now.hour >= 6 && now.hour < 20;
        time = DateFormat.jm().format(now);
      }
    } catch (e) {
      time = 'Could not get time data !';
    }
  }
}
