import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:reportes/Common/constant.dart';
import 'dart:convert';

class ReportChartService {
  static final String url = Constant.DOMAIN + '/reports/tags';
  ReportChartService();

  static Future<Map> getJsonReport(String tag) async {
    try {
      final apiResponse = await http.get('$url/$tag');
      return json.decode(apiResponse.body);
    } on Exception catch (e) {
      print('exception $e');
      return null;
    }
  }
}
