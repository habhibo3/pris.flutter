import 'package:flutter_loginpage/screens/login-page.dart';
import 'package:flutter_loginpage/screens/wrapper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '/main.dart';


class Loading extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoadingState();
  }
}
class LoadingState extends State<Loading> {
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    startTime();
  }
  startTime() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, route);
  }
  route() {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => Wrapper()
    )
    );
  }




  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
        BackgroundImage1(),
    Scaffold(
    backgroundColor: Colors.transparent,
    body: SingleChildScrollView(
    child: SafeArea( child :
      Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 220),
    child: Center(
    child: Image.asset(
    'assets/images/logo.png',
    width: 170,
    height: 170,
          )


    ),
    ),
        ],
      ),
    ),),),
        ],
    );
  }
}