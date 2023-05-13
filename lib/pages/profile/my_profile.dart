import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:images_picker/images_picker.dart';
import 'package:techno_teacher/api_utility/cont_urls.dart';
import 'package:techno_teacher/authcontroller.dart';
import 'package:techno_teacher/colors.dart';
import 'package:techno_teacher/getx_controller/my_profile_controller/my_profile_controller.dart';
import 'package:http/http.dart' as http;
import 'package:techno_teacher/theme/light.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/sizedbox.dart';

class MyProfile extends StatefulWidget {
  MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  MyProfileController _myProfileController = Get.put(MyProfileController());

  List<Media>? res;
  List<String> path1 = <String>[];
  bool editMode = false;

  toggleEditMode(bool val) {
    setState(() {
      editMode = val;
    });
  }

  @override
  void initState() {
    super.initState();
    getdata();
    _myProfileController.name.value.text =
        "${userdata['user_details']['name']}";
    _myProfileController.address.value.text =
        "${userdata['user_details']['address']}";
    _myProfileController.mobile.value.text =
        "${userdata['user_details']['mobileno']}";
    _myProfileController.refercode.value.text =
        "${userdata['user_details']['referal_user_code']}";
  }

  updateuserdata() async {
    print(path1);
    try {
      var gettoken = await Authcontroller().getToken();
      final request = http.MultipartRequest(
          "POST", Uri.parse(TGuruJiUrl.userprofileupdate));
      request.headers.addAll({
        'token': "$gettoken",
      });
      if (path1.isNotEmpty) {
        request.files.addAll({
          http.MultipartFile.fromBytes(
              "profile_img", File(path1[0]).readAsBytesSync(),
              filename: "uploads/profile_img/1669906325user.jpg")
        });
      }

      request.fields.addAll({
        "mobile": _myProfileController.mobile.value.text,
        "password": "${userdata['user_details']['password']}",
        "name": _myProfileController.name.value.text,
        "address": _myProfileController.address.value.text,
        "refer_code": _myProfileController.refercode.value.text,
      });
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Waiting")));
      var resp = await request.send();

      http.Response response = await http.Response.fromStream(resp);
      var res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        getdata();
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "error...");
      print(e);
    }
  }

  getdata() async {
    var gettoken = await Authcontroller().getToken();

    http.Response response = await http
        .get(Uri.parse(TGuruJiUrl.userdata), headers: {'token': "$gettoken"});

    var mapreduce = json.decode(response.body);
    var res = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        userdata = mapreduce['data'];
        editMode = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: blackcolor,
        iconTheme: IconThemeData(
          color: whitecolor,
        ),
        elevation: 0.7,
        centerTitle: true,
        title: Text(
          "माझी प्रोफाईल",
          style: TextStyle(
              color: whitecolor, fontWeight: FontWeight.w500, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: userdata == null
            ? CircularProgressIndicator()
            : Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: SwitchListTile(
                      activeColor: primaryColor,
                      title: const Text(
                        'एडीट करा',
                        style: TextStyle(fontSize: 18),
                      ),
                      onChanged: (val) {
                        toggleEditMode(val);
                      },
                      value: editMode,
                    ),
                  ),
                  h(40),
                  Center(
                    child: CircleAvatar(
                      backgroundImage: path1.isNotEmpty
                          ? Image.file(File(path1[0])).image
                          : userdata['user_details']["profile_img"] == null
                              ? const NetworkImage(
                                  "https://media.istockphoto.com/id/1390650720/photo/digital-network-connection-abstract-connection-of-dots-and-lines-technology-background-plexus.jpg?b=1&s=170667a&w=0&k=20&c=SUkUz3EzbbcC25vGSHdV_9MxR0Mun8giVcuHoyOKwDo=")
                              : NetworkImage(
                                  // "https://media.istockphoto.com/id/1390650720/photo/digital-network-connection-abstract-connection-of-dots-and-lines-technology-background-plexus.jpg?b=1&s=170667a&w=0&k=20&c=SUkUz3EzbbcC25vGSHdV_9MxR0Mun8giVcuHoyOKwDo="
                                  "${TGuruJiUrl.url}${userdata['user_details']["profile_img"]}"),
                      radius: 80,
                    ),
                  ),
                  h(10),
                  InkWell(
                    onTap: () async {
                      if (editMode) {
                        if (path1.isEmpty) {
                          List<String> img1 = <String>[];
                          res = await ImagesPicker.pick(
                            count: 1,
                            maxSize: 10000,
                            cropOpt: CropOption(),
                          );
                          if (res != null) {
                            img1 = res!.map((_) => _.path).toList();
                            setState(() {
                              for (int i = 0; i < img1.length; i++) {
                                path1.add(img1[i]);
                              }
                            });
                          }
                        } else {
                          setState(() {
                            path1.clear();
                          });
                        }
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "प्रोफाईल फोटो",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                        ),
                        w(10),
                        Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey),
                            child: Icon(
                              Icons.edit,
                              size: 15,
                              color: Colors.black87,
                            ))
                      ],
                    ),
                  ),
                  h(20),
                  AppTextField(
                    controller: _myProfileController.name.value,
                    hintText: 'आपले नाव ',
                    inputType: TextInputType.text,
                    lableText: 'आपले नाव',
                    textCapitalization: TextCapitalization.words,
                    inputAction: TextInputAction.next,
                    enable: editMode,
                  ),
                  // AppTextField(
                  //   controller: _myProfileController.address.value,
                  //   hintText: 'Enter your address',
                  //   inputType: TextInputType.text,
                  //   lableText: 'Address',
                  //   textCapitalization: TextCapitalization.sentences,
                  //   inputAction: TextInputAction.next,
                  // ),
                  AppTextField(
                    controller: _myProfileController.mobile.value,
                    hintText: 'मोबाईल नंबर टाका',
                    inputType: TextInputType.phone,
                    lableText: 'मोबाईल नंबर',
                    textCapitalization: TextCapitalization.none,
                    inputAction: TextInputAction.next,
                    enable: editMode,
                  ),

                  AppTextField(
                    controller: _myProfileController.refercode.value,
                    hintText: 'रेफर कोड',
                    inputType: TextInputType.text,
                    lableText: 'रेफर कोड',
                    textCapitalization: TextCapitalization.words,
                    inputAction: TextInputAction.done,
                    enable: false,
                    bgtrue: true,
                  ),
                  h(20),
                  editMode
                      ? InkWell(
                          onTap: () {
                            updateuserdata();
                          },
                          child: Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 14),
                            decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(6)),
                            child: const Center(
                                child: Text(
                              "अद्यावत करा",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            )),
                          ),
                        )
                      : SizedBox.shrink(),
                  h(30),
                ],
              ),
      ),
    );
  }
}
