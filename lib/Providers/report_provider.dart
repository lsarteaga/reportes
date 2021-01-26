import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:reportes/Common/constant.dart';
import 'dart:convert';
import 'package:reportes/Models/report_model.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';

class ReportProvider {
  static final String url = Constant.DOMAIN + '/reports';
  static final Map<String, String> _headers = {
    'Content-Type': 'application/json'
  };
  static final Map<String, String> _headers2 = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  ReportProvider();

  static Future<Map> getJsonReports() async {
    try {
      final apiResponse = await http.get(url);
      return json.decode(apiResponse.body);
    } on Exception catch (e) {
      print('exception $e');
      return null;
    }
  }

  static Future<Map> getJsonReport(String id) async {
    try {
      final apiResponse = await http.get('$url/$id');
      return json.decode(apiResponse.body);
    } on Exception catch (e) {
      print('exception $e');
      return null;
    }
  }

  static Future<ReportModel> editReport(ReportModel report, String id) async {
    try {
      final http.Response response = await http.put('$url/$id',
          headers: _headers2, body: reportModelToJson(report));
      if (response.statusCode == 200) {
        return ReportModel.fromJson(jsonDecode(response.body));
      } else {
        return null;
        //throw Exception('Failed to load report');
      }
    } on Exception catch (e) {
      print('exception: $e');
      return null;
    }
  }

  static Future<Map> createReport(ReportModel report) async {
    try {
      final apiResponse = await http.post('$url',
          headers: _headers, body: reportModelToJson(report));
      if (apiResponse.body.isEmpty) return null;
      return json.decode(apiResponse.body);
    } on Exception catch (e) {
      print('exception: $e');
      return null;
    }
  }

  static Future<Map> deleteReport(String id) async {
    try {
      final apiResponse = await http.delete('$url/$id');
      return json.decode(apiResponse.body);
    } on Exception catch (e) {
      print('exception: $e');
      return null;
    }
  }

  static Future<String> uploadImage(File image) async {
    final url = Uri.parse(Constant.uploadUrl);
    final mimeType = mime(image.path).split('/');
    final imageUploadRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath('file', image.path,
        contentType: MediaType(mimeType[0], mimeType[1]));
    imageUploadRequest.files.add(file);
    final imageResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(imageResponse);
    if (resp.statusCode != 200) {
      print('error: ' + resp.body);
      return null;
    }
    final decodedData = json.decode(resp.body);
    return decodedData['secure_url'];
  }
}
