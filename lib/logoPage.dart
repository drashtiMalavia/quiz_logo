import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'data.dart';
import 'dataModel.dart';
import 'gamePage.dart';
import 'levelPage.dart';
import 'main.dart';

class logopage extends StatefulWidget {
  int index;
  logopage(this.index,{super.key});

  @override
  State<logopage> createState() => _logopageState();
}

class _logopageState extends State<logopage> {
  late String imageName;
  List<String> imgCharList=[];
  late List<String> tempansList=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(data.AllLogoName);
    GetImageName();
  }
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if(!didPop){
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return levelPage();
          },));
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Image.asset('images/main_background_header.png',alignment: Alignment.topLeft,fit: BoxFit.cover,),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    return levelPage();
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
                margin: EdgeInsets.only(right: 130),
                child: Text('level ${widget.index+1}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 28),),
              ),
              Container(
                height: 50,
                width: 50,
                child: Image.asset('images/n_bulb.png'),
              )
            ],
          ),
          body: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5
            ),
            itemCount: 15,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) {
                    return gamePage(widget.index,index);
                  },));
                },
                child: Preference.getLevelWin(widget.index, index)!="Win"?
                Container(
                  child: Image.asset('${data.AllLogoName[index]}'),
                ):
                Container(
                  child: Stack(
                    children: [
                      Image.asset('${data.AllLogoNameComp[index]}'),
                      Image.asset('images/tick.png',height: 50,width: 50,fit: BoxFit.cover,),
                    ],
                  ),
                ),
              );
            },),
        ),
      ),
    );
  }
  void GetImageName(){
    int win=1;
    for(int i=0;i<data.AllLogoName.length;i++){
      List<String> optionsAnsList=[];
      print(data.AllLogoName);
      imageName=data.AllLogoName[i].split("/")[2];
      print("imageName[$i]=$imageName");
      imageName=imageName.split(".")[0];
      print("imageName[$i]=$imageName");
      imgCharList=imageName.split("");
      print("imagecharList[$i]=$imgCharList");

      List abcdList="abcdefghijklmopqrstuvwxyz".split("");
      print("imagecharList[$i]=$abcdList");
      abcdList.shuffle();
      print("imagecharList[$i]=$abcdList");
      optionsAnsList.clear();
      for(int i=0;i<14-imgCharList.length;i++){
        optionsAnsList.add(abcdList[i]);
      }
      print("optionList[$i]=$optionsAnsList");
      tempansList=List.filled(imageName.length, "");
      print("tempansList[$i]=$tempansList");
      optionsAnsList.addAll(imgCharList);
      print("optionsAnsList[$i]=$optionsAnsList");
      optionsAnsList.shuffle();
      print("optionsAnsList[$i]=$optionsAnsList");
      DataModel DM=DataModel(imgCharList, tempansList, optionsAnsList, imageName,win);
      data.dataList.add(DM);
      print("optionAnsList[$i]=${data.dataList[0].imgname}");
    }
  }
}
