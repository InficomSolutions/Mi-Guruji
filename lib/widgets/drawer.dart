import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:techno_teacher/api_utility/cont_urls.dart';
import 'package:techno_teacher/authcontroller.dart';
import 'package:techno_teacher/colors.dart';
import 'package:techno_teacher/getx_controller/student_info_controller/student_contorller.dart';
import 'package:techno_teacher/pages/homepage/help.dart';
import 'package:techno_teacher/pages/homepage/letterpad_view.dart';
import 'package:techno_teacher/pages/homepage/plans_page.dart';
import 'package:techno_teacher/pages/homepage/wallet_page.dart';
import 'package:techno_teacher/pages/login/login.dart';
import 'package:techno_teacher/pages/my_school/School_registration.dart';
import 'package:techno_teacher/pages/profile/my_profile.dart';
import 'package:techno_teacher/pages/student_info/student_detail_form.dart';
import 'package:techno_teacher/pages/teacher/teacher_info.dart';
import 'package:techno_teacher/utils/extension.dart';
import 'package:techno_teacher/utils/icons.dart';
import 'package:techno_teacher/utils/navigation.dart';
import 'package:techno_teacher/utils/text_styles.dart';
import 'package:techno_teacher/widgets/referpage.dart';
import 'package:techno_teacher/widgets/sizedbox.dart';

import '../utils/images.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final StudentController _controller = Get.put(StudentController());
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.only(left: 20, right: 20),
        children: [
          h(40),
          CircleAvatar(
            backgroundImage: userdata['user_details']["profile_img"] != null
                ? NetworkImage(
                    "${TGuruJiUrl.url}${userdata['user_details']["profile_img"]}")
                : Image.asset(
                    Images.profile,
                    fit: BoxFit.contain,
                  ).image,
            radius: 50,
          ),
          h(20),
          Center(
            child: Text(
              '${userdata['user_details']['name']}',
              style: bold(16),
            ),
          ),
          h(20),
          InkWell(
            onTap: () {
              Get.to(Walletpage())!.then((value) {
                setState(() {});
              });
            },
            child: Container(
              color: greencolor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'गुरुजी पाकीट',
                      style: bold(17, whitecolor),
                    ),
                    const Spacer(),
                    Text(
                      "₹ ${usertotal ?? 0}",
                      style: bold(15, whitecolor),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // h(10),
          // Row(
          //   children: [
          //     Text(
          //       'शिल्लक रक्कम',
          //       style: bold(17, bluecolor),
          //     ),
          //     const Spacer(),
          //     Text(
          //       '800',
          //       style: bold(15, bluecolor),
          //     ),
          //   ],
          // ),
          h(10),
          Container(
            color: redcolor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'डाऊनलोड',
                    style: bold(17, whitecolor),
                  ),
                  const Spacer(),
                  Text(
                    userdownloads ?? "0",
                    style: bold(15, whitecolor),
                  ),
                ],
              ),
            ),
          ),
          h(10),
          const Divider(
            thickness: 1,
          ),
          h(20),
          h(20),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyProfile(),
                  )).then((value) {
                setState(() {});
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                  width: 30,
                  child: SvgPicture.asset(
                    AppIcons.profile,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  "माझी प्रोफाईल",
                  style: bold(16, '#A80D37'.toColor()),
                ),
              ],
            ),
          ),
          h(20),
          h(10),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SchoolRegistration(),
                  )).then((value) {
                setState(() {});
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                  width: 30,
                  child: SvgPicture.asset(
                    AppIcons.school,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  "माझी शाळा",
                  style: bold(16, '#A80D37'.toColor()),
                ),
              ],
            ),
          ),
          // h(20),
          // h(10),
          // InkWell(
          //   onTap: () {
          //     Get.to(() => StudentInfo());
          //   },
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       SizedBox(
          //         height: 20,
          //         width: 30,
          //         child: SvgPicture.asset(
          //           AppIcons.profile,
          //         ),
          //       ),
          //       const SizedBox(
          //         width: 15,
          //       ),
          //       Text(
          //         "Student Info",
          //         style: bold(16, '#A80D37'.toColor()),
          //       ),
          //     ],
          //   ),
          // ),
          h(20),
          h(10),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TeacherInfo(),
                  )).then((value) {
                setState(() {});
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                  width: 30,
                  child: SvgPicture.asset(
                    AppIcons.profile,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  "शिक्षकाची माहिती",
                  style: bold(16, '#A80D37'.toColor()),
                ),
              ],
            ),
          ),
          h(20),
          h(10),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RefferalPage(),
                  )).then((value) {
                setState(() {});
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                  width: 30,
                  child: Image.asset(
                    AppIcons.refer,
                    color: '#A80D37'.toColor(),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  "रेफर",
                  style: bold(16, '#A80D37'.toColor()),
                ),
              ],
            ),
          ),
          h(20),
          h(10),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Planspage(),
                  )).then((value) {
                setState(() {});
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                  width: 30,
                  child: SvgPicture.asset(
                    AppIcons.plan,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  "प्लॅन",
                  style: bold(16, '#A80D37'.toColor()),
                ),
              ],
            ),
          ),
          h(20),
          h(10),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Help(),
                  )).then((value) {
                setState(() {});
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                  width: 30,
                  child: SvgPicture.asset(
                    AppIcons.help,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  "मदत",
                  style: bold(16, '#A80D37'.toColor()),
                ),
              ],
            ),
          ),
          h(20),
          h(10),
          InkWell(
            onTap: () {
              Authcontroller().deleteToken();
              Authcontroller().deletedate();
              removeScreens(context, const LoginPage());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                  width: 30,
                  child: SvgPicture.asset(
                    AppIcons.logout,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  "बाहेर पडा",
                  style: bold(16, '#A80D37'.toColor()),
                ),
              ],
            ),
          ),
          // DrawerItem(title: 'My Profile', path: AppIcons.profile),
          // DrawerItem(title: 'My School', path: AppIcons.school),
          // DrawerItem(title: 'My Plan', path: AppIcons.plan),
          // DrawerItem(title: 'Help', path: AppIcons.help),
          // DrawerItem(title: 'Logout', path: AppIcons.logout, logout: true,),
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String path;
  final String title;
  final Widget? page;
  final bool logout;

  const DrawerItem({
    Key? key,
    required this.title,
    required this.path,
    this.page,
    this.logout = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: SizedBox(
        height: 20,
        width: 30,
        child: SvgPicture.asset(
          path,
        ),
      ),
      title: Text(
        title,
        style: bold(16, '#A80D37'.toColor()),
      ),
      onTap: () {
        if (logout) {
          removeScreens(context, const LoginPage());

          return;
        }

        pop(context);
        toScreen(context, page);
      },
    );
  }
}
