import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:techno_teacher/api_utility/cont_urls.dart';
import 'package:techno_teacher/colors.dart';
import 'package:techno_teacher/pages/homepage/sizedbox.dart';
import 'package:techno_teacher/theme/light.dart';
import 'package:techno_teacher/widgets/dynamiclink.dart';

class RefferalPage extends StatefulWidget {
  const RefferalPage({super.key});

  @override
  State<RefferalPage> createState() => _RefferalPageState();
}

class _RefferalPageState extends State<RefferalPage> {
  List iconlist = [
    {"icon": Icons.person, "title": "Invite Your Friend To signup"},
    {"icon": Icons.download, "title": "Download the App"},
    {"icon": Icons.phone_android, "title": "Create Account"},
    {"icon": Icons.monetization_on, "title": "Earn"}
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: blackcolor,
          ),
          title: Text(
            "रेफर",
            style: TextStyle(color: blackcolor),
          ),
          backgroundColor: whitecolor,
        ),
        backgroundColor: blackcolor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: whitecolor,
                      border: Border.all(color: whitecolor),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                          iconlist.length,
                          (index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Stack(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: blackcolor,
                                          child: Icon(
                                            iconlist[index]['icon'],
                                            color: whitecolor,
                                          ),
                                        ),
                                        Positioned(
                                          child: CircleAvatar(
                                            radius: 8,
                                            child: Text(
                                              "${index + 1}",
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.5,
                                      child: Text(
                                        iconlist[index]['title'],
                                        textAlign: TextAlign.start,
                                      ),
                                    )
                                  ],
                                ),
                              ))),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "Your Referral Code",
                  textScaleFactor: 1.5,
                  style: TextStyle(color: whitecolor),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                      color: whitecolor,
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          userdata['user_details']['referal_user_code'],
                          textScaleFactor: 1.5,
                          style: TextStyle(color: blackcolor),
                        ),
                        InkWell(
                            onTap: () {
                              Clipboard.setData(ClipboardData(
                                  text: userdata['user_details']
                                      ['referal_user_code']));
                            },
                            child: Icon(Icons.copy))
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(
                        text: userdata['user_details']['referal_user_code']));
                  },
                  child: Text(
                    "Tap To Copy",
                    textScaleFactor: 1.5,
                    style: TextStyle(color: whitecolor),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Dynamiclinkprovider()
                      .shareReferralLink(
                          userdata['user_details']['referal_user_code'])
                      .then((value) => Share.share(
                          '$value\n Click On Link & Download the App'));
                },
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Refer Now ",
                            textScaleFactor: 1.5,
                            style: TextStyle(color: blackcolor),
                          ),
                          Icon(Icons.share)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
