import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'levelPage.dart';

class mainPage extends StatefulWidget {
  const mainPage({super.key});

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if(!didPop){
          Navigator.pop(exit(0));
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(left: 20,top: 20),
                child: Text('LOGO GAME',style: TextStyle(fontSize:40),),
                alignment: Alignment.topLeft,
              ),
              Container(
                margin: EdgeInsets.only(top: 60,left: 20),
                child: Text('Quiz your brands knowledge',style: TextStyle(fontSize:25),),
                alignment: Alignment.topLeft,
              ),
              Container(
                child: Image.asset('images/main_background_top_logos.png',alignment: Alignment.topRight,),
              ),
              Positioned(
                top: 180,
                left: 100,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      Navigator.push(context,MaterialPageRoute(builder: (context) {
                        return levelPage();
                      },));
                    });
                  },
                  child: Container(
                    //margin: EdgeInsets.only(top: 180,left: 100),
                    height: 215,
                    width: 215,
                    child: Stack(
                      children: [
                        Image.asset('images/main_button_play.png'),
                        Container(
                            margin: EdgeInsets.only(top: 80,left: 70),
                            child: Text('PLAY',style: TextStyle(color: Colors.white,fontSize: 32,fontWeight: FontWeight.bold),)
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 100,
                margin: EdgeInsets.only(top: 160,left: 220),
                width: 100,
                child: Stack(
                  children: [
                    Image.asset('images/level_button_red_circle.png'),
                    Container(
                        margin: EdgeInsets.only(top: 20,left: 10),
                        child: Text('LEVELS \n  2/86',style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),)
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 550,left: 80),
                height: 70,
                width: 70,
                child: Image.asset('images/main_button_ranking.png'),
              ),
              Container(
                margin: EdgeInsets.only(top: 550,left: 180),
                height: 70,
                width: 70,
                child: Image.asset('images/main_button_stats.png'),
              ),
              Container(
                margin: EdgeInsets.only(top: 550,left: 280),
                height: 70,
                width: 70,
                child: Image.asset('images/main_button_achievements.png'),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: Image.asset('images/main_background_bottom_logos.png',),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
