import 'package:flutter/material.dart';
import 'package:techno_teacher/utils/text_styles.dart';
import 'package:techno_teacher/widgets/sizedbox.dart';

class SelectProfile extends StatefulWidget {
  const SelectProfile({Key? key}) : super(key: key);

  @override
  State<SelectProfile> createState() => _SelectProfileState();
}

class _SelectProfileState extends State<SelectProfile> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      title: Center(
        child: Text(
          'Select Profile',
          style: bold(20, Colors.white),
        ),
      ),
      contentPadding:
          const EdgeInsets.only(left: 3, right: 3, top: 5, bottom: 5),
      content: Card(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 30, bottom: 50, left: 5, right: 5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                elevation: 2.5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            Image.asset('assets/images/personal_profile.png')
                                .image,
                      ),
                      w(10),
                      const Text('Personal Profile'),
                    ],
                  ),
                ),
              ),
              h(10),
              Card(
                elevation: 2.5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            Image.asset('assets/images/school_profile1.png')
                                .image,
                      ),
                      w(10),
                      const Text('School Profile 1'),
                    ],
                  ),
                ),
              ),
              h(10),
              Card(
                elevation: 2.5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            Image.asset('assets/images/school_profile2.png')
                                .image,
                      ),
                      w(10),
                      const Text('School Profile 2'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
