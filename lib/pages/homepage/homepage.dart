import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:techno_teacher/pages/details/details.dart';
import 'package:techno_teacher/pages/homepage/my_books.dart';
import 'package:techno_teacher/pages/profile/select_profile.dart';
import 'package:techno_teacher/pages/slider/slider.dart';
import 'package:techno_teacher/utils/constants.dart';
import 'package:techno_teacher/utils/images.dart';
import 'package:techno_teacher/utils/navigation.dart';
import 'package:techno_teacher/widgets/drawer.dart';
import 'package:techno_teacher/widgets/sizedbox.dart';

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        elevation: 0.7,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10,),
            const SliderView(),
            const SizedBox(height: 20,),
            gridList()
          ],
        ),
      ),
    );
  }

  Widget gridList(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: Images.data.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(onTap: (){
              if(Images.data[index][1]=="वर्गनिहाय पुस्तकें"){
                _controller.myBooks();
                Get.to(()=>MyBooks());
              }else{
                toScreen(context, DetailsPage(title:Images.data[index][1]));
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
