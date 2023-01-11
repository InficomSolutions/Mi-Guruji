import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techno_teacher/getx_controller/student_info_controller/student_contorller.dart';

import '../../utils/snackbar/custom_snsckbar.dart';
import '../../widgets/sizedbox.dart';

class MyBooks extends StatelessWidget {
  MyBooks({Key? key}) : super(key: key);

  final StudentController _controller = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.7,
        centerTitle: true,
        title: const Text(
          "My Books",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
      ),
      body: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _controller.bookModel.value.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
            child: Container(
              height: 125,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xfff4f4f4),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "Class Name : ${_controller.bookModel.value[index].className}",
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16)),
                      Text("${_controller.bookModel.value[index].language}",
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16)),
                    ],
                  ),
                  h(15),
                  Text("${_controller.bookModel.value[index].bookName}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 16)),
                  h(15),
                  InkWell(
                    onTap: () {
                      var link = _controller.bookModel.value[index].downloadLink
                          .toString();
                      debugPrint("download  $link");
                      ShowCustomSnackBar().SuccessSnackBar("Downloading Start");
                    },
                    child: const Text("DownLoad Book",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.lightBlue,
                            fontWeight: FontWeight.w600,
                            fontSize: 16)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
