import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cross_file/cross_file.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:http/http.dart' as Http;

class ApiClient extends GetxService {
  final String appBaseUrl;
  static const String noInternetMessage = 'No Internet Connection';
  final int timeoutInSeconds = 30;
  String? token;
  Map<String, String>? _mainHeaders;

  ApiClient({
    required this.appBaseUrl,
  }) {
    // token = sharedPreferences.getString(AppConstants.userToken) ??
    //     AppConstants.token;
    // updateHeader(token!);
  }

  void updateHeader(String? token) {
    Map<String, String> _header = {
      'Content-Type': 'application/json; charset=UTF-8',
      'token': token!,
    };
    _mainHeaders = _header;
  }

  Future<Response> getData(String uri,
      {Map<String, dynamic>? query, Map<String, String>? headers}) async {
    try {
      Http.Response _response = await Http.get(
        Uri.parse(appBaseUrl + uri),
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } on SocketException catch (e) {
      print('------------${e.toString()}');
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postData(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    print('headers ${headers ?? _mainHeaders}');
    print('body $body');
    try {
      Http.Response _response = await Http.post(
        Uri.parse(appBaseUrl + uri),
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } on SocketException catch (e) {
      print('------------${e.toString()}');
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postMultipartData(String uri, Map<String, String> body,
      {List<MultipartBody>? multipartBody,
      Map<String, String>? headers}) async {
    try {
      if (Foundation.kDebugMode) {
        print('====> API Call: $uri\nHeader: $_mainHeaders');
        print('====> API Body: $body with ${multipartBody?.length} picture');
      }
      Http.MultipartRequest _request =
          Http.MultipartRequest('POST', Uri.parse(appBaseUrl + uri));
      _request.headers.addAll(headers ?? _mainHeaders!);
      if (multipartBody != null) {
        for (MultipartBody multipart in multipartBody) {
          Uint8List _list = await multipart.file.readAsBytes();
          _request.files.add(Http.MultipartFile(
            multipart.key,
            multipart.file.readAsBytes().asStream(),
            _list.length,
            filename: '${DateTime.now().toString()}.png',
          ));
        }
      }
      _request.fields.addAll(body);
      Http.Response _response =
          await Http.Response.fromStream(await _request.send());
      return handleResponse(_response, uri);
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Response handleResponse(Http.Response response, String uri) {
    dynamic _body;
    try {
      _body = jsonDecode(response.body);
    } catch (e) {}
    print(response.body);
    print('url is ${response.request!.url}');
    Response _response = Response(
      body: _body ?? response.body,
      bodyString: response.body.toString(),
      request: Request(
          headers: response.request!.headers,
          method: response.request!.method,
          url: response.request!.url),
      headers: response.headers,
      statusCode: int.tryParse((_body['response']['response_code']).toString()),
      statusText: response.reasonPhrase,
    );
    if (_response.body['response']['response_code'] == '200') {
      _response = Response(
        statusCode: _response.statusCode,
        body: _response.body,
        statusText: _response.body['response']['response_message'],
      );
      return _response;
    } else {
      _response = Response(
        statusCode: _response.statusCode,
        body: _response.body,
        statusText: _response.body['response']['response_message'],
      );
      return _response;
    }
    // if (_response.body['response']['response_code'] != '200' &&
    //     _response.body != null) {
    //   if (_response.body['response']['response_code'] != '200') {
    //     ErrorResponse _errorResponse = ErrorResponse.fromJson(_response.body);
    //     _response = Response(
    //         statusCode: _response.statusCode,
    //         body: _response.body,
    //         statusText: _errorResponse.errors![0].message);
    //   } else if (_response.body['response']['response_code'] == 200) {
    //     print('response from here 2');
    //     _response = Response(
    //         statusCode: _response.statusCode,
    //         body: _response.body,
    //         statusText: _response.body['response']['response_message']);
    //   }
    // } else if (_response.statusCode != 200 && _response.body == null) {
    //   print('response from here 2');
    //
    //   _response = const Response(statusCode: 0, statusText: noInternetMessage);
    // }
    // if (Foundation.kDebugMode) {
    //   print(
    //       '====> API Response: [${_response.statusCode}] $uri\n${_response.body}');
    // }
    // return _response;
  }
}

class MultipartBody {
  String key;
  XFile file;

  MultipartBody(this.key, this.file);
}
