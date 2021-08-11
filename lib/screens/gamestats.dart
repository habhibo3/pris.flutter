import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loginpage/shared/helperfunction.dart';


class gamestats extends StatefulWidget {
  @override
  _gamestatsState createState() => _gamestatsState();

}

class _gamestatsState extends State<gamestats> with WidgetsBindingObserver {
  Map<String, dynamic> userMap;
  bool isLoading = false;
  String error ='';
  final TextEditingController _search = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var myfriends = new List();
  String RoomName='';
  var statsTab = new List();
  var realstatsTab = new List();







  @override


  initState() {
    listMaking();
  }


  Future<void>listMaking() async {



    setState(() {
      isLoading = false;
    });
    String myUsername = await HelperFunctions.getUserNameSharedPreference();
    RoomName= await HelperFunctions.getRoomSharedPreference();
    await _firestore
        .collection(RoomName)
        .get()
        .then((value) {
      setState(() {
        if (value != null) {
          userMap = value.docs[0].data();
          statsTab = userMap["statsTab"];


        }
      });
    });
    for(int i=0;i<statsTab.length;i++){

      realstatsTab[i]=statsTab[statsTab.length-1-i];

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
        actions: [
          IconButton(icon: Icon(Icons.arrow_back), onPressed: () {})
        ],

        title: Text("Friends List"),

      ),
      body:ListView.builder(
          itemCount:realstatsTab.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
              child: Card(
                child: ListTile(
                  tileColor: CupertinoColors.black,
                  onTap: () async {

                  },
                  title: Text(realstatsTab[index],style: TextStyle(color:Colors.white,),textAlign: TextAlign.center,),



                ),

              ),
            );
          }
      ),
    );
  }
}
