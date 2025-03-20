import 'package:http/http.dart' as http;

import '../models/error_details.dart';

class ActivityAPI {
  Future<String?> getRawActivity() async {
    try {
      http.Response response = await http
          .get(Uri.parse('https://bored.api.lewagon.com/api/activity/'));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw const MessageException('Failed to perform operation');
      }
    } catch (e) {
      rethrow;
    }
  }
}
