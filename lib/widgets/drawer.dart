import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techno_teacher/pages/login/login.dart';
import 'package:techno_teacher/pages/my_school/School_registration.dart';
import 'package:techno_teacher/pages/profile/my_profile.dart';
import 'package:techno_teacher/utils/extension.dart';
import 'package:techno_teacher/utils/icons.dart';
import 'package:techno_teacher/utils/navigation.dart';
import 'package:techno_teacher/utils/text_styles.dart';
import 'package:techno_teacher/widgets/sizedbox.dart';

import '../utils/images.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.only(left: 20, right: 20),
        children: [
          h(40),
          CircleAvatar(
            backgroundImage: Image.asset(Images.profile).image,
            radius: 50,
          ),
          h(20),
          Center(
            child: Text(
              '0030502215',
              style: bold(16),
            ),
          ),
          h(20),
          Row(
            children: [
              Text(
                'Wallet',
                style: bold(17),
              ),
              const Spacer(),
              Text(
                '1000',
                style: bold(15),
              ),
            ],
          ),
          h(10),
          Row(
            children: [
              Text(
                'Balance',
                style: bold(17),
              ),
              const Spacer(),
              Text(
                '800',
                style: bold(15),
              ),
            ],
          ),
          h(10),
          Row(
            children: [
              Text(
                'Downloads',
                style: bold(17),
              ),
              const Spacer(),
              Text(
                '9999',
                style: bold(15),
              ),
            ],
          ),
          h(10),
          const Divider(thickness: 1,),
          h(20),
          h(20),
          InkWell(onTap: (){
            toScreen(context, MyProfile());
          },
            child: Row(mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                  width: 30,
                  child: SvgPicture.asset(
                      AppIcons.profile,
                  ),
                ),
               const SizedBox(width: 15,),
                Text(
                  "My Profile",
                  style: bold(16, '#A80D37'.toColor()),
                ),
              ],
            ),
          ),
          h(20),
          h(10),
          InkWell(onTap: (){
            toScreen(context, SchoolRegistration());
          },
            child: Row(mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                  width: 30,
                  child: SvgPicture.asset(
                    AppIcons.school,
                  ),
                ),
               const SizedBox(width: 15,),
                Text(
                  "My School",
                  style: bold(16, '#A80D37'.toColor()),
                ),
              ],
            ),
          ),
          h(20),
          h(10),
          Row(mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
                width: 30,
                child: SvgPicture.asset(
                  AppIcons.plan,
                ),
              ),
              const SizedBox(width: 15,),
              Text(
                "My Plans",
                style: bold(16, '#A80D37'.toColor()),
              ),
            ],
          ),
          h(20),
          h(10),
          Row(mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
                width: 30,
                child: SvgPicture.asset(
                  AppIcons.help,
                ),
              ),
              const SizedBox(width: 15,),
              Text(
                "Help",
                style: bold(16, '#A80D37'.toColor()),
              ),
            ],
          ),
          h(20),
          h(10),
          InkWell(onTap: (){
            removeScreens(context, const LoginPage());
            return;
          },
            child: Row(mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                  width: 30,
                  child: SvgPicture.asset(
                    AppIcons.logout,
                  ),
                ),
                const SizedBox(width: 15,),
                Text(
                  "Logout",
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
