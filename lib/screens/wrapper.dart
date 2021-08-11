
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loginpage/models/user.dart';
import 'package:flutter_loginpage/screens/Checkyouremail.dart';
import 'package:flutter_loginpage/shared/helperfunction.dart';
import 'package:provider/provider.dart';

import 'Newuser.dart';
import 'Olduser.dart';
import 'authenticate.dart';
import 'login-page.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}
class _WrapperState extends State<Wrapper> {

  Map<String, dynamic> userMap;
  get userData => null;
  String myUsername;

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
  String statut = '';
  bool testuser;
  bool testgame;





  initState() {
    myfunction();
  }


  Future<void> myfunction()  async {
    testuser=await HelperFunctions.getUserLoggedInSharedPreference();
    testgame=await HelperFunctions.getgameSharedPreference();
    RoomName= await HelperFunctions.getRoomSharedPreference();
    day = int.parse(await HelperFunctions.getdaySharedPreference());
    await HelperFunctions.gethourSharedPreference();
    await HelperFunctions.getmonthSharedPreference();
    time = int.parse(await HelperFunctions.gettimeSharedPreference());
    var currDt = DateTime.now();
    if((time+day)%30==currDt.day){
      FirebaseFirestore.instance.collection(RoomName).doc().delete();
      Navigator.of(context).pushNamed(
        'spetial',);


    }await FirebaseFirestore.instance
        .collection('users')
        .where("userName", isEqualTo: myUsername)
        .get()
        .then((value) {
      setState(() async {
        if (value != null) {
          userMap = value.docs[0].data();
          statut = userMap["statut"];
          print(statut);



        }
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    String myUsername='';
    // return either the Home or Authenticate widget



    if (testuser==true && testgame==false){
      return Newuser();
    }
    if (testuser==true && testgame==true){
      return Olduser();
    }
    else{
      return LoginPage();
    }




  }
}
