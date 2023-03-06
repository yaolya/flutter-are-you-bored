import 'package:http/http.dart' as http;

class ActivityAPI {
  Future<String> getRawActivity() async {
    http.Response response =
        await http.get(Uri.parse('https://www.boredapi.com/api/activity/'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load album');
    }
  }

  // Future<List<dynamic>> fetchActivities() async {
  //   return [];
  // }
}
