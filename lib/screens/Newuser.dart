import 'package:flutter/material.dart';
import 'package:flutter_loginpage/models/user.dart';
import 'package:flutter_loginpage/screens/Checkyouremail.dart';
import 'package:flutter_loginpage/widgets/BackgroundImage1.dart';
import 'package:flutter_loginpage/widgets/background-image.dart';
import 'package:provider/provider.dart';

import 'authenticate.dart';
import 'login-page.dart';

class Newuser extends StatelessWidget {  @override
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
          children: [
          BackgroundImage1(),
      Center(
        child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Form(

        child: SingleChildScrollView(
        child: SafeArea(
        child: Column(
        children: [
        SizedBox(
        height: 230
        ,
        ),
          FlatButton(
            padding: EdgeInsets.symmetric(
                vertical: 10, horizontal: 100),
            shape: StadiumBorder(),
            onPressed: () async {Navigator.of(context).pushNamed(
                'NewGame', arguments: '');




            },
            child: Text('New Game', style: TextStyle(color: Colors
                .white, fontSize: 25, fontWeight: FontWeight.w700
              ,),),
            color: Colors.red[800],

          ),
          SizedBox(
            height: 15
            ,
          ),

          Center(
            child: FlatButton(
              padding: EdgeInsets.symmetric(
                  vertical: 10, horizontal: 115),
              shape: StadiumBorder(),
              onPressed: () async {
                Navigator.of(context).pushNamed(
                    'Settings', arguments: '');



              },
              child: Text('Settings', style: TextStyle(color: Colors
                  .white, fontSize: 25, fontWeight: FontWeight.w700
                ,),),
              color: Colors.red[800],

            ),
          ),
          SizedBox(
            height: 15
            ,
          ),
          FlatButton(
            padding: EdgeInsets.symmetric(
                vertical: 10, horizontal: 80),
            shape: StadiumBorder(),
            onPressed: () async {Navigator.of(context).pushNamed(
                'NearbyFriends', arguments: '');

            },
            child: Text('Nearby Friends', style: TextStyle(color: Colors
                .white, fontSize: 25, fontWeight: FontWeight.w700
              ,),),
            color: Colors.red[800],

          ),
          SizedBox(
            height: 70
            ,
          ),
          FlatButton(
            padding: EdgeInsets.symmetric(
                vertical: 10, horizontal: 55),
            shape: StadiumBorder(side: BorderSide(color: Colors.red[800])),


            onPressed: () async {
              Navigator.of(context).pushNamed(
                  'shareWithfriends', arguments: '');



            },
            child: Text('Share with Friends', style: TextStyle(color: Colors
                .white, fontSize: 25, fontWeight: FontWeight.w700
              ,),),
            //color: Colors.red[800],

          ),
          SizedBox(
              height: 50),


]
  ),
        ),
        ),
        ),
        ),
      ),]
      ),
    );
}}