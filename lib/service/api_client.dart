import 'dart:convert';
import 'package:get_x/get_connect/http/src/response/response.dart';
import 'package:get_x/get_instance/src/lifecycle.dart';
import 'package:http/http.dart' as http;
import 'api_url.dart';
import 'storage_service.dart';
import '../core/app_const.dart';

class ApiClient extends GetxService {
  static var client = http.Client();
  static const int timeoutInSeconds = 30;

  static Future<Map<String, String>> _getHeaders() async {
    String token = await SharePrefsHelper.getString(AppConstants.bearerToken);
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  static Future<Response> getData(String uri) async {
    try {
      var headers = await _getHeaders();
      var response = await client
          .get(Uri.parse(ApiUrl.baseUrl + uri), headers: headers)
          .timeout(const Duration(seconds: timeoutInSeconds));
      return _handleResponse(response);
    } catch (e) {
      return const Response(statusCode: 1, statusText: "Network Error");
    }
  }

  static Future<Response> postData(String uri, dynamic body) async {
    try {
      var headers = await _getHeaders();
      var response = await client
          .post(Uri.parse(ApiUrl.baseUrl + uri), body: jsonEncode(body), headers: headers)
          .timeout(const Duration(seconds: timeoutInSeconds));
      return _handleResponse(response);
    } catch (e) {
      return const Response(statusCode: 1, statusText: "Network Error");
    }
  }

  static Response _handleResponse(http.Response response) {
    dynamic body = jsonDecode(response.body);
    return Response(
      body: body,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );
  }
}