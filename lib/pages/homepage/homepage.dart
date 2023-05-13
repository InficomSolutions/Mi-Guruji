import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:techno_teacher/api_utility/cont_urls.dart';
import 'package:techno_teacher/authcontroller.dart';
import 'package:techno_teacher/colors.dart';
import 'package:techno_teacher/pages/details/details.dart';
import 'package:techno_teacher/pages/homepage/blog_list.dart';
import 'package:techno_teacher/pages/homepage/commitee.dart';
import 'package:techno_teacher/pages/homepage/exam_info_page.dart';
import 'package:techno_teacher/pages/homepage/form_list.dart';
import 'package:techno_teacher/pages/homepage/genrate_letter_pad.dart';
import 'package:techno_teacher/pages/homepage/goverment_circular.dart';
import 'package:techno_teacher/pages/homepage/help.dart';
import 'package:techno_teacher/pages/homepage/monthly_task.dart';
import 'package:techno_teacher/pages/homepage/my_books.dart';
import 'package:techno_teacher/pages/homepage/notification.dart';
import 'package:techno_teacher/pages/homepage/nutrition_food.dart';
import 'package:techno_teacher/pages/homepage/paripath_page.dart';
import 'package:techno_teacher/pages/homepage/pdfdownloads.dart';
import 'package:techno_teacher/pages/homepage/question_paper.dart';
import 'package:techno_teacher/pages/homepage/result_page.dart';
import 'package:techno_teacher/pages/homepage/siniority_page.dart';
import 'package:techno_teacher/pages/homepage/sport_rule.dart';
import 'package:techno_teacher/pages/homepage/student_info.dart';
import 'package:techno_teacher/pages/homepage/techno_teacher.dart';
import 'package:techno_teacher/pages/homepage/time_table.dart';
import 'package:techno_teacher/pages/homepage/update_page.dart';
import 'package:techno_teacher/pages/profile/select_profile.dart';
import 'package:techno_teacher/pages/slider/slider.dart';
import 'package:techno_teacher/pages/student_info/student_detail_form.dart';
import 'package:techno_teacher/utils/constants.dart';
import 'package:techno_teacher/utils/images.dart';
import 'package:techno_teacher/utils/navigation.dart';
import 'package:techno_teacher/utils/snackbar/custom_snsckbar.dart';
import 'package:techno_teacher/widgets/drawer.dart';
import 'package:techno_teacher/widgets/sizedbox.dart';
import 'package:http/http.dart' as http;
import '../../getx_controller/student_info_controller/student_contorller.dart';
import 'dhashboard.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final ScrollController _scrollController = ScrollController();
  final StudentController _controller = Get.put(StudentController());

  getdata() async {
    var gettoken = await Authcontroller().getToken();
    if (kDebugMode) {
      print(gettoken);
    }
    http.Response response = await http
        .get(Uri.parse(TGuruJiUrl.userdata), headers: {'token': "$gettoken"});

    var mapreduce = json.decode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        userdata = mapreduce['data'];
      });
    }
  }

  letterPad() async {
    var token = await Authcontroller().getToken();
    try {
      var response = await http.get(Uri.parse(TGuruJiUrl.laterPad), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'token': "$token",
      });
      debugPrint("=======res ${response.statusCode}");
      var res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          latterpaddata = res['data'];
        });
      } else {
        ShowCustomSnackBar().ErrorSnackBar(res['respnse']["message"]);
      }
    } catch (e) {
      //ShowCustomSnackBar().ErrorSnackBar("error");
      print(e.toString);
    }
  }

  getslider() async {
    var gettoken = await Authcontroller().getToken();
    if (kDebugMode) {
      print(gettoken);
    }
    http.Response response = await http
        .get(Uri.parse(TGuruJiUrl.slider), headers: {'token': "$gettoken"});

    var mapreduce = json.decode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        slider = mapreduce['data'];
      });
    }
    try {
      var response =
          await http.get(Uri.parse(TGuruJiUrl.routineinfo), headers: {
        'token': "$gettoken",
      });
      debugPrint("=======res ${response.statusCode}");
      var res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          // paripathdata = res['data'];
          constitustion = res['data']['constitution'];
          national = res['data']['national'];
          prayer = res['data']['prayer'];
          dailyprayer = res['data']['daily_prayer'];
          debate = res['data']['debate'];
          group = res['data']['group'];
          story = res['data']['story'];
        });
        setState(() {});
      } else {
        ShowCustomSnackBar().ErrorSnackBar(res['response']["message"]);
      }
    } catch (e) {}
  }

  getuserbalance() async {
    var user = await getusertotal();
    setState(() {
      usertotal = user[0]["total_balance"];
      userdownloads = user[0]['total_downloads'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
    getuserbalance();
    getslider();
    letterPad();
  }

  @override
  Widget build(BuildContext context) {
    print(latterpaddata);
    return Scaffold(
      backgroundColor: whitecolor,
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: whitecolor,
        foregroundColor: blackcolor,
        elevation: 0.7,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                // showDialog(
                //     context: context,
                //     builder: (context) => const SelectProfile());
              },
              child: userdata != null
                  ? CircleAvatar(
                      backgroundImage: userdata['user_details']
                                  ["profile_img"] !=
                              null
                          ? NetworkImage(
                              "${TGuruJiUrl.url}${userdata['user_details']["profile_img"]}")
                          : Image.asset(Images.profile).image,
                    )
                  : Center(),
            ),
            w(15),
            userdata == null
                ? Center(
                    child: Text("मी गुरुजी"),
                  )
                : Text("Hi, ${userdata['user_details']['name']}"),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: IconButton(
              onPressed: () {
                toScreen(context, NotificationPage());
              },
              icon: Container(
                padding: const EdgeInsets.all(6),
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.black),
                child: SvgPicture.asset(
                  Images.bell,
                  height: 20,
                  width: 20,
                ),
              ),
            ),
          ),
          // IconButton(
          //   onPressed: () {},
          //   icon: Container(
          //     padding: const EdgeInsets.all(8),
          //     width: 50,
          //     height: 50,
          //     decoration: const BoxDecoration(
          //         shape: BoxShape.circle, color: Colors.black),
          //     child: SvgPicture.asset(
          //       Images.language,
          //     ),
          //   ),
          // ),
        ],
      ),
      body: RefreshIndicator(
        color: blackcolor,
        onRefresh: () async {
          getdata();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              SliderView(),
              const SizedBox(
                height: 20,
              ),
              gridList()
            ],
          ),
        ),
      ),
    );
  }

  Widget gridList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: Images.data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {
                if (Images.data[index][1] == "वर्गनिहाय पुस्तकें") {
                  Get.to(() => MyBooks());
                } else if (Images.data[index][1] == "माझी शाला") {
                  Get.to(() => GenrateLetterPad());
                } else if (Images.data[index][1] == "शंका समाधान") {
                  Get.to(() => Help());
                } else if (Images.data[index][1] == "सेवाजेष्ठता यादी") {
                  Get.to(() => Senioritypage());
                } else if (Images.data[index][1] == "विविध शासाकी परित्रके") {
                  Get.to(() => Govermentcircular());
                } else if (Images.data[index][1] == "विविध फॉर्म") {
                  Get.to(() => Formlistpage());
                } else if (Images.data[index][1] ==
                    "वर्ग निहाय प्रश्नपत्रिका") {
                  Get.to(() => Questionpaper());
                } else if (Images.data[index][1] == "या महिन्यातील कामे") {
                  Get.to(() => Monthlytask());
                } else if (Images.data[index][1] == "तकनीकी शिक्षक") {
                  Get.to(() => Technoteacher());
                } else if (Images.data[index][1] == "विविध खेल नियमावली") {
                  Get.to(() => Sportrule());
                } else if (Images.data[index][1] == "अपडेट") {
                  Get.to(() => Updatepage());
                } else if (Images.data[index][1] == "परिपाठ") {
                  Get.to(() => Paripathpage());
                } else if (Images.data[index][1] == "विविध समित्य") {
                  Get.to(() => Commitee());
                } else if (Images.data[index][1] ==
                    "वर्ग निहाय विद्यार्थी यादी") {
                  Get.to(() => Studentinfo());
                } else if (Images.data[index][1] == "पोषण आहार") {
                  Get.to(() => Nutritionfood());
                } else if (Images.data[index][1] ==
                    "वर्गनिहाय परीक्षा माहिली") {
                  Get.to(() => Examinfo());
                } else if (Images.data[index][1] == "समय सारणी") {
                  Get.to(() => Timetablepage());
                } else if (Images.data[index][1] == "निकाल") {
                  Get.to(() => Resultpage());
                } else {
                  toScreen(context, DetailsPage(title: Images.data[index][1]));
                }
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(Images.data[index][0]),
              ),
            ),
          );
        },
      ),
    );
  }
}
