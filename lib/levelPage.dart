import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'data.dart';
import 'logoPage.dart';
import 'main.dart';
import 'mainPage.dart';

class levelPage extends StatefulWidget {
  const levelPage({super.key});

  @override
  State<levelPage> createState() => _levelPageState();
}

class _levelPageState extends State<levelPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(int i=0;i<5;i++){
      _initImages(i);
    }
    for(int i=0;i<5;i++){
      _initImagescomplete(i);
    }
    for(int i=0;i<5;i++){
      convert(i);
    }
  }
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if(!didPop){
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return mainPage();
          },));
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            flexibleSpace: Image.asset('images/main_background_header.png',alignment: Alignment.topLeft,fit: BoxFit.cover,),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    margin: EdgeInsets.only(right: 100),
                    height: 50,
                    width: 50,
                    child: Image.asset('images/n_arrow_back.png')
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 70),
                child: Text('choose level',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 28),),
              ),
              Container(
                height: 50,
                width: 50,
                child: Image.asset('images/n_bulb.png'),
              )
            ],
          ),
          body: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async {
                  setState(()  {
                    Future.delayed(Duration.zero,() {
                      data.dataList.clear();
                      _initImages(index);
                      _initImagescomplete(index);
                    },);
                  });

                  Navigator.push(context,MaterialPageRoute(builder: (context) {
                    return logopage(index);
                  },));
                },
                child: Container(
                  height: 100,
                  width: 300,
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        child: Stack(
                          children: [
                            Image.asset('images/level_button_red_circle.png'),
                            Container(
                              margin: EdgeInsets.only(left: 20,top: 30),
                              child: Text('${Preference.getlogComplete(index)}/15',style: TextStyle(color: Colors.white,fontSize: 32,fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Column(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                margin: EdgeInsets.only(right: 200),
                                child: Text('Level ${index+1}',style: TextStyle(fontSize: 32),)
                            ),
                            Container(
                              height: 20,
                              width: 300,
                              // color: Colors.green,
                              child: LinearProgressIndicator(value: convert(index),color: Colors.green,),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },),
        ),
      ),
    );
  }
  Future _initImages(int levelNo) async {
    // >> To get paths you need these 2 lines
    final manifestContent = await rootBundle.loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines
    data.AllLogoName.clear();
    data.AllLogoName = manifestMap.keys
        .where((String key) => key.contains('incomplete_logo/level_${levelNo+1}'))
        .where((String key) => key.contains('.png'))
        .toList();
    // allData.imageList=imagePaths;
    //print(data.AllLogoName);
  }
  Future _initImagescomplete(int levelNo) async {
    // >> To get paths you need these 2 lines
    final manifestContent = await rootBundle.loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines
    data.AllLogoNameComp.clear();
    data.AllLogoNameComp = manifestMap.keys
        .where((String key) => key.contains('complete_logo/level_${levelNo+1}'))
        .where((String key) => key.contains('.png'))
        .toList();
    // allData.imageList=imagePaths;
    //print(data.AllLogoNameComp);
  }

  double convert(int TotalWin) {
    double con;
    con=(Preference.getlogComplete(TotalWin))/15;
    return con;
  }
}
