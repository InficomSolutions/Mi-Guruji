import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:techno_teacher/api_utility/cont_urls.dart';
import 'package:techno_teacher/authcontroller.dart';
import 'package:techno_teacher/colors.dart';
import 'package:http/http.dart' as http;
import 'package:techno_teacher/pages/homepage/homepage.dart';
import 'package:techno_teacher/pages/homepage/sizedbox.dart';
import 'package:techno_teacher/theme/light.dart';
import 'package:techno_teacher/utils/snackbar/custom_snsckbar.dart';

import '../../getx_controller/student_info_controller/student_contorller.dart';

class Planspage extends StatefulWidget {
  var token;
  Planspage({super.key, this.token});

  @override
  State<Planspage> createState() => _PlanspageState();
}

class _PlanspageState extends State<Planspage> {
  var selectedsub;
  bool? availableid;
  late Razorpay _razorpay;

  getplans() async {
    var token = await Authcontroller().getToken();
    try {
      var response = await http.get(Uri.parse(TGuruJiUrl.plans), headers: {
        'token': "${token ?? widget.token}",
      });
      debugPrint("=======res ${response.statusCode}");
      var res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          plansdata = res['data'];
        });
      } else {
        ShowCustomSnackBar().ErrorSnackBar(res['response']["message"]);
      }
    } catch (e) {
      print(e.toString);
    }
  }

  checkdata() {
    for (var d in plansdata) {
      if (d['id'] == subscribeddata[0]['plan_id']) {
        setState(() {
          availableid = true;
        });
      }
    }
  }

  getsubcribevalue() async {
    var token = await Authcontroller().getToken();
    var data = await subcribedplans("${token ?? widget.token}");
    setState(() {
      subscribeddata = data;
    });
    if (data.isNotEmpty) {
      checkdata();
    }
  }

  @override
  void initState() {
    super.initState();
    getplans();
    getsubcribevalue();
    initializeRazorpay();
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void launchRazorpay() {
    var doublevalue = double.parse(plansdata[selectedsub]['fee']);
    var totalval = doublevalue.toInt() * 100;

    var options = {
      'key': "rzp_test_UqEJE4kPgpZccE",
      'amount': totalval,
      'currency': 'INR',
      'name': 'Mi Guruji',
      'description': '',
      // 'prefill': {
      //   'contact': userdata['data']['mobileno'],
      //   'email': userdata['data']['email']
      // }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    }
  }

  void initializeRazorpay() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    var token = await Authcontroller().getToken();
    try {
      var response = await http.post(Uri.parse(TGuruJiUrl.buyplan), headers: {
        'token': "${token ?? widget.token}",
      }, body: {
        "plan_id": plansdata[selectedsub]['id']
      });
      debugPrint("=======res ${response.statusCode}");
      var res = jsonDecode(response.body);
      print(res);
      if (response.statusCode == 200) {
        var data = await subcribedplans("${token ?? widget.token}");
        Authcontroller().expirydate("${data[0]['plan_expiry_date']}");
        Authcontroller().storeToken("${token ?? widget.token}");
        Get.off(const Homepage());
      } else {
        ShowCustomSnackBar().ErrorSnackBar(res['response']["message"]);
      }
    } catch (e) {
      print(e.toString);
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    if (kDebugMode) {
      print('Payment error');
      Fluttertoast.showToast(msg: 'Payment error');
    }
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    if (kDebugMode) {
      print('External wallet');
      Fluttertoast.showToast(msg: 'Payment Failed');
    }
  }

  // Future successsubscription(
  //     var transaction_id, subscription_id, subscription_amount) async {
  //   var gettoken = await Authcontroller().getToken();
  //   http.Response response = await http.post(Uri.parse(""), headers: {
  //     'token': '$gettoken'
  //   }, body: {
  //     "amount": subscription_amount,
  //     "currency_code": "INR",
  //     "paytype": "razorpay",
  //     "subscription_id": subscription_id,
  //     "transaction_id": transaction_id,
  //   });
  //   print(json.decode(response.body));
  //   var res = jsonDecode(response.body);
  //   if (response.statusCode == 200) {}
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blackcolor,
        title: Text("प्लॅन"),
      ),
      body: plansdata.isEmpty
          ? CircularProgressIndicator(
              color: blackcolor,
            )
          : ListView(
              children: [
                availableid == null
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              border: Border.all(color: blackcolor, width: 2),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 5,
                                  color: blackcolor,
                                )
                              ],
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            children: [
                              Text(
                                "This Plan is not For New User\n Its Only Working Until Your Expired Date",
                                textAlign: TextAlign.center,
                                textScaleFactor: 1.5,
                              ),
                              h(15),
                              Text(
                                subscribeddata[0]['subscription_name'],
                                style: TextStyle(
                                  fontSize: 20,
                                  color: blackcolor,
                                ),
                              ),
                              Text(
                                "\u{20B9}${subscribeddata[0]['fee']}",
                                style: const TextStyle(fontSize: 30),
                              ),
                              h(20),
                              Text(
                                "This Plan is Active",
                                textScaleFactor: 1.2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                      "Start On:- ${subscribeddata[0]['plan_start_date']}"),
                                  Text(
                                      "Expired On:- ${subscribeddata[0]['plan_expiry_date']}"),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
                ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: plansdata.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        // height: MediaQuery.of(context).size.height / 4,
                        decoration: BoxDecoration(
                            color: whitecolor,
                            border: Border.all(color: blackcolor, width: 2),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 5,
                                color: blackcolor,
                              )
                            ],
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  plansdata[index]['subscription_name'],
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: blackcolor,
                                  ),
                                ),
                                Text(
                                  "\u{20B9}${plansdata[index]['fee']}",
                                  style: const TextStyle(fontSize: 30),
                                )
                              ],
                            ),
                            h(20),
                            Text(
                              'Duration :- ${plansdata[index]['fee_description']}',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: blackcolor,
                                  fontWeight: FontWeight.w500),
                            ),
                            h(20),
                            widget.token != null && subscribeddata.isEmpty
                                ? Container(
                                    decoration: BoxDecoration(
                                        color: primaryColor,
                                        gradient: LinearGradient(colors: [
                                          primaryColor,
                                          leterpadcolor,
                                        ]),
                                        border: Border.all(
                                            color: blackcolor, width: 1),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: MaterialButton(
                                        onPressed: () {
                                          setState(() {
                                            selectedsub = index;
                                          });
                                          launchRazorpay();
                                        },
                                        child: Text(
                                          'get plan',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: whitecolor,
                                          ),
                                        )),
                                  )
                                : SizedBox.shrink(),
                            h(20),
                            subscribeddata.isNotEmpty
                                ? (subscribeddata[0]['plan_id'] ?? "") !=
                                        plansdata[index]['id']
                                    ? SizedBox.shrink()
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          child: Column(
                                            children: [
                                              Text(
                                                "This Plan is Active",
                                                textScaleFactor: 1.2,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text(
                                                      "Start On:- ${subscribeddata[0]['plan_start_date']}"),
                                                  Text(
                                                      "Expired On:- ${subscribeddata[0]['plan_expiry_date']}"),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                : SizedBox.shrink(),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
    );
  }
}
