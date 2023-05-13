import 'dart:convert';
import 'package:html/parser.dart' show parse;
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:techno_teacher/colors.dart';
import 'package:http/http.dart' as http;
import 'package:techno_teacher/api_utility/cont_urls.dart';
import 'package:techno_teacher/authcontroller.dart';
import 'package:techno_teacher/utils/snackbar/custom_snsckbar.dart';
import 'dart:math' as math;

class Paripathpage extends StatefulWidget {
  const Paripathpage({super.key});

  @override
  State<Paripathpage> createState() => _ParipathpageState();
}

class _ParipathpageState extends State<Paripathpage> {
  bool loadcompletetext = false;
  bool todayissunday = false;

  getdata() async {
    var token = await Authcontroller().getToken();
    print("token$token");
    try {
      var response =
          await http.get(Uri.parse(TGuruJiUrl.routineinfo), headers: {
        'token': "$token",
      });
      debugPrint("=======res ${response.statusCode}");
      var res = jsonDecode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          // paripathdata = res['data'];
          constitustion = res['data']['constitution'];
          rajyagit = res['data']['rajyagit'];
          national = res['data']['national'];
          prayer = res['data']['prayer'];
          dailyprayer = res['data']['daily_prayer'];
          debate = res['data']['debate'];
          group = res['data']['group'];
          story = res['data']['story'];
        });
      } else {
        ShowCustomSnackBar().ErrorSnackBar(res['response']["message"]);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'error');
    }
  }

  @override
  void initState() {
    super.initState();
    DateTime date = DateTime.now();
    String dateFormat = DateFormat('EEEE').format(date);
    print(dateFormat);
    if (dateFormat == 'Sunday') {
      setState(() {
        todayissunday = true;
      });
    }
    getdata();
    player = List.generate(500, (index) => AudioPlayer(), growable: false);
    playpause = List.generate(500, (index) => false, growable: false);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(constitustion);
    print(rajyagit);
    print(national);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: whitecolor,
        appBar: AppBar(
          backgroundColor: blackcolor,
          iconTheme: IconThemeData(
            color: whitecolor,
          ),
          elevation: 0.7,
          centerTitle: true,
          title: Text(
            "परिपाठ",
            style: TextStyle(
                color: whitecolor, fontWeight: FontWeight.w500, fontSize: 20),
          ),
          bottom: TabBar(
            dividerColor: redcolor,
            tabs: [
              Tab(
                text: "कालचा",
              ),
              Tab(
                text: "आजचा",
              ),
              Tab(
                text: "उद्याचा",
              ),
            ],
          ),
        ),
        body: todayissunday
            ? SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Image.asset(
                  'assets/images/chutti.jpg',
                  fit: BoxFit.fill,
                ),
              )
            : TabBarView(
                children: [
                  RefreshIndicator(
                    color: blackcolor,
                    onRefresh: () async {
                      getdata();
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: listofparipathat.length,
                            itemBuilder: (BuildContext context, int i) {
                              if (listofparipathat[i].isEmpty) {
                                return const Center();
                              } else {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemCount: listofparipathat[i].length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var date = listofparipathat[i][index]
                                                ['date'] ==
                                            null
                                        ? DateTime.now()
                                        : DateTime.parse(
                                            "${listofparipathat[i][index]['date']}");
                                    DateTime today = DateTime.now();
                                    var timedifference =
                                        today.difference(date).inDays;

                                    if (timedifference == 1) {
                                      return box(
                                          title:
                                              "${listofparipathat[i][index]['title']}",
                                          description:
                                              "${listofparipathat[i][index]['description']}",
                                          url:
                                              "${TGuruJiUrl.url}/${listofparipathat[i][index]['audio_file']}",
                                          color: Color(
                                                  (math.Random().nextDouble() *
                                                          0xFFFFFF)
                                                      .toInt())
                                              .withOpacity(1.0),
                                          player: player[index],
                                          playpause: playpause[index]);
                                    } else {
                                      return SizedBox.shrink();
                                    }
                                  },
                                );
                              }
                            },
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: listofparipathaextra.length,
                              itemBuilder: (BuildContext context, int i) {
                                if (listofparipathat[i].isEmpty) {
                                  return Center();
                                } else {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    itemCount: listofparipathaextra[i].length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var date = listofparipathat[i][index]
                                                  ['date'] ==
                                              null
                                          ? DateTime.now()
                                          : DateTime.parse(
                                              "${listofparipathaextra[i][index]['date']}");
                                      DateTime today = DateTime.now();
                                      var timedifference =
                                          today.difference(date).inDays;

                                      if (timedifference == 1) {
                                        return extrabox(
                                            title:
                                                "${listofparipathaextra[i][index]['title']}",
                                            description:
                                                "${listofparipathaextra[i][index]['description']}",
                                            color: Color((math.Random()
                                                            .nextDouble() *
                                                        0xFFFFFF)
                                                    .toInt())
                                                .withOpacity(1.0));
                                      } else {
                                        return SizedBox.shrink();
                                      }
                                    },
                                  );
                                }
                              }),
                        ],
                      ),
                    ),
                  ),
                  RefreshIndicator(
                    color: blackcolor,
                    onRefresh: () async {
                      getdata();
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: listofparipathat.length,
                            itemBuilder: (BuildContext context, int i) {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount: listofparipathat[i].length,
                                itemBuilder: (BuildContext context, int index) {
                                  var date = listofparipathat[i][index]
                                              ['date'] ==
                                          null
                                      ? DateTime.now()
                                      : DateTime.parse(
                                          "${listofparipathat[i][index]['date']}");

                                  DateTime today = DateTime.now();
                                  var timedifference =
                                      today.difference(date).inDays;

                                  if ("${date.day}-${date.month}-${date.year}" ==
                                      "${today.day}-${today.month}-${today.year}") {
                                    return box(
                                        title:
                                            "${listofparipathat[i][index]['title']}",
                                        description:
                                            "${listofparipathat[i][index]['description']}",
                                        url:
                                            "${TGuruJiUrl.url}/${listofparipathat[i][index]['audio_file']}",
                                        color: Color(
                                                (math.Random().nextDouble() *
                                                        0xFFFFFF)
                                                    .toInt())
                                            .withOpacity(1.0),
                                        player: player[index],
                                        playpause: playpause[index]);
                                  } else {
                                    return SizedBox.shrink();
                                  }
                                },
                              );
                            },
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: listofparipathaextra.length,
                            itemBuilder: (BuildContext context, int i) {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount: listofparipathaextra[i].length,
                                itemBuilder: (BuildContext context, int index) {
                                  var date = listofparipathat[i][index]
                                              ['date'] ==
                                          null
                                      ? DateTime.now()
                                      : DateTime.parse(
                                          "${listofparipathaextra[i][index]['date']}");
                                  DateTime today = DateTime.now();
                                  var timedifference =
                                      today.difference(date).inDays;

                                  if ("${date.day}-${date.month}-${date.year}" ==
                                      "${today.day}-${today.month}-${today.year}") {
                                    return extrabox(
                                        title:
                                            "${listofparipathaextra[i][index]['title']}",
                                        description:
                                            "${listofparipathaextra[i][index]['description']}",
                                        color: Color(
                                                (math.Random().nextDouble() *
                                                        0xFFFFFF)
                                                    .toInt())
                                            .withOpacity(1.0));
                                  } else {
                                    return SizedBox.shrink();
                                  }
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  RefreshIndicator(
                    color: blackcolor,
                    onRefresh: () async {
                      getdata();
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: listofparipathat.length,
                            itemBuilder: (BuildContext context, int i) {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount: listofparipathat[i].length,
                                itemBuilder: (BuildContext context, int index) {
                                  var date = listofparipathat[i][index]
                                              ['date'] ==
                                          null
                                      ? DateTime.now()
                                      : DateTime.parse(
                                          "${listofparipathat[i][index]['date']}");
                                  DateTime today = DateTime.now();
                                  var timedifference =
                                      today.difference(date).inDays;

                                  if (timedifference == -1) {
                                    return box(
                                        title:
                                            "${listofparipathat[i][index]['title']}",
                                        description:
                                            "${listofparipathat[i][index]['description']}",
                                        url:
                                            "${TGuruJiUrl.url}/${listofparipathat[i][index]['audio_file']}",
                                        color: Color(
                                                (math.Random().nextDouble() *
                                                        0xFFFFFF)
                                                    .toInt())
                                            .withOpacity(1.0),
                                        player: player[index],
                                        playpause: playpause[index]);
                                  } else {
                                    return SizedBox.shrink();
                                  }
                                },
                              );
                            },
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: listofparipathaextra.length,
                            itemBuilder: (BuildContext context, int i) {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount: listofparipathaextra[i].length,
                                itemBuilder: (BuildContext context, int index) {
                                  var date = listofparipathaextra[i][index]
                                              ['date'] ==
                                          null
                                      ? DateTime.now()
                                      : DateTime.parse(
                                          "${listofparipathaextra[i][index]['date']}");
                                  DateTime today = DateTime.now();
                                  var timedifference =
                                      today.difference(date).inDays;

                                  if (timedifference == -1) {
                                    return extrabox(
                                        title:
                                            "${listofparipathaextra[i][index]['title']}",
                                        description:
                                            "${listofparipathaextra[i][index]['description']}",
                                        color: Color(
                                                (math.Random().nextDouble() *
                                                        0xFFFFFF)
                                                    .toInt())
                                            .withOpacity(1.0));
                                  } else {
                                    return SizedBox.shrink();
                                  }
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  box({
    var title,
    var description,
    var url,
    var color,
    var player,
    var playpause,
  }) {
    var document = parse(loadcompletetext == false
        ? description.substring(
            0, description.length <= 80 ? description.length : 80)
        : description);

    return StatefulBuilder(
      builder: (BuildContext context, setState) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: blackcolor),
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                  height: MediaQuery.of(context).size.height / 15,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      style: TextStyle(
                          color: whitecolor,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Column(
                    children: [
                      Text(
                        "${document.body!.text}",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: blackcolor, fontSize: 25),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              loadcompletetext = !loadcompletetext;
                            });
                          },
                          child: loadcompletetext
                              ? CircleAvatar(
                                  backgroundColor: redcolor,
                                  child: Icon(
                                    Icons.arrow_drop_up,
                                    color: whitecolor,
                                  ))
                              : CircleAvatar(
                                  backgroundColor: redcolor,
                                  child: Icon(
                                    Icons.arrow_drop_down,
                                    color: whitecolor,
                                  )),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Color(0xffdfdfdf),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        playpause
                            ? InkWell(
                                onTap: () async {
                                  player.pause();
                                  setState(() {
                                    playpause = false;
                                  });
                                },
                                child: Icon(Icons.pause))
                            : InkWell(
                                onTap: () async {
                                  if (url != "Null") {
                                    await player.setUrl(url ??
                                        "https://deals2you.store/tu_mera_koi_na.mp3");
                                    player.play();
                                    setState(() {
                                      playpause = true;
                                    });
                                  } else if (url == "Null") {
                                    Fluttertoast.showToast(
                                        msg: "Audio Not Found");
                                  }
                                },
                                child: Icon(Icons.play_arrow)),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: StreamBuilder(
                            stream: player.positionStream,
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              return ProgressBar(
                                total: player.duration ?? Duration.zero,
                                progress: player.position,
                                buffered: player.bufferedPosition,
                                onSeek: (value) {
                                  player.seek(value);
                                },
                                onDragEnd: () {},
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  extrabox({
    var title,
    var description,
    var color,
  }) {
    var document = parse(
        loadcompletetext == false ? description.substring(0, 80) : description);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: blackcolor),
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              height: MediaQuery.of(context).size.height / 15,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: TextStyle(
                      color: whitecolor,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                children: [
                  Text(
                    "${document.body!.text}",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: blackcolor, fontSize: 25),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          loadcompletetext = !loadcompletetext;
                        });
                      },
                      child: loadcompletetext
                          ? CircleAvatar(
                              backgroundColor: redcolor,
                              child: Icon(
                                Icons.arrow_drop_up,
                                color: whitecolor,
                              ))
                          : CircleAvatar(
                              backgroundColor: redcolor,
                              child: Icon(
                                Icons.arrow_drop_down,
                                color: whitecolor,
                              )),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  var listofparipathat = [
    national,
    rajyagit,
    constitustion,
    prayer,
    dailyprayer
  ];

  var listofparipathaextra = [debate, group, story];

  var listcolor = [
    Colors.purple,
    Colors.blue,
    Colors.green,
    Colors.pink,
    Colors.yellow,
    Colors.red,
    Colors.purple,
    Colors.blue,
    Colors.green,
    Colors.pink,
    Colors.yellow,
    Colors.red,
    Colors.purple,
    Colors.blue,
    Colors.green,
    Colors.pink,
    Colors.yellow,
    Colors.red,
    Colors.purple,
    Colors.blue,
    Colors.green,
    Colors.pink,
    Colors.yellow,
    Colors.red,
  ];
}
