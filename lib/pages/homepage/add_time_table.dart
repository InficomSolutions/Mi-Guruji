import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:techno_teacher/api_utility/cont_urls.dart';
import 'package:techno_teacher/authcontroller.dart';
import 'package:techno_teacher/colors.dart';
import 'package:techno_teacher/utils/snackbar/custom_snsckbar.dart';
import 'package:techno_teacher/widgets/text_field.dart';

class Addtimetablepage extends StatefulWidget {
  var data;
  Addtimetablepage({super.key, this.data});

  @override
  State<Addtimetablepage> createState() => _AddtimetablepageState();
}

class _AddtimetablepageState extends State<Addtimetablepage> {
  var selectedday;
  List<TextEditingController> subject = [];
  TextEditingController timetableclass = TextEditingController();
  List fromintervel = [];
  List tointervel = [];
  List fromperiod = [];
  List toperiod = [];

  @override
  void initState() {
    super.initState();
    subject =
        List.generate(9, (index) => TextEditingController(), growable: false);
    fromintervel =
        List.generate(4, (index) => TimeOfDay.now(), growable: false);
    tointervel = List.generate(4, (index) => TimeOfDay.now(), growable: false);
    fromperiod = List.generate(9, (index) => TimeOfDay.now(), growable: false);
    toperiod = List.generate(9, (index) => TimeOfDay.now(), growable: false);
    if (widget.data != null) {
      setdata();
    } else {
      selectedday = weeklist[0];
    }
  }

  setdata() {
    setState(() {
      selectedday = widget.data['day'];
      timetableclass.text = widget.data['class'];
      subject[0].text = widget.data['sub_one'];
      subject[1].text = widget.data['sub_two'];
      subject[2].text = widget.data['sub_three'];
      subject[3].text = widget.data['sub_four'];
      subject[4].text = widget.data['sub_five'];
      subject[5].text = widget.data['sub_six'];
      subject[6].text = widget.data['sub_seven'];
      subject[7].text = widget.data['sub_eight'];
      subject[8].text = widget.data['sub_nine'];
      fromintervel[0] = TimeOfDay.fromDateTime(
          DateFormat.jm().parse("${widget.data['time_one']}".split("- ")[0]));
      tointervel[0] = TimeOfDay.fromDateTime(
          DateFormat.jm().parse("${widget.data['time_one']}".split("- ")[1]));
      fromintervel[1] = TimeOfDay.fromDateTime(
          DateFormat.jm().parse("${widget.data['time_two']}".split("- ")[0]));
      tointervel[1] = TimeOfDay.fromDateTime(
          DateFormat.jm().parse("${widget.data['time_two']}".split("- ")[1]));
      fromintervel[2] = TimeOfDay.fromDateTime(
          DateFormat.jm().parse("${widget.data['time_three']}".split("- ")[0]));
      tointervel[2] = TimeOfDay.fromDateTime(
          DateFormat.jm().parse("${widget.data['time_three']}".split("- ")[1]));
      fromintervel[3] = TimeOfDay.fromDateTime(
          DateFormat.jm().parse("${widget.data['time_four']}".split("- ")[0]));
      tointervel[3] = TimeOfDay.fromDateTime(
          DateFormat.jm().parse("${widget.data['time_four']}".split("- ")[1]));
      fromperiod[0] = TimeOfDay.fromDateTime(DateFormat.jm()
          .parse("${widget.data['first_period']}".split(" to ")[0]));
      toperiod[0] = TimeOfDay.fromDateTime(DateFormat.jm()
          .parse("${widget.data['first_period']}".split(" to ")[1]));
      fromperiod[1] = TimeOfDay.fromDateTime(DateFormat.jm()
          .parse("${widget.data['second_period']}".split(" to ")[0]));
      toperiod[1] = TimeOfDay.fromDateTime(DateFormat.jm()
          .parse("${widget.data['second_period']}".split(" to ")[1]));
      fromperiod[2] = TimeOfDay.fromDateTime(DateFormat.jm()
          .parse("${widget.data['third_period']}".split(" to ")[0]));
      toperiod[2] = TimeOfDay.fromDateTime(DateFormat.jm()
          .parse("${widget.data['third_period']}".split(" to ")[1]));
      fromperiod[3] = TimeOfDay.fromDateTime(DateFormat.jm()
          .parse("${widget.data['fourth_period']}".split(" to ")[0]));
      toperiod[3] = TimeOfDay.fromDateTime(DateFormat.jm()
          .parse("${widget.data['fourth_period']}".split(" to ")[1]));
      fromperiod[4] = TimeOfDay.fromDateTime(DateFormat.jm()
          .parse("${widget.data['fifth_period']}".split(" to ")[0]));
      toperiod[4] = TimeOfDay.fromDateTime(DateFormat.jm()
          .parse("${widget.data['fifth_period']}".split(" to ")[1]));
      fromperiod[5] = TimeOfDay.fromDateTime(DateFormat.jm()
          .parse("${widget.data['sixth_period']}".split(" to ")[0]));
      toperiod[5] = TimeOfDay.fromDateTime(DateFormat.jm()
          .parse("${widget.data['sixth_period']}".split(" to ")[1]));
      fromperiod[6] = TimeOfDay.fromDateTime(DateFormat.jm()
          .parse("${widget.data['seventh_period']}".split(" to ")[0]));
      toperiod[6] = TimeOfDay.fromDateTime(DateFormat.jm()
          .parse("${widget.data['seventh_period']}".split(" to ")[1]));
      fromperiod[7] = TimeOfDay.fromDateTime(DateFormat.jm()
          .parse("${widget.data['eighth_period']}".split(" to ")[0]));
      toperiod[7] = TimeOfDay.fromDateTime(DateFormat.jm()
          .parse("${widget.data['eighth_period']}".split(" to ")[1]));
      fromperiod[8] = TimeOfDay.fromDateTime(DateFormat.jm()
          .parse("${widget.data['ninth_period']}".split(" to ")[0]));
      toperiod[8] = TimeOfDay.fromDateTime(DateFormat.jm()
          .parse("${widget.data['ninth_period']}".split(" to ")[1]));
    });
  }

  @override
  Widget build(BuildContext context) {
    print(fromintervel[0]);
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
          "वेळापत्रक तयार करा",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
        ),
      ),
      body: ListView(
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 2.5,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton(
                value: selectedday,
                items: List.generate(
                    weeklist.length,
                    (index) => DropdownMenuItem(
                        value: weeklist[index],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(weeklist[index]),
                        ))),
                onChanged: (value) {
                  setState(() {
                    selectedday = value;
                  });
                },
              ),
            ),
          ),
          CustomTextField(
            controller: timetableclass,
            labelText: 'Class',
            keyboardType: TextInputType.number,
          ),
          ...List.generate(
            fromintervel.length,
            (index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(intervel[index]),
                  Row(
                    children: [
                      Expanded(
                          child: picktime(fromintervel[index].format(context))),
                      Text('ते'),
                      Expanded(
                          child: picktime(tointervel[index].format(context))),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ...List.generate(
            subject.length,
            (index) => Column(
              children: [
                CustomTextField(
                  controller: subject[index],
                  labelText: periods[index],
                ),
                Row(
                  children: [
                    Expanded(
                        child: picktime(fromperiod[index].format(context))),
                    Text('ते'),
                    Expanded(child: picktime(toperiod[index].format(context))),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                addtimetable();
              },
              child: Container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(6)),
                child: Center(
                    child: Text(
                  "Submit",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  picktime(var time) {
    return StatefulBuilder(
      builder: (BuildContext context, setState) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: InkWell(
            onTap: () async {
              TimeOfDay? pickedTime = await showTimePicker(
                initialTime: TimeOfDay.now(),
                context: context, //context of current state
              );
              print(pickedTime);

              if (pickedTime != null) {
                setState(() {
                  time = pickedTime.format(context).toString();
                });
              } else {
                if (kDebugMode) {
                  print("Time is not selected");
                }
              }
            },
            child: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: 40,
                color: whitecolor,
                child: Center(
                  child: Text(
                    '${time ?? TimeOfDay.now()}',
                    style: TextStyle(color: blackcolor),
                  ),
                )),
          ),
        );
      },
    );
  }

  List intervel = [
    'परिपाठ',
    'लहान सुट्टी',
    'मोठी सुट्टी',
    'लहान सुट्टी',
  ];

  List periods = [
    '१ ला तास',
    '२ ला तास',
    '३ ला तास',
    '४ ला तास',
    '५ ला तास',
    '६ ला तास',
    '७ ला तास',
    '८ ला तास',
    '९ ला तास',
  ];

  void addtimetable() async {
    var token = await Authcontroller().getToken();
    try {
      var response =
          await http.post(Uri.parse(TGuruJiUrl.addtimetable), headers: {
        'token': "$token",
      }, body: {
        'day': selectedday,
        'class': timetableclass.text,
        'time_one':
            '${fromintervel[0].format(context)} - ${tointervel[0].format(context)}',
        'sub_one': subject[0].text,
        'sub_two': subject[1].text,
        'sub_three': subject[2].text,
        'time_two':
            '${fromintervel[1].format(context)} - ${tointervel[1].format(context)}',
        'sub_four': subject[3].text,
        'sub_five': subject[4].text,
        'time_three':
            '${fromintervel[2].format(context)} - ${tointervel[2].format(context)}',
        'sub_six': subject[5].text,
        'sub_seven': subject[6].text,
        'time_four':
            '${fromintervel[3].format(context)} - ${tointervel[3].format(context)}',
        'sub_eight': subject[7].text,
        'sub_nine': subject[8].text,
        'first_period':
            '${fromperiod[0].format(context)} to ${toperiod[0].format(context)}',
        'second_period':
            '${fromperiod[1].format(context)} to ${toperiod[1].format(context)}',
        'third_period':
            '${fromperiod[2].format(context)} to ${toperiod[2].format(context)}',
        'fourth_period':
            '${fromperiod[3].format(context)} to ${toperiod[3].format(context)}',
        'fifth_period':
            '${fromperiod[4].format(context)} to ${toperiod[4].format(context)}',
        'sixth_period':
            '${fromperiod[5].format(context)} to ${toperiod[5].format(context)}',
        'seventh_period':
            '${fromperiod[6].format(context)} to ${toperiod[6].format(context)}',
        'eighth_period':
            '${fromperiod[7].format(context)} to ${toperiod[7].format(context)}',
        'ninth_period':
            '${fromperiod[8].format(context)} to ${toperiod[8].format(context)}',
        'id': widget.data == null ? '0' : widget.data['id'],
      });
      debugPrint("=======res ${response.statusCode}");
      var res = jsonDecode(response.body);
      print(response.body);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: res['response']["response_message"]);
        Get.back();
      } else {
        ShowCustomSnackBar().ErrorSnackBar(res['response']["response_message"]);
      }
    } catch (e) {
      //ShowCustomSnackBar().ErrorSnackBar("error");
      print(e.toString);
      print(e);
    }
  }
}
