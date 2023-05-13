import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:techno_teacher/api_utility/cont_urls.dart';
import 'package:techno_teacher/authcontroller.dart';
import 'package:techno_teacher/colors.dart';
import 'package:techno_teacher/pages/homepage/mobile.dart';
import 'package:http/http.dart' as http;
import 'package:techno_teacher/utils/navigation.dart';
import 'package:techno_teacher/utils/snackbar/custom_snsckbar.dart';

downloadpdf(BuildContext context, var link, title) async {
  var documentBytes = await http.readBytes(Uri.parse("$link"));
  ShowCustomSnackBar().SuccessSnackBar("Downloading Start");
  downloadcount();
  SaveAndLaunchFile(documentBytes, '$title.pdf', context);
}

confirmationbox(BuildContext context, {var amount, onpress}) {
  return Dialog(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
                onTap: () {
                  pop(context);
                },
                child: Icon(Icons.close)),
          ),
          Text("$amount will we deduct from your wallet"),
          Align(
            alignment: Alignment.center,
            child: MaterialButton(
              color: redcolor,
              onPressed: onpress,
              child: Text(
                "Cofirm",
                style: TextStyle(color: whitecolor),
              ),
            ),
          )
        ],
      ),
    ),
  );
}

downloadcount() async {
  var token = await Authcontroller().getToken();
  print("token$token");
  try {
    var response =
        await http.post(Uri.parse(TGuruJiUrl.downlaodcount), headers: {
      'token': "$token",
    });
    debugPrint("=======res ${response.statusCode}");
    var res = jsonDecode(response.body);
    if (response.statusCode == 200) {
    } else {
      ShowCustomSnackBar().ErrorSnackBar(res['response']["message"]);
    }
  } catch (e) {
    print(e.toString);
  }
}

downloaddeduct(var amount, remark) async {
  var token = await Authcontroller().getToken();
  print("token$token");
  try {
    var response =
        await http.post(Uri.parse(TGuruJiUrl.downloaddeduction), headers: {
      'token': "$token",
    }, body: {
      "amount": amount,
      "remarks": remark,
    });
    debugPrint("=======res ${response.statusCode}");
    var res = jsonDecode(response.body);
    if (response.statusCode == 200) {
    } else {
      ShowCustomSnackBar().ErrorSnackBar(res['response']["message"]);
    }
  } catch (e) {
    print(e.toString);
  }
}

getusertotal() async {
  var token = await Authcontroller().getToken();
  print("token$token");
  try {
    var response = await http.get(Uri.parse(TGuruJiUrl.getusertotal), headers: {
      'token': "$token",
    });
    debugPrint("=======res ${response.statusCode}");
    var res = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return res['data'];
    } else {
      ShowCustomSnackBar().ErrorSnackBar(res['response']["response_message"]);
    }
  } catch (e) {
    print(e.toString);
  }
}
