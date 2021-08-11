import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_loginpage/models/user.dart';
import 'package:flutter_loginpage/screens/Checkyouremail.dart';
import 'package:flutter_loginpage/widgets/BackgroundImage1.dart';
import 'package:flutter_loginpage/widgets/background-image.dart';
import 'package:provider/provider.dart';

import 'authenticate.dart';
import 'login-page.dart';

class Olduser extends StatelessWidget {
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
                body: Form(

                  child: SingleChildScrollView(
                    child: SafeArea(
                      child: Column(
                          children: [
                            SizedBox(
                              height: 200
                              ,
                            ),
                            FlatButton(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 60),
                              shape: StadiumBorder(),
                              onPressed: () async {Navigator.of(context).pushNamed(
                                  'Loading3', arguments: '');




                              },
                              child: Text('Continue Game', style: TextStyle(color: Colors
                                  .white, fontSize: 25, fontWeight: FontWeight.w700
                                ,),),
                              color: Colors.red[800],

                            ),

                            Center(
                              child :SizedBox(
                                height: 1
                                ,
                              ),
                            ),
                            SizedBox(
                              height: 14
                              ,
                            ),
                            FlatButton(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 80),
                              shape: StadiumBorder(),
                              onPressed: () async {Navigator.of(context).pushNamed(
                                  'gamestats', arguments: '');



                              },
                              child: Text('Game Stats ', style: TextStyle(color: Colors
                                  .white, fontSize: 25, fontWeight: FontWeight.w700
                                ,),),
                              color: Colors.red[800],

                            ),
                            SizedBox(
                              height: 15
                              ,
                            ),
                            FlatButton(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 83),
                              shape: StadiumBorder(),
                              onPressed: () async {exit(0);



                              },
                              child: Text('Quite Game', style: TextStyle(color: Colors
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


                              onPressed: () async {Navigator.of(context).pushNamed(
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