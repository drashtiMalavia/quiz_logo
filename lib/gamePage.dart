import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:just_audio/just_audio.dart';

import 'data.dart';
import 'dataModel.dart';
import 'logoPage.dart';
import 'main.dart';

class gamePage extends StatefulWidget {
  int levelindex, logoindex;
  gamePage(this.levelindex, this.logoindex, {super.key});

  @override
  State<gamePage> createState() => _gamePageState();
}

class _gamePageState extends State<gamePage> with WidgetsBindingObserver {
  FlutterTts flutterTts = FlutterTts();
  AudioPlayer audioPlayer = AudioPlayer();
  String name = "";
  bool red=false;
  PageController controller = PageController();
  var isMusicPlaying = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initMusic();
    controller = PageController(initialPage: widget.logoindex);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    audioPlayer.stop();
    print("MMM_Desposed");
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    if(state==AppLifecycleState.paused){
      print("MMM_Paused");
      audioPlayer.stop();
    }
    if(state==AppLifecycleState.resumed){
      print("MMM_Resummed");
      print("MMM_Is Playing=${audioPlayer.playing}");
      if(isMusicPlaying!=false) {
        audioPlayer.play();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if(!didPop){
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return logopage(widget.levelindex);
          },));
        }
      },
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: Image.asset('images/main_background_header.png', alignment: Alignment.topLeft, fit: BoxFit.cover,),
              actions: [
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                      return logopage(widget.levelindex);
                    },));
                  },
                  child: Container(
                      margin: EdgeInsets.only(right: 100),
                      height: 50,
                      width: 50,
                      child: Image.asset('images/n_arrow_back.png')
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 90),
                  child: Text('logo ${widget.logoindex + 1}/15', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 28)),
                ),
                Container(
                  height: 50,
                  width: 50,
                  child: InkWell(
                      onTap: () {
                        isMusicPlaying = !isMusicPlaying;
                        if(isMusicPlaying) {
                          if(audioPlayer.playing!=true) {
                            audioPlayer.play();
                          }
                        } else {
                          audioPlayer.stop();
                        }
                        setState(() {});
                      },
                      child: isMusicPlaying ? Icon(Icons.volume_up, color: Colors.white, size: 32,):Icon(Icons.volume_off, color: Colors.white, size: 32,)
                  ),
                )
              ],
            ),
            body: PageView.builder(
              itemCount: 15,
              controller: controller,
              onPageChanged: (value) {
                widget.logoindex = value;
                setState(() {});
              },
              itemBuilder: (context, pageIndex) {
                DataModel model = data.dataList[pageIndex];
                return Column(
                  children: [
                    Flexible(
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.only(top: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    if (widget.logoindex != 0) {
                                      widget.logoindex = widget.logoindex - 1;
                                      controller.jumpToPage(widget.logoindex);
                                    }
                                  });
                                },
                                child: Container(
                                  child: Image.asset('images/game_arrow_left.png', height: 30, width: 30, fit: BoxFit.cover,),
                                  margin: EdgeInsets.only(left: 20),
                                )
                            ),
                            Preference.getLevelWin(widget.levelindex, widget.logoindex) != "Win"?
                            Image.asset('${data.AllLogoName[widget.logoindex]}', height: 200, width: 200, fit: BoxFit.cover,)
                                :Image.asset('${data.AllLogoNameComp[widget.logoindex]}', height: 200, width: 200, fit: BoxFit.cover,),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (widget.logoindex != 14) {
                                    widget.logoindex = widget.logoindex + 1;
                                    controller.jumpToPage(widget.logoindex);
                                  }
                                });
                              },
                              child: Container(
                                child: Image.asset('images/game_arrow_right.png', height: 30, width: 30, fit: BoxFit.cover,),
                                margin: EdgeInsets.only(right: 20),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Preference.getLevelWin(widget.levelindex, widget.logoindex) != "Win" ?//model.win!=0?
                      Container(
                          height: model.imgname.length == 4 || model.imgname.length == 3? 300 : 400,
                          width: model.imgname.length == 4 || model.imgname.length == 3 ? 300 : 400,
                          child: GridView.builder(
                            primary: false,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: model.imgname.length >= 6 ? 6 : model.imgname.length,
                                crossAxisSpacing: 2,
                                mainAxisSpacing: 2
                            ),
                            itemCount: model.imgname.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  if (model.tempAnsList[index] != ''){
                                    model.optionsAnsList[model.map[index]] = model.tempAnsList[index];
                                    model.tempAnsList[index] = "";
                                    print('templist=${model.tempAnsList}');
                                    name=model.tempAnsList.join();
                                    print("name:$name");
                                    red=false;
                                  }
                                  setState(() {});
                                },
                                child: Container(
                                    height: 100,
                                    width: 100,
                                    alignment: Alignment.center,
                                    child: Stack(
                                      children: [
                                        Image.asset('images/game_button_quiz.png', height: 200, width: 200, fit: BoxFit.cover,),
                                        Center(child: Text('${model.tempAnsList[index]}', style: TextStyle(color: Colors.white, fontSize: 60))),
                                      ],
                                    )
                                ),
                              );
                            },
                          )
                      )
                          : Container(
                        height: model.imgname.length == 4 || model.imgname.length == 3 ? 300 : 400,
                        width: model.imgname.length == 4 || model.imgname.length == 3 ? 300 : 400,
                        alignment: Alignment.topCenter,
                        child: Text(model.imgname, style: TextStyle(fontSize: 40),),
                      ),
                    ),
                    Visibility(
                      visible: red==true?true:false,
                      child: Flexible(
                          flex: 1,
                          child: Container(
                            color: Colors.red,
                            height: 100,
                            width: 200,
                            alignment: Alignment.center,
                            child: Text('!!!Oops Wrong Answer..',style: TextStyle(color: Colors.white,fontSize: 30),textAlign: TextAlign.center,),
                          )
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 30),
                            width: 200,
                            child: Stack(
                              children: [
                                Image.asset('images/n_hints_green.png'),
                                Row(mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('images/n_bulb.png', height: 40, width: 40,),
                                    Text(' Use hints', style: TextStyle(color: Colors.white, fontSize: 30),)
                                  ],
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                for (int i = 0; i < model.tempAnsList.length; i++) {
                                  if (model.tempAnsList[i] != '') {
                                    model.optionsAnsList[model.map[i]] = model.tempAnsList[i];
                                    model.tempAnsList[i] = "";
                                    name = "";
                                    red=false;
                                  }
                                }
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 10),
                              height: 50,
                              width: 50,
                              child: Image.asset('images/n_delete_all_red.png'),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                for (int i = model.imgname.length - 1; i >= 0; i--) {
                                  if (model.tempAnsList[i] != '') {
                                    model.optionsAnsList[model.map[i]] = model.tempAnsList[i];
                                    model.tempAnsList[i] = '';
                                    name = name!.substring(0, (name!.length - 1));
                                    red=false;
                                    break;
                                  }
                                }
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: 10),
                              height: 50,
                              width: 50,
                              child: Image.asset('images/n_delete_one_red.png'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Preference.getLevelWin(widget.levelindex, widget.logoindex) != "Win"?//model.win!=0?
                      Container(
                        margin: EdgeInsets.only(top: 50),
                        height: 400,
                        width: 400,
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 7,
                              mainAxisSpacing: 1,
                              crossAxisSpacing: 1
                          ),
                          itemCount: 14,
                          primary: false,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () async {
                                for (int i = 0; i < model.imgname.length; i++) {
                                  if (model.tempAnsList[i] == '') {
                                    await flutterTts.speak(model.optionsAnsList[index]);
                                    model.tempAnsList[i]=model.optionsAnsList[index];
                                    model.map[i] = index;
                                    model.optionsAnsList[index] = '';
                                    name=model.tempAnsList.join();
                                    print('optionlist=${name}');
                                    print('optionlist=${model.imgname}');
                                    if(name.length==model.imgname.length && name.compareTo(model.imgname) != 0){
                                      red=true;
                                      await flutterTts.speak('Oops Wrong Answer..');
                                    }
                                    if (name.compareTo(model.imgname) == 0) {
                                      model.win = 0;
                                      data.Winlevel[widget.levelindex]=Preference.getlogComplete(widget.levelindex);
                                      data.Winlevel[widget.levelindex]=data.Winlevel[widget.levelindex]+1;
                                      Preference.setlogoComplete(widget.levelindex, data.Winlevel[widget.levelindex]);
                                      Preference.setLevelWin(widget.levelindex, widget.logoindex);
                                      print("setlevelWin seted");
                                    }
                                    print("Map=${model.map}");
                                    break;
                                  }
                                }
                                setState(() {});
                              },
                              child: Container(
                                height: 100,
                                width: 100,
                                child: Stack(
                                  children: [
                                    Image.asset('images/game_button_guessing.png'),
                                    Center(child: Text('${model.optionsAnsList[index]}', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                                    ))
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                          : Container(
                        height: 300,
                        width: 500,
                        margin: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text('Perfect!', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
                            Container(
                                margin: EdgeInsets.all(20),
                                child: Text('Next points +10%', style: TextStyle(color: Colors.white, fontSize: 20),)
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  pageIndex++;
                                  name = "";
                                  if (pageIndex <= 14) {
                                    controller.jumpToPage(pageIndex);
                                  }
                                });
                              },
                              child: Container(
                                  margin: EdgeInsets.only(top: 10, left: 200),
                                  child: Stack(
                                    children: [
                                      Center(child: Image.asset('images/game_button_quiz.png', width: 150, height: 50, fit: BoxFit.cover,)),
                                      Center(child: Text("Next", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white)))
                                    ],
                                  )
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [CupertinoColors.activeGreen, Colors.green]),
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                    ),
                  ],
                );
              },
            )
        ),
      ),
    );
  }

  void initMusic() {
    audioPlayer.setAsset("audio/soda_crush.mp3");
    audioPlayer.load();
    audioPlayer.setLoopMode(LoopMode.one);
  }
}
