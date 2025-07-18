import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class WebTools{
  static Future<String?> getRawWebsite(String url) async {
    try {
      // Fetch the page content
      final response = await http.get(Uri.parse(url));

      if (response.statusCode != 200) return null;

      return response.body;
    } catch (e) {
      return null;
    }
  }

  static Future<String?> downloadFile(
      {required String url, String? filename}) async {
    try {
      var response = await http.get(Uri.parse(url));
      String filepath = join(
        (await getTemporaryDirectory()).path,
        filename ?? url.split("/").last,
      );
      await File(filepath).writeAsBytes(response.bodyBytes);
      return filepath;
    } catch (e) {
      return null;
    }
  }
}
