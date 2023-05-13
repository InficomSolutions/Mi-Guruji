import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:techno_teacher/authcontroller.dart';
import 'package:techno_teacher/colors.dart';
import 'package:techno_teacher/getx_controller/chat_controller.dart';
import 'package:techno_teacher/pages/homepage/sizedbox.dart';
import '../../../utils/constants.dart';
import 'package:http/http.dart' as http;

class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  TextEditingController message = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String _message = "";
  File attachedFile = File('');
  Authcontroller authController = Authcontroller();
  var chatHistory = [];
  late String? token;
  Future getChatHistory() async {
    String? gettoken = await authController.getToken();
    setState(() {
      token = gettoken;
    });
    http.Response response = await http.post(
        Uri.parse("${AppConstants.urlBase}${AppConstants.chatHistoryUrl}"),
        headers: {"token": "$gettoken"},
        body: {"to_token": "0dreamsadmin"});
    var res = jsonDecode(response.body);
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      setState(() {
        chatHistory = result['data']['chat_history'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getChatHistory();
  }

  init() async {
    token = await Authcontroller().getToken();
    await Get.find<ChatController>().chatHistory();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: blackcolor,
              elevation: 0.0,
              title: const Text('शंका समाधान'),
            ),
            body: Column(
              children: [
                Expanded(
                  child: chatHistory.isEmpty
                      ? const Center(
                          child: Text('Start a new chat'),
                        )
                      : ListView.builder(
                          itemCount: chatHistory.length,
                          controller: _scrollController,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            print(chatHistory);
                            return Align(
                              alignment:
                                  chatHistory[index]['sender_token'] == token
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                              child: chatHistory[index]["attachment"] != 'na' ||
                                      chatHistory[index]["attachment"].isEmpty
                                  ? ConstrainedBox(
                                      constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              150),
                                      child: Card(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            if (chatHistory[index]['message']
                                                .isNotEmpty)
                                              Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  chatHistory[index]['message'],
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            // GestureDetector(
                                            //   onTap: () {
                                            // Navigator.of(context).push(
                                            //   MaterialPageRoute(
                                            //     builder: (context) {
                                            //       return SafeArea(
                                            //         child: Scaffold(
                                            //           appBar: AppBar(
                                            //             title: Text(
                                            //               chatHistory[index]
                                            //                           [
                                            //                           'sender_token'] ==
                                            //                       token
                                            //                   ? Get.find<
                                            //                           UserController>()
                                            //                       .getUserInfo()!
                                            //                       .name!
                                            //                   : 'Admin',
                                            //             ),
                                            //           ),
                                            //           body: Image.network(
                                            //             AppConstants
                                            //                     .baseUrl +
                                            //                 chatHistory[
                                            //                         index][
                                            //                     'attachment'],
                                            //             height: double
                                            //                 .maxFinite,
                                            //             width: double
                                            //                 .maxFinite,
                                            //           ),
                                            //         ),
                                            //       );
                                            //     },
                                            //   ),
                                            // );
                                            //   },
                                            //   child: chatHistory[index]
                                            //               ['attachment'] ==
                                            //           ''
                                            //       ? const SizedBox.shrink()
                                            //       : ClipRRect(
                                            //           borderRadius:
                                            //               BorderRadius.circular(
                                            //                   15),
                                            //           child: Image.network(
                                            //             AppConstants.urlBase +
                                            //                 chatHistory[index]
                                            //                     ['attachment'],
                                            //             height: 250,
                                            //             width: 250,
                                            //             fit: BoxFit.fitWidth,
                                            //             // fit: BoxFit.fitHeight,
                                            //           ),
                                            //         ),
                                            // ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    formatUtc(chatHistory[index]
                                                        ['created_at']),
                                                    style: const TextStyle(
                                                        fontSize: 11,
                                                        color: Colors.black),
                                                  ),
                                                  int.parse(chatHistory[index][
                                                              'read_status']) ==
                                                          0
                                                      ? Icon(
                                                          Icons.check,
                                                          color: blackcolor,
                                                        )
                                                      : Icon(
                                                          Icons.check,
                                                          color: bluecolor,
                                                        )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : ConstrainedBox(
                                      constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              100),
                                      child: Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 5, 10, 5),
                                        margin: const EdgeInsets.fromLTRB(
                                            10, 5, 10, 5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border:
                                              Border.all(color: Colors.black),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              chatHistory[index]["message"],
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            h(3),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  chatHistory[index]
                                                              ["created_at"] ==
                                                          null
                                                      ? ''
                                                      : formatUtc(
                                                          chatHistory[index]
                                                              ["created_at"]),
                                                  style: const TextStyle(
                                                    fontSize: 11,
                                                  ),
                                                ),
                                                w(3),
                                                if (chatHistory[index]
                                                            ["read_status"] ==
                                                        '0' &&
                                                    chatHistory[index]
                                                            ["sender_token"] ==
                                                        Get.find<
                                                                Authcontroller>()
                                                            .getToken())
                                                  const Icon(
                                                    Icons.check,
                                                    color: Colors.grey,
                                                    size: 13,
                                                  ),
                                                if (chatHistory[index]
                                                        ["read_status"] ==
                                                    '1') ...[
                                                  const Icon(
                                                    Icons.check,
                                                    color: Colors.blue,
                                                    size: 13,
                                                  ),
                                                  Transform.translate(
                                                    offset:
                                                        const Offset(-7, 0.5),
                                                    child: const Icon(
                                                      Icons.check,
                                                      color: Colors.blue,
                                                      size: 13,
                                                    ),
                                                  ),
                                                ]
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                            );
                          }),
                ),
                attachedFile.path.isNotEmpty
                    ? Container(
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.file(attachedFile),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    attachedFile = File("");
                                  });
                                },
                                child: Icon(Icons.delete)),
                          ],
                        ))
                    : SizedBox.shrink(),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 5, right: 5, bottom: 5, top: 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.attachment_outlined,
                          size: 30,
                        ),
                        onPressed: () async {
                          await FilePicker.platform
                              .pickFiles(
                            // allowedExtensions: ['png', 'jpg', 'jpeg'],
                            allowMultiple: false,
                            type: FileType.any,
                          )
                              .then((value) {
                            if (value != null) {
                              setState(() {
                                Fluttertoast.showToast(msg: 'File selected');
                                attachedFile = File(value.files.single.path!);
                              });
                            } else {
                              Fluttertoast.showToast(msg: 'File Not selected');
                            }
                          });
                          print(attachedFile.path.split("/").last);
                        },
                      ),
                      Expanded(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                              maxHeight: 100, minHeight: 40),
                          child: TextField(
                            onChanged: (val) {
                              _message = val;
                            },
                            onTap: () {
                              _scrollController.animateTo(
                                _scrollController.position.maxScrollExtent + 10,
                                duration: const Duration(milliseconds: 100),
                                curve: Curves.easeIn,
                              );
                            },
                            scrollPadding: EdgeInsets.zero,
                            maxLines: 3,
                            minLines: 1,
                            controller: message,
                            textInputAction: TextInputAction.newline,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10),
                              hintText: 'कृपया आपले म्हणने लिहा',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: blackcolor,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            // if (message.text.isEmpty) {
                            //   _message = "";
                            // message.clear();
                            //   attachedFile = null;
                            // }
                            if (message.text.isNotEmpty ||
                                attachedFile.path.isNotEmpty) {
                              String? token = await authController.getToken();
                              final request = http.MultipartRequest(
                                  "POST",
                                  Uri.parse(
                                      "${AppConstants.urlBase}${AppConstants.chatUrl}"));
                              request.headers.addAll({
                                'token': "$token",
                              });
                              request.fields.addAll({
                                "fromToken": "$token",
                                "toToken": "0dreamsadmin",
                                "content": message.text
                              });
                              if (attachedFile.path.isNotEmpty) {
                                request.files.addAll({
                                  http.MultipartFile.fromBytes(
                                      "file", attachedFile.readAsBytesSync(),
                                      filename:
                                          attachedFile.path.split("/").last)
                                });
                              }

                              var resp = await request.send();
                              print(resp.request);
                              http.Response response =
                                  await http.Response.fromStream(resp);
                              print(response.body);
                              setState(() {
                                message.clear();
                                attachedFile = File('');
                              });
                              getChatHistory();
                              Fluttertoast.showToast(
                                  msg: 'Message send successfully');
                            } else {
                              Fluttertoast.showToast(msg: 'No Message Found');
                            }

                            // Get.find<ChatController>().chatHistory();
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )));
  }
}

String formatUtc(String time) {
  // String year = time.substring(0, 5);
  // String month = time.substring(6, 8);
  // String day = time.substring(9, 11);
  String hour = time.substring(11, 13);
  String min = time.substring(14, 16);
  return '$hour:$min';
}

TextStyle style(double size) {
  return TextStyle(
    fontSize: size,
  );
}
