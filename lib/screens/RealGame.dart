import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loginpage/models/locationmodel.dart';
import 'package:flutter_loginpage/shared/helperfunction.dart';
import 'package:flutter_loginpage/widgets/BackgroundImage1.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'dart:math';


class RealGame extends StatefulWidget {
  @override
  _RealGameState createState() => _RealGameState();



}

class _RealGameState extends State<RealGame> with WidgetsBindingObserver {





  Map<String, dynamic> userMap;
  get userData => null;
  String myUsername;
  Position _currentPosition=null;
  String RoomName ='';
  int size = 0;
  List nameTab = new List();
  List distanceTab = new List();
  String myLocationlat ='';
  String myLocationlon ='';
  String minName ='';
  double minDistance = 0;
  List otherDistanceTab = new List();
  String kind = '';
  int i = 0;
  String friendAtRisk = '';
  String State = '';
  String color ='Green';
  List statsTab = new List();
  int points = 0;
  int R=48;
  int G=183;
  int B =66;
  int time = 0;
  int day =0;
  int oldpoints =0;





  initState() {
    mybigfunction();
  }


  Future<void> mybigfunction()  async {
    RoomName= await HelperFunctions.getRoomSharedPreference();
    day = int.parse(await HelperFunctions.getdaySharedPreference());
    await HelperFunctions.gethourSharedPreference();
    await HelperFunctions.getmonthSharedPreference();
    time = int.parse(await HelperFunctions.gettimeSharedPreference());
    var currDt = DateTime.now();
    if((time+day)%30==currDt.day){
      FirebaseFirestore.instance.collection(RoomName).doc().delete();
      Navigator.of(context).pushNamed(
          'NewGame',);


    }




    myUsername= await HelperFunctions.getUserNameSharedPreference();
    _getCurrentLocation();
    myLocationlat=_getCurrentLocation().latitude.toString();
    myLocationlon=_getCurrentLocation().longitude.toString();
    await FirebaseFirestore.instance.collection(RoomName).doc(myUsername).update({
      "Locationlat": myLocationlat,
      "Locationlon" : myLocationlon,
    }).catchError((e) {
      print(e.toString());
    });
    await FirebaseFirestore.instance
        .collection(RoomName)
        .get()
        .then((value) {
      setState(() {
        if (value != null) {
          size = value.size;
          for(int index = 0 ; index < size; index++){
            nameTab.add(value.docs[index].data()["userName"]);
            distanceTab.add(Geolocator.distanceBetween(double.parse(value.docs[index].data()["Locationlat"]), double.parse(value.docs[index].data()["Locationlon"]),double.parse(myLocationlon),double.parse(myLocationlon)));

          }
        }
      });
    });
    await FirebaseFirestore.instance
        .collection('users')
        .where("userName", isEqualTo: myUsername)
        .get()
        .then((value) {
      setState(() {
        if (value != null) {
          userMap = value.docs[0].data();
          kind = userMap["kind"];
          if(kind=='out'){showDialog(context: context, builder: (context){

            return AlertDialog(title:Text('Phone Alert'),content: Text("You are out of the game" ),actions: [FlatButton(onPressed: (){Navigator.of(context).pushNamed(
                'GameStats', );}, child: Text('Continue'))],);
          });}


        }
      });
    });

    otherDistanceTab=distanceTab;
    distanceTab.sort();
    minDistance =distanceTab[0];
    minName=nameTab[otherDistanceTab.indexOf(minDistance)];

    if(kind=='Runner' && minDistance<15) {
      for (i = 0; i < size; i++){
        await FirebaseFirestore.instance
            .collection('users')
            .get()
            .then((value) {
          setState(() async {
            if (value != null) {
              userMap = value.docs[i].data();
             if(userMap[kind]=='Runner'){
               await FirebaseFirestore.instance.collection(RoomName).doc(userMap['userName']).update({

                 "risk" :myUsername



               }).catchError((e) {
                 print(e.toString());
               });

             }

            }
          });
        });
      }


    }
    if(kind=='Runner'){
      R=G=B=0;
      await FirebaseFirestore.instance
        .collection('users')
        .where("userName", isEqualTo: myUsername)
        .get()
        .then((value) {
      setState(() {
        if (value != null) {
          userMap = value.docs[0].data();
          friendAtRisk = userMap['risk'];

        }
      });
    });}
    if(friendAtRisk!=''){
      showDialog(context: context, builder: (context){

        return AlertDialog(title:Text('Phone Alert'),content: Text('Your Friend '+friendAtRisk +'is about to get tagged' ),actions: [FlatButton(onPressed: (){Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RealGame()),);}, child: Text('Continue'))],);
      });
    }
    await FirebaseFirestore.instance.collection('users')
        .where("userName", isEqualTo: myUsername)
        .get()
        .then((value) {
      setState(() async {
        if (value != null) {
          oldpoints= int.parse(value.docs[0].data()["points"]);

        }
      });
    });

  }







  @override
  @override
  Widget build(BuildContext context) {


    return Center(
      child: Stack(
          children: [
            BackgroundImage1(),
            Center(
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Color.fromARGB(255, 153, 0, 0),
                  actions: [
                    ElevatedButton(//height: 5,
                      //padding: EdgeInsets.symmetric(
                      //vertical: 10, horizontal: 10),
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 130, 0, 0) // set the background color
                       
                      ),



                      //shape: StadiumBorder(),
                      onPressed: () async {Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RealGame()),);



                      },
                      child: Text('Reload', style: TextStyle(color: Colors
                          .white, fontSize: 17, fontWeight: FontWeight.w700
                        ,),),


                    ),
                  ],

                  title: Text("Game On"),

                ),
                body: Form(

                  child: SingleChildScrollView(
                    child: SafeArea(
                      child: Column(
                          children: [
                            SizedBox(
                              height: 270
                              ,
                            ),
                            Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Color.fromARGB(255, R, G, B)),

                                onPressed: () async {
                                  if(kind=='Tagger' && minDistance<15 &&State!='blocked'){
                                    await FirebaseFirestore.instance.collection(RoomName).doc(myUsername).update({
                                      kind : "Runner",
                                    }).catchError((e) {
                                      print(e.toString());
                                    });
                                    await FirebaseFirestore.instance.collection(RoomName)
                                        .where("identifier", isEqualTo: "GameStats")
                                        .get()
                                        .then((value) {
                                      setState(() async {
                                        if (value != null) {
                                          statsTab = value.docs[0].data()["statsTab"];
                                          statsTab.add(myUsername+" has tagged"+minName );
                                          await FirebaseFirestore.instance.collection(RoomName).doc(myUsername).update({
                                            "statsTab":statsTab,
                                          }).catchError((e) {
                                            print(e.toString());
                                          });

                                        }
                                      });
                                    });
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => RealGame()),);
                                  }
                                  if(kind=='Tagger' && minDistance>15 ){
                                    State='blocked';
                                    R=174;G=0;B=0;
                                    Timer(Duration(seconds: 10), () {
                                      // 5 seconds over, navigate to Page2.
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => RealGame()),);
                                    });



                                  }
                                  await FirebaseFirestore.instance.collection('users')
                                      .where("userName", isEqualTo: myUsername)
                                      .get()
                                      .then((value) {
                                    setState(() async {
                                      if (value != null) {
                                        points=points +10;
                                        await HelperFunctions.savepointsSharedPreference((points-oldpoints).toString());
                                        await FirebaseFirestore.instance.collection('users').doc(myUsername).update({
                                          "points":points,
                                        }).catchError((e) {
                                          print(e.toString());
                                        });

                                      }
                                    });
                                  });





                                },


                                child: Text('Tag', style: TextStyle(color: Colors
                                    .white, fontSize: 25, fontWeight: FontWeight.w700
                                  ,),),


                              ),
                            ),
                            SizedBox(
                              height: 80
                              ,
                            ),


                            
                            SizedBox(
                              height: 300
                              ,)




                          ]
                      ),
                    ),
                  ),
                ),
              ),
            ),]
      ),
    );
  }
  _getCurrentLocation() {
    Geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best, forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
    return _currentPosition;
}
}