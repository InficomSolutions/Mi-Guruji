import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:techno_teacher/api_utility/cont_urls.dart';
import 'package:techno_teacher/authcontroller.dart';
import 'package:techno_teacher/colors.dart';
import 'package:techno_teacher/pages/homepage/pdfdownloads.dart';
import 'package:techno_teacher/pages/homepage/sizedbox.dart';
import 'package:http/http.dart' as http;
import 'package:techno_teacher/widgets/text_field.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Walletpage extends StatefulWidget {
  const Walletpage({super.key});

  @override
  State<Walletpage> createState() => _WalletpageState();
}

class _WalletpageState extends State<Walletpage> {
  late Razorpay _razorpay;
  TextEditingController moneyamount = TextEditingController();
  amountadded() async {
    var token = await Authcontroller().getToken();
    try {
      http.Response response = await http.post(Uri.parse(TGuruJiUrl.addamount),
          headers: {'token': '$token'}, body: {"amount": moneyamount.text});
      var res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "wallet recharged successfully");
        getuserbalance();
        wallethistory();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  getuserbalance() async {
    var user = await getusertotal();
    setState(() {
      usertotal = user[0]["total_balance"];
      userdownloads = user[0]['total_downloads'];
    });
    print(user);
  }

  wallethistory() async {
    var token = await Authcontroller().getToken();
    try {
      http.Response response = await http
          .get(Uri.parse(TGuruJiUrl.history), headers: {'token': '$token'});
      var mapres = jsonDecode(response.body);
      var res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          history = mapres['data'];
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    wallethistory();
    getuserbalance();
    getusertotal();
    initializeRazorpay();
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void launchRazorpay() {
    var doublevalue = double.parse(moneyamount.text);
    var totalval = doublevalue.toInt() * 100;

    var options = {
      'key': "rzp_test_UqEJE4kPgpZccE",
      'amount': totalval,
      'currency': 'INR',
      'name': 'Mi Guruji',
      'description': '',
      'prefill': {
        'contact': userdata['user_details']['mobileno'],
        // 'email': userdata['data']['email']
      }
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
    await amountadded();
    Get.back();
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

  @override
  Widget build(BuildContext context) {
    print(history);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: whitecolor,
          ),
          backgroundColor: blackcolor,
          elevation: 0.7,
          centerTitle: true,
          title: const Text(
            "My Wallet",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
          ),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(blurRadius: 2.0, offset: const Offset(0, 2)),
                ], borderRadius: BorderRadius.circular(15.0), color: redcolor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Current Balance",
                          style: TextStyle(
                              color: whitecolor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: "assets/fonts/Poppins"),
                        ),
                        h(10),
                        Text(
                          usertotal ?? "0",
                          style: TextStyle(
                              color: whitecolor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: "assets/fonts/Poppins"),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: whitecolor,
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return addmoney();
                              });
                        },
                        child: Text(
                          'Add Money',
                          style: TextStyle(color: blackcolor),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Transaction History",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: "assets/fonts/Poppins"),
                ),
              ),
              history.isEmpty
                  ? const Center(child: Text("No transaction history"))
                  : Expanded(
                      child: ListView.builder(
                          // physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: history.length,
                          itemBuilder: (context, index) => Card(
                                color: int.parse(
                                            history[index]['credit_wallet']) ==
                                        0
                                    ? Colors.red
                                    : Colors.green,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Reason: ${history[index]['reason']}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            "₹${history[index][int.parse(history[index]['credit_wallet']) == 0 ? 'debit_wallet' : "credit_wallet"]}",
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                    ),
            ],
          ),
        ));
  }

  Widget addmoney() {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(Icons.close)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextField(
              keyboardType: TextInputType.number,
              controller: moneyamount,
              labelText: "Enter Amount",
            ),
          ),
          MaterialButton(
            color: greencolor,
            onPressed: () {
              if (moneyamount.text.isNotEmpty) {
                launchRazorpay();
              }
            },
            child: const Text("Add"),
          )
        ],
      ),
    );
  }
}
