import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loginpage/shared/helperfunction.dart';
import 'package:geolocator/geolocator.dart';


class NearbyFriends extends StatefulWidget {
  @override
  _NearbyFriendsState createState() => _NearbyFriendsState();

}

class _NearbyFriendsState extends State<NearbyFriends> with WidgetsBindingObserver {
  Map<String, dynamic> userMap;
  bool isLoading = false;
  String error ='';
  final TextEditingController _search = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var myfriends = new List();
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
  List RealRealtab = new List();






  @override


  initState() {
    listMaking();
  }


  Future<void>listMaking() async {



    setState(() {
      isLoading = false;
    });
    String myUsername = await HelperFunctions.getUserNameSharedPreference();
    myLocationlat=_getCurrentLocation().latitude.toString();
    myLocationlon=_getCurrentLocation().longitude.toString();
    await FirebaseFirestore.instance.collection('users').doc(myUsername).update({
      "Locationlat": myLocationlat,
      "Locationlon" : myLocationlon,
    }).catchError((e) {
      print(e.toString());
    });

    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value) {
      setState(() {
        if (value != null) {
          size = value.size;
          for(int index = 0 ; index < size; index++){
            nameTab.add(value.docs[index].data()["userName"]);
            distanceTab.add(Geolocator.distanceBetween(double.parse(value.docs[index].data()["Locationlat"]), double.parse(value.docs[index].data()["Locationlon"]),double.parse(myLocationlon),double.parse(myLocationlon)));


        }
      }});
    });
    for(int index = 0 ; index < size; index++){
      if(distanceTab[index]<100){

      RealRealtab.add(nameTab[index]);
      }


    }




  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;


    return Scaffold(
      backgroundColor: Color.fromARGB(255, 30, 30, 30),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 153, 0, 0),

        title: Text("Nearby Friends"),

      ),
      body:ListView.builder(
          itemCount:RealRealtab.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
              child: Card(
                child: ListTile(
                  tileColor: CupertinoColors.black,
                  onTap: () async {

                  },
                  title: Text("            "+RealRealtab[index],style: TextStyle(color:Colors.white),),



                ),

              ),
            );
          }
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



