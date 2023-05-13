import 'package:cross_file/cross_file.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:techno_teacher/authcontroller.dart';
import 'package:techno_teacher/getx_controller/apiclient.dart';

import '../../utils/constants.dart';

class ChatRepo {
  final ApiClient apiClient;

  ChatRepo({required this.apiClient});

  Future<Response> sendChat(String content, XFile? data) async {
    String? token = await Authcontroller().getToken();

    Response response = await apiClient.postMultipartData(
        AppConstants.chatUrl,
        {
          'content': content,
          'toToken': '0dreamsadmin',
          'fromToken': token!,
        },
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'token': token,
        },
        multipartBody: data == null ? [] : [MultipartBody('file', data)]);
    return response;
  }

  Future<Response> chatHistory({String? token}) async {
    String? token = await Authcontroller().getToken();
    Response response = await apiClient.postData(AppConstants.chatHistoryUrl, {
      'to_token': '0dreamsadmin',
    }, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'token': token!,
      // 'token': '52ZpJRIP4dyTRzmp',
    });
    return response;
  }
}
