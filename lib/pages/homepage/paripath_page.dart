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
import 'package:techno_teacher/pages/homepage/sizedbox.dart';
import 'package:techno_teacher/utils/snackbar/custom_snsckbar.dart';
import 'dart:math' as math;

class Paripathpage extends StatefulWidget {
  const Paripathpage({super.key});

  @override
  State<Paripathpage> createState() => _ParipathpageState();
}

class _ParipathpageState extends State<Paripathpage> {
  List<bool> loadcompletetext = [];
  bool todayissunday = false;
  DateTime today =
      DateTime.parse(DateFormat("yyyyMMdd").format(DateTime.now()));

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
        print(res['data']['debate']);
        setState(() {
          constitustion = res['data']['constitution'];
          rajyagit = res['data']['rajyagit'];
          national = res['data']['national'];
          prayer = res['data']['prayer'];
          dailyprayer = res['data']['daily_prayer'] ?? [];
          debate = res['data']['debate'];
          group = res['data']['group'];
          story = res['data']['story'];
        });
      } else {
        ShowCustomSnackBar().ErrorSnackBar(res['response']["message"]);
      }
    } catch (e) {
      print(e);
    }
  }

  var listofparipathat = [
    national,
    rajyagit,
    constitustion,
    prayer,
    dailyprayer
  ];

  var listofparipathaextra = [debate, group, story];

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
    loadcompletetext = List.generate(500, (index) => false);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                children: List.generate(3, (s) {
                return RefreshIndicator(
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
                                itemBuilder: (BuildContext context, int index) {
                                  var date = listofparipathat[i][index]
                                              ['date'] ==
                                          null
                                      ? DateTime.now()
                                      : DateTime.parse(
                                          "${listofparipathat[i][index]['date']}");

                                  var timedifference =
                                      today.difference(date).inDays;

                                  if (timedifference ==
                                      (s == 0
                                          ? 1
                                          : s == 1
                                              ? 0
                                              : -1)) {
                                    return box(
                                        ontap: () {
                                          setState(() {
                                            loadcompletetext[index] =
                                                !loadcompletetext[index];
                                          });
                                        },
                                        index: index,
                                        title:
                                            "${listofparipathat[i][index]['title']}",
                                        description:
                                            "${listofparipathat[i][index]['description']}",
                                        url:
                                            "${TGuruJiUrl.url}${listofparipathat[i][index]['audio_file']}",
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
                              if (listofparipathaextra[i].isEmpty) {
                                return Center();
                              } else {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemCount: listofparipathaextra[i].length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var date = listofparipathaextra[i][index]
                                                ['date'] ==
                                            null
                                        ? DateTime.now()
                                        : DateTime.parse(
                                            "${listofparipathaextra[i][index]['date']}");

                                    var timedifference =
                                        today.difference(date).inDays;
                                    if (timedifference ==
                                        (s == 0
                                            ? 1
                                            : s == 1
                                                ? 0
                                                : -1)) {
                                      return extrabox(
                                          ontap: () {
                                            setState(() {
                                              loadcompletetext[index] =
                                                  !loadcompletetext[index];
                                            });
                                          },
                                          i: i,
                                          index: index,
                                          player: player[index],
                                          playpause: playpause[index],
                                          url:
                                              "${TGuruJiUrl.url}${listofparipathaextra[i][index]['audio_file']}",
                                          title:
                                              "${listofparipathaextra[i][index]['title']}",
                                          ques:
                                              "${listofparipathaextra[i][index]['ques']}",
                                          ans:
                                              "${listofparipathaextra[i][index]['ans']}",
                                          clas:
                                              "${listofparipathaextra[i][index]['class']}",
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
                              }
                            }),
                      ],
                    ),
                  ),
                );
              })),
      ),
    );
  }

  box({
    var title,
    var description,
    var url,
    var color,
    AudioPlayer? player,
    var playpause,
    var ontap,
    var index,
  }) {
    var document = parse(loadcompletetext[index] == false
        ? description.substring(
            0, description.length <= 80 ? description.length : 80)
        : description);
    print(player!.position);
    print(playpause);
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
                          onTap: ontap,
                          child: CircleAvatar(
                              backgroundColor: redcolor,
                              child: Icon(
                                loadcompletetext[index]
                                    ? Icons.arrow_drop_up
                                    : Icons.arrow_drop_down,
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
                                  print(player.playerState);
                                  if ("${player.position}" !=
                                      "0:00:00.000000") {
                                    await player.setUrl(
                                        url ??
                                            "https://deals2you.store/tu_mera_koi_na.mp3",
                                        initialPosition: player.position);
                                    player.play();
                                    setState(() {
                                      playpause = true;
                                    });
                                  } else {
                                    await player.setUrl(url ??
                                        "https://deals2you.store/tu_mera_koi_na.mp3");
                                    player.play();
                                    setState(() {
                                      playpause = true;
                                    });
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
                                  setState(() {
                                    player.seek(value);
                                  });
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
    var index,
    var ontap,
    var player,
    var playpause,
    var i,
    var clas,
    var ques,
    var ans,
    var url,
  }) {
    var document = i == 0
        ? null
        : parse(loadcompletetext[index] == false
            ? description.substring(
                0, description.length <= 80 ? description.length : 80)
            : description);

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
                  i == 0
                      ? Column(
                          children: [
                            Text(
                              "$clas",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: blackcolor,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Q.     ",
                                  style: TextStyle(
                                      color: blackcolor, fontSize: 20),
                                ),
                                Expanded(
                                  child: Text(
                                    "$ques",
                                    style: TextStyle(
                                        color: blackcolor, fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                            h(5),
                            Row(
                              children: [
                                Text(
                                  "Ans. ",
                                  style: TextStyle(
                                      color: blackcolor, fontSize: 20),
                                ),
                                Expanded(
                                  child: Text(
                                    " $ans",
                                    style: TextStyle(
                                        color: blackcolor, fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Text(
                          "${document!.body!.text}",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: blackcolor, fontSize: 25),
                        ),
                  i == 0
                      ? SizedBox.shrink()
                      : Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                            onTap: ontap,
                            child: CircleAvatar(
                                backgroundColor: redcolor,
                                child: Icon(
                                  loadcompletetext[index]
                                      ? Icons.arrow_drop_up
                                      : Icons.arrow_drop_down,
                                  color: whitecolor,
                                )),
                          ),
                        )
                ],
              ),
            ),
            i == 2
                ? Padding(
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
                                    if ("${player.position}" !=
                                        "0:00:00.000000") {
                                      await player.setUrl(
                                          url ??
                                              "https://deals2you.store/tu_mera_koi_na.mp3",
                                          initialPosition: player.position);
                                      player.play();
                                      setState(() {
                                        playpause = true;
                                      });
                                    } else {
                                      await player.setUrl(url ??
                                          "https://deals2you.store/tu_mera_koi_na.mp3");
                                      player.play();
                                      setState(() {
                                        playpause = true;
                                      });
                                    }
                                  },
                                  child: Icon(Icons.play_arrow)),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: StreamBuilder(
                              stream: player.positionStream,
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                return ProgressBar(
                                  total: player.duration ?? Duration.zero,
                                  progress: player.position,
                                  buffered: player.bufferedPosition,
                                  onSeek: (value) {
                                    setState(() {
                                      player.seek(value);
                                    });
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
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

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
