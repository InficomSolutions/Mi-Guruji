import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techno_teacher/pages/details/details.dart';
import 'package:techno_teacher/pages/profile/select_profile.dart';
import 'package:techno_teacher/pages/slider/slider.dart';
import 'package:techno_teacher/utils/constants.dart';
import 'package:techno_teacher/utils/images.dart';
import 'package:techno_teacher/utils/navigation.dart';
import 'package:techno_teacher/widgets/drawer.dart';
import 'package:techno_teacher/widgets/sizedbox.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const CustomDrawer(),
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: true,
              elevation: 0,
              titleSpacing: 0,
              title: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => const SelectProfile());
                    },
                    child: CircleAvatar(
                      backgroundImage: Image.asset(Images.profile).image,
                    ),
                  ),
                  w(15),
                  Text(AppConstants.appName),
                ],
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.black),
                    child: SvgPicture.asset(
                      Images.bell,
                      height: 20,
                      width: 20,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.black),
                    child: SvgPicture.asset(
                      Images.language,
                    ),
                  ),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SliderView(),
                  GestureDetector(
                    onTap: () {
                      toScreen(context, const DetailsPage());
                    },
                    child: Image.asset(Images.homeItems),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
