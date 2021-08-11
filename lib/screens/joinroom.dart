import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loginpage/models/locationmodel.dart';
import 'package:flutter_loginpage/shared/helperfunction.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';


class joinroom extends StatefulWidget {
  @override
  _joinroomState createState() => _joinroomState();

}

class _joinroomState extends State<joinroom> with WidgetsBindingObserver {
  Map<String, dynamic> userMap;
  bool isLoading = false;
  String error ='';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var myfriends = new List();
  String myUsername='';
  String RoomName ='';
  int i = 0;
  var peopleintherome = new List();
   int size =0;
  var ListofRooms = new List();
  Position _currentPosition=null;
  String kind ='Tagger';
  String testkind ='';









  @override


  initState() {
    listMaking();
  }


  Future<void>listMaking() async {
    myUsername = await HelperFunctions.getUserNameSharedPreference();
    await _firestore
        .collection('users')
        .where(
        "userName", isEqualTo: myUsername)
        .get()
        .then((value) async {

      if (value != null) {
        userMap = value.docs[0].data();
        RoomName= userMap["game_requests"];
        ListofRooms.add(RoomName);
        await HelperFunctions.saveRoomSharedPreference(RoomName);

      }
      //}
      // );
    },);



    setState(() {
      isLoading = false;
    });


    await _firestore
        .collection(RoomName)
        .get()
        .then((value) {
      setState(() {
        if (value != null) {
          size = value.size;
          for(int index = 0 ; index < size; index++){
            peopleintherome.add(value.docs[index].data()["userName"]);

          }
        }
      });
    });
    if(ListofRooms.length==0){
      ListofRooms.add('');
    }



  }


  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: Color.fromARGB(255, 30, 30, 30),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 153, 0, 0),
        actions: [
          ElevatedButton(//height: 5,
            //padding: EdgeInsets.symmetric(
            //vertical: 10, horizontal: 10),


            //shape: StadiumBorder(),
            onPressed: () async {Navigator.of(context).pushNamed(
                'Loading3', arguments: '');



            },
            child: Text('Start Game', style: TextStyle(color: Colors
                .white, fontSize: 17, fontWeight: FontWeight.w700
              ,),),
            style: ElevatedButton.styleFrom(
              primary: Colors.black12,),

          ),

        ],

        title: Text("join room"),

      ),
      body:ListView.builder(
          itemCount:ListofRooms.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
              child: Card(
                child: ListTile(
                  tileColor: CupertinoColors.black,
                  onTap: () async {
                    await _firestore
                        .collection(RoomName)
                        .get()
                        .then((value) {
                      setState(() {
                        if (value != null) {
                          size = value.size;

                          testkind = value.docs[size].data()["kind"];


                        }
                      });
                    });
                    if(kind==testkind){kind='Runner';}
                    await FirebaseFirestore.instance.collection(RoomName).doc(myUsername).set({
                      "userName": userMap["userName"],
                      "Locationlat": _getCurrentLocation().latitude.toString(),
                      "Locationlon" : _getCurrentLocation().longitude.toString(),
                      "kind" : kind,
                      "risk" :''

                    }).catchError((e) {
                      print(e.toString());
                    });
                    Navigator.of(context).pushNamed(
                        'Loading3', arguments: '');



                  },
                  title: Text(myfriends[index]+"                                          invite    ",style: TextStyle(color:Colors.white),textAlign: TextAlign.center,),



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


