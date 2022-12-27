import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techno_teacher/getx_controller/my_profile_controller/my+profile_controller.dart';

import '../../widgets/custom_textfield.dart';
import '../../widgets/sizedbox.dart';

class MyProfile extends StatelessWidget {
   MyProfile({Key? key}) : super(key: key);

  MyProfileController _myProfileController = Get.put(MyProfileController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.7,
        title: Text(
          "My Profile",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            h(40),
            Center(
              child: Container(
                height: 140,
                width: 140,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(width: 2, color: Colors.green),
                    color: Colors.red),
              ),
            ),
            h(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Profile Photo",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
                w(10),
                Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey),
                    child: Icon(
                      Icons.edit,
                      size: 15,
                      color: Colors.black87,
                    ))
              ],
            ),
            h(20),
            AppTextField(
               controller: _myProfileController.name.value,
              hintText: 'Enter your name',
              inputType: TextInputType.text,
              lableText: 'Name',
              textCapitalization: TextCapitalization.words,
              inputAction: TextInputAction.next,
            ),
            AppTextField(
              controller: _myProfileController.address.value,
              hintText: 'Enter your address',
              inputType: TextInputType.text,
              lableText: 'Address',
              textCapitalization: TextCapitalization.sentences,
              inputAction: TextInputAction.next,
            ),

            AppTextField(
              controller: _myProfileController.mobile.value,
              hintText: 'Enter your mobile',
              inputType: TextInputType.phone,
              lableText: 'Phone',
              textCapitalization: TextCapitalization.none,
              inputAction: TextInputAction.next,
            ),

            AppTextField(
              controller: _myProfileController.refercode.value,
              hintText: 'Enter reference code',
              inputType: TextInputType.text,
              lableText: 'Refer Code',
              textCapitalization: TextCapitalization.words,
              inputAction: TextInputAction.done,
            ),
            h(20),
            Container(height: 50,margin: EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(6)),
            child: Center(child: Text("Submit",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),)),),
            h(30),
          ],
        ),
      ),
    );
  }
}
