import 'package:attracker/data.dart';
import 'package:attracker/functions.dart';
import 'package:attracker/database/subject.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class Uipage extends StatefulWidget {
  @override
  _UipageState createState() => _UipageState();
}

class _UipageState extends State<Uipage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        key:_scaffoldKey,
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Container(
                height:MediaQuery.of(context).size.height,
                width:MediaQuery.of(context).size.width,
                color:Colors.white,
              ),
              Column(
                children: <Widget>[
                  // SizedBox(height:10),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                          onTap: (){
 
                          },
                          child: Icon(Icons.dehaze,size:35,color:Colors.black)
                        ),
                        Text(name.toString()+"'s Tracker",style:TextStyle(fontSize: 20,fontWeight: FontWeight.w900)),
                        Container(height: 20,width:20)
                      ],
                    ),
                  ),
                  SizedBox(height:20),
                  Container(
                    height:MediaQuery.of(context).size.height/1.4,
                    width:MediaQuery.of(context).size.width,
                    child:Padding(
                      padding: const EdgeInsets.fromLTRB(10,0,10,0),
                      child: WatchBoxBuilder(
                        box:Hive.box('subjects'),
                        builder:(context,subjectsBox){
                          return ListView.builder(
                            itemCount:routineBox.length,
                            itemBuilder:(context,index){
                              final subject = subjectsBox.getAt(routineBox.getAt(index).subindex) as Subject;
                              return shape(subject,index,subjectsBox,routineBox);
                            },
                          );
                        }
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,20,20,20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        InkWell(
                          onTap: (){
                            _displayDialog(context);
                          },
                          child: Container(
                            height:80,
                            width:80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color:Colors.blue.withOpacity(0.6),
                              border: Border.all(color:Colors.black)
                            ),
                            child:Icon(Icons.add,color:Colors.black,size:40)
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
  }


  shape(Subject subject,int index,Box<dynamic> subjectsBox,Box<dynamic> routineBox) {
    print(DateFormat('EEEE').format(date));
    var req=((3*subject.total)-(4*subject.attend));
    var per;
    if (subjectsBox.getAt(routineBox.getAt(index).subindex).total!=0&&subject.total!=null){
    per=(subjectsBox.getAt(routineBox.getAt(index).subindex).attend*100)/subjectsBox.getAt(routineBox.getAt(index).subindex).total;}
    else{
      per=0;
    }
    if(subjectsBox.getAt(routineBox.getAt(index).subindex).name!=''){
      return InkWell(
        onTap: (){
          setState(() {
          });
        },
        onLongPress: (){
          _deleteDialogtemp(context,subjectsBox.getAt(routineBox.getAt(index).subindex),index,subjectsBox,routineBox);
          setState(() {
            
          });
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0,0,0,2),
          child: Column(
            children: <Widget>[
              Container(
                height:MediaQuery.of(context).size.height/12,
                width:MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color:Colors.white,
                  // color:colorsection(subject,index),
                    border: Border.all(color:Colors.black),
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child:Stack(
                    children: <Widget>[
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30,0,40,0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(subjectsBox.getAt(routineBox.getAt(index).subindex).name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                              Text(per.toStringAsFixed(2)+"%",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: req>0?Text(req.toStringAsFixed(0),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),):Icon(Icons.check,color:Colors.green,size:35),
                      )
                    ],
                  ),
              ),
            ],
          ),
        ),
      );
    }
    else{
      return Text("No subject added up to yet");
    }
  }



  Color colorsection(Subject subject,int index) {
    // var total=subject.total,expected=subject.expected,attend=subject.attend;
    // print("expected no. of classes are : "+expected.toString());
    // print((attend+(expected-total)).toString());
    Color c;
    if(total!=0&&expected!=0){
      if((subject.attend*100)/subject.total>=75){
        c=Colors.green.withOpacity(0.6);
      }
      else{
        if((subject.attend+(subject.expected-subject.total))/subject.expected>=0.75){
          c=Colors.yellowAccent.withOpacity(0.5);
        }
        else{
          c=Colors.red.withOpacity(0.9);
        }
      }
    }
    return c;
  }


  _modifyDialog(BuildContext context,Subject subject) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('INSERT SUBJECT',style:TextStyle(fontSize: 20,fontWeight: FontWeight.w900)),
          content: Container(
            height:144,
            child: Column(
              children: <Widget>[
                TextField(
                  controller: totalController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: "Enter number of Classes organised today"),
                  inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
                ),
                TextField(
                  controller: attendController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: "Enter number of Classes attended today"),
                  inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
                ),
              ],
            ),
          ), 
          actions: <Widget>[
            Row(
              children: <Widget>[
                new FlatButton(
                  child: new Text('OK'),
                  onPressed: () {
                    
                    subject.attend+=int.parse(attendController.text);                           //////////////////////////////////////////////////////////
                    subject.total+=int.parse(totalController.text);
                    if(subject.total>subject.expected){
                      subject.expected=subject.total;
                    }
                    showInSnackBar("Today's Attendance tracked");
                    
                    setState(() {

                    });
                    attendController.clear();
                    totalController.clear();
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(width:30),
                new FlatButton(
                  child: new Text('CANCEL'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            )
          ],
        );
      }
    );
  }

  _displayDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('INSERT SUBJECT',style:TextStyle(fontSize: 20,fontWeight: FontWeight.w900)),
          content: Container(
            height:192,
            child: Column(
              children: <Widget>[
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(hintText: "Enter subject name"),
                ),
                TextField(
                  controller: totalController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: "Enter Total Classes"),
                  inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
                ),
                TextField(
                  controller: attendController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: "Enter Classes attended"),
                  inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
                ),
                TextField(
                  controller: expectedController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: "Expected Number Of Classes"),
                  inputFormatters: <TextInputFormatter>[WhitelistingTextInputFormatter.digitsOnly],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              children: <Widget>[
                new FlatButton(
                  child: new Text('OK'),
                  onPressed: () {
                    subname=nameController.text[0].toUpperCase()+nameController.text.substring(1);
                    if(totalController.text!= ""){
                    total=int.parse(totalController.text);}
                    else{
                      total=0;
                    }
                    if(totalController.text!= ""){
                    attended=int.parse(attendController.text);}
                    else{
                      attended=0;
                    }

                    if(expectedController.text!= ""){
                    expected=int.parse(expectedController.text);}
                    else{
                      expected=0;
                    }
                    
                    if(expected!=0&&expected>=total&&total>=attended){
                      final newsubject=Subject(subname,total,attended,expected,1);
                      int flag=addSubject(newsubject);

                      if(nameController.text.toString()!=""&&flag==0){
                        showInSnackBar("Subject added");
                      }
                      else{
                        showInSnackBar("Subject already exists");

                      }
                    }
                    else{
                      if(expected==0){
                        showInSnackBar("invalid entry");
                        showInSnackBar("expected number of classes can not be 0",time: 1500);
                      }
                      else if(expected<total){
                        showInSnackBar("invalid entry");
                        showInSnackBar("expected number of classes can not be lesser than total classes held",time: 1500);
                      }
                      else if(total<attended){
                        showInSnackBar("invalid entry");
                        showInSnackBar("you can not attend classes more than the classes held",time: 1500);
                      }
                    }

                    setState(() {

                    });
                    nameController.clear();
                    totalController.clear();
                    attendController.clear();
                    expectedController.clear();
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(width:30),
                new FlatButton(
                  child: new Text('CANCEL'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            )
          ],
        );
      }
    );
  }


  _deleteDialogtemp(BuildContext context,Subject subject,int index,Box<dynamic> subjectsBox,Box<dynamic> routineBox) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text(subject.name.toUpperCase()+"  (Choose Action)",style:TextStyle(fontSize: 20,fontWeight: FontWeight.w900))),
          actions: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    new FlatButton(
                      onPressed:(){
                        Navigator.of(context).pop();
                        _modifyDialog(context,subject);
                      }, 
                      child: Text("Insert attendance track")
                    ),
                    SizedBox(width:10),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    new FlatButton(
                      onPressed:(){
                        Navigator.of(context).pop();
                        _deleteDialog(context,index,subjectsBox,routineBox);
                      }, 
                      child: Text("Delete subject")
                    ),
                    SizedBox(width:10),
                  ],
                )
              ],
            ),
          ],
        );
      }
    );
  }


  _deleteDialog(BuildContext context,int index,Box<dynamic> subjectsBox,Box<dynamic> routineBox) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Item',style:TextStyle(fontSize: 20,fontWeight: FontWeight.w900)),
          content: Text(
            "Are you sure, You want to delete subject tracking !!?"
          ),
          actions: <Widget>[
            Row(
              children: <Widget>[
                new FlatButton(
                  child: new Text('OK'),
                  onPressed: () {
                    // subjectsBox.deleteAt(index);
                    routineBox.deleteAt(index);
                    // setState(() {
                      
                    // });
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(width:30),
                new FlatButton(
                  child: new Text('CANCEL'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            )
          ],
        );
      }
    );
  }


  void showInSnackBar(String str,{int time=800}) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(str,style: TextStyle(color:Colors.black,fontWeight: FontWeight.w900),),backgroundColor: Colors.cyan,duration: Duration(milliseconds: time)));
  }
       
  

}