import 'dart:convert';

import 'package:cross_file/cross_file.dart';
import 'package:get/get.dart';
import 'package:techno_teacher/getx_controller/ChatRepo.dart';
import 'package:techno_teacher/mode_data/chat_model/chat_model.dart';

class ChatController extends GetxController implements GetxService {
  final ChatRepo chatRepo;

  ChatController({required this.chatRepo});

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  List<ChatHistoryModel> _chats = [];

  List<ChatHistoryModel> get chats => _chats;

  Future<ResponseModel> sendChatOnline(String content, [XFile? data]) async {
    _isLoading = true;
    update();
    ResponseModel responseModel;
    Response response = await chatRepo.sendChat(content, data);
    _isLoading = false;
    var res = jsonDecode(response.body);
    if (response.statusCode == 200) {
      responseModel =
          ResponseModel(true, response.body['response']['response_message']);
      print('response model: $responseModel');
    } else {
      responseModel = ResponseModel(false, response.statusText!);
      print(response.statusText);
    }
    update();
    return responseModel;
  }

  String formatDate(int hour) {
    if (hour >= 12) {
      return 'PM';
    }
    return 'AM';
  }

  // Future<void> sendChatLocal(String message) async {
  //   chatRepo.sendChatLocal(
  //     ChatResponse(
  //       sender_token: Get.find<AuthController>().getUserToken(),
  //       receiver_token: '0dreamsadmin',
  //       message: message,
  //       status: '1',
  //       read_status: '0',
  //       utc_date_time: DateTime.now().toString(),
  //       created_at: DateTime.now().toString(),
  //       date:
  //           '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}',
  //       time:
  //           '${DateTime.now().hour}:${DateTime.now().minute} ${formatDate(DateTime.now().hour)}',
  //       sent: false,
  //     ),
  //   );
  //   update();
  // }

  // List<ChatHistoryModel> chatHistoryLocal() {
  //   _chats = chatRepo.chatHistoryLocal();
  //   update();
  //   return _chats;
  // }
  //
  bool _loadingHistory = false;

  bool get loadingHistory => _loadingHistory;

  Future<ResponseModel> chatHistory({String? token}) async {
    _loadingHistory = true;
    update();
    ResponseModel responseModel;
    Response response = await chatRepo.chatHistory(
      token: token,
    );
    var res = jsonDecode(response.body);
    if (response.statusCode == 200) {
      responseModel =
          ResponseModel(true, response.body['response']['response_message']);
      if (response.body != null) {
        List<dynamic> chats = response.body['data']['chat_history'];
        _chats = List.generate(
          chats.length,
          (index) => ChatHistoryModel.fromJson(chats[index]),
        );
        // try {
        //   for (Map<String, dynamic> chat in chats) {
        //     chatRepo.sendChatLocal(
        //       ChatResponse.fromJson(chat),
        //       fromDb: jsonEncode(chat),
        //     );
        //   }
        // } catch (e) {
        //   print('from controller');
        // }
      }
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _loadingHistory = false;
    update();
    return responseModel;
  }
}

class ResponseModel {
  bool isSuccess;
  String message;
  String? token;

  ResponseModel(this.isSuccess, this.message, [this.token]);

// String get message => _message;
//
// bool get isSuccess => _isSuccess;
//
// String? get token => _token;
}
