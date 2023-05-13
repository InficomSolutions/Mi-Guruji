import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:techno_teacher/api_utility/cont_urls.dart';
import 'package:techno_teacher/authcontroller.dart';
import 'package:techno_teacher/colors.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:http/http.dart' as http;
import 'package:techno_teacher/theme/light.dart';
import 'package:techno_teacher/utils/snackbar/custom_snsckbar.dart';
import 'package:techno_teacher/widgets/text_field.dart';

class Monthlytask extends StatefulWidget {
  const Monthlytask({super.key});

  @override
  State<Monthlytask> createState() => _MonthlytaskState();
}

class _MonthlytaskState extends State<Monthlytask> {
  var selecteddate;
  var taskinfo;
  var todaydate = DateTime.now();
  getmonthlytask() async {
    var token = await Authcontroller().getToken();
    print("token$token");
    try {
      var response = await http.get(Uri.parse(TGuruJiUrl.gettask), headers: {
        'token': "$token",
      });
      debugPrint("=======res ${response.statusCode}");
      var res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          montlytaskdata = res['data'];
          date.clear();
          for (int i = 0; i < montlytaskdata.length; i++) {
            date.add(DateTime.parse(montlytaskdata[i]['date']));
          }
          taskinfo = montlytaskdata.where(
            (element) => DateTime.parse("${element['date']}") == selecteddate,
          );
        });
      } else {
        ShowCustomSnackBar().ErrorSnackBar(res['response']["message"]);
      }
    } catch (e) {
      //ShowCustomSnackBar().ErrorSnackBar("error");
      print(e.toString);
    }
  }

  @override
  void initState() {
    super.initState();
    var newdate = '${todaydate.year}-${todaydate.month}-${todaydate.day}';
    if (todaydate.month <= 9) {
      newdate = '${todaydate.year}-0${todaydate.month}-${todaydate.day}';
    }
    if (todaydate.day <= 9) {
      newdate = '${todaydate.year}-${todaydate.month}-0${todaydate.day}';
    }
    if (todaydate.month <= 9 && todaydate.day <= 9) {
      newdate = '${todaydate.year}-0${todaydate.month}-0${todaydate.day}';
    }
    selecteddate = DateTime.parse(newdate);
    montlytaskdata.isNotEmpty
        ? taskinfo = montlytaskdata.where(
            (element) => DateTime.parse("${element['date']}") == selecteddate,
          )
        : null;
    getmonthlytask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: greencolor,
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => addmonthlytask(context),
            );
          },
          child: Icon(
            Icons.add,
            color: blackcolor,
          ),
        ),
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: whitecolor,
          ),
          backgroundColor: blackcolor,
          elevation: 0.7,
          centerTitle: true,
          title: const Text(
            "या महिन्यातील कामे",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 1.6,
                child: CalendarCarousel(
                  todayBorderColor: blackcolor,
                  todayButtonColor: Colors.transparent,
                  onDayPressed: (DateTime date, List events) {
                    setState(() {
                      selecteddate = date;
                      taskinfo = montlytaskdata.where(
                        (element) =>
                            DateTime.parse("${element['date']}") ==
                            selecteddate,
                      );
                    });
                  },
                  weekendTextStyle: const TextStyle(
                    color: Colors.red,
                  ),
                  thisMonthDayBorderColor: Colors.grey,
                  customDayBuilder: (
                    bool isSelectable,
                    int index,
                    bool isSelectedDay,
                    bool isToday,
                    bool isPrevMonthDay,
                    TextStyle textStyle,
                    bool isNextMonthDay,
                    bool isThisMonthDay,
                    DateTime day,
                  ) {
                    return Container(
                      decoration: BoxDecoration(
                        color: selecteddate == day ? redcolor : null,
                      ),
                      child: Center(
                          child: Column(
                        children: [
                          Text(
                            "${day.day}",
                            style: TextStyle(color: blackcolor),
                          ),
                          if (date.contains(day))
                            Icon(
                              Icons.star,
                              color: blackcolor,
                            )
                        ],
                      )),
                    );
                  },
                  weekFormat: false,
                  daysHaveCircularBorder: false,
                ),
              ),
              date.contains(selecteddate)
                  ? taskinfo == null
                      ? SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color.fromRGBO(158, 158, 158, 1)
                                    .withOpacity(0.35)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${taskinfo.first['time']}",
                                    style: TextStyle(
                                      color: blackcolor,
                                      fontSize: 30,
                                    )),
                                Text(
                                  "${taskinfo.first['work']}",
                                  style: TextStyle(
                                      color: blackcolor,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        )
                  : SizedBox.shrink(),
            ],
          ),
        ));
  }

  // calender() {
  //   return
  // }

  addmonthlytask(context) {
    DateTime selectedDate = DateTime.now();
    TextEditingController task = TextEditingController();
    var selectedtime;
    return StatefulBuilder(
      builder: (BuildContext context, setState) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.close),
                ),
              ),
              const Text(
                "मासिक कार्य जोडा",
                textScaleFactor: 2.5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2015, 8),
                        lastDate: DateTime(2101));
                    if (picked != null && picked != selectedDate) {
                      setState(() {
                        selectedDate = picked;
                      });
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 40,
                          color: whitecolor,
                          child: Center(
                            child: Text(
                              '${selectedDate.day}-${selectedDate.month}-${selectedDate.year}',
                              style: TextStyle(color: blackcolor, fontSize: 30),
                            ),
                          )),
                      Icon(
                        Icons.calendar_month_rounded,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      initialTime: TimeOfDay.now(),
                      context: context, //context of current state
                    );

                    if (pickedTime != null) {
                      setState(() {
                        selectedtime = pickedTime.format(context).toString();
                      });
                    } else {
                      if (kDebugMode) {
                        print("Time is not selected");
                      }
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 40,
                          color: whitecolor,
                          child: Center(
                            child: Text(
                              '${selectedtime ?? TimeOfDay.now().format(context)}',
                              style: TextStyle(color: blackcolor, fontSize: 30),
                            ),
                          )),
                      const Icon(
                        Icons.av_timer,
                        size: 30,
                      )
                    ],
                  ),
                ),
              ),
              CustomTextField(
                controller: task,
                labelText: "कार्य",
              ),
              MaterialButton(
                color: greencolor,
                onPressed: () {
                  if (task.text.isEmpty) {
                    Fluttertoast.showToast(msg: "मासिक कार्य भरा");
                  } else {
                    addtask(
                        time:
                            '${selectedtime ?? TimeOfDay.now().format(context).toString()}',
                        date:
                            '${selectedDate.year}/${selectedDate.month}/${selectedDate.day}',
                        task: task.text);
                  }
                },
                child: Text(
                  "माहिती अद्यावत करा",
                  style: TextStyle(color: whitecolor, fontSize: 20),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void addtask({var time, var date, var task}) async {
    var token = await Authcontroller().getToken();
    var onlytime = time.split(
      " ",
    )[0];
    print('${onlytime.runtimeType}' +
        '${date.runtimeType}' +
        "${task.runtimeType}");
    try {
      var response = await http.post(Uri.parse(TGuruJiUrl.addtask), headers: {
        'token': "$token",
      }, body: {
        'date': "$date",
        'work': "$task",
        'time': "$time",
      });
      debugPrint("=======res ${response.statusCode}");
      var res = jsonDecode(response.body);
      print(response.body);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: res['response']["response_message"]);
        Get.back();
        getmonthlytask();
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
