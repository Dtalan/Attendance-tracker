import 'dart:ui';

import 'package:attracker/data.dart';
import 'package:attracker/page2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Intro extends StatefulWidget {
  const Intro({Key key}) : super(key: key);
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Container(
          height:MediaQuery.of(context).size.height,
          width:MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/back.png"),fit: BoxFit.cover)
          ),
          child:Stack(
            children: <Widget>[
              BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                child: Container(
                  decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
                ),
              ),
              Center(
                child:Padding(
                  padding: const EdgeInsets.fromLTRB(70,100,70,0),
                  child: Column(
                    children: <Widget>[
                      Text("ATTENDANCE !!!!",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 40,color:Colors.white),),
                      SizedBox(height:40),
                      Text("We've got your back",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 23,color:Colors.white)),
                      SizedBox(height:300),
                      Column(
                        children: <Widget>[
                          TextField(
                            controller: nameController,
                            decoration: InputDecoration(hintText: "Enter your first name",hintStyle: TextStyle(color:Colors.white.withBlue(200),fontSize: 15)),
                          ),
                          SizedBox(height:20),
                          InkWell(
                            onTap: (){
                              name=nameController.text[0].toUpperCase()+nameController.text.substring(1);
                              nameController.clear();
                              Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => Page2()));
                            },
                            child: Container(
                              height:40,
                              width:MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color:Colors.red,
                              ),
                              child:Center(
                                child:Text(
                                  "Submit",
                                  style:TextStyle(color:Colors.white)
                                ),
                              )
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ),
            ],
          )
        ),
      ),
    );
  }
}