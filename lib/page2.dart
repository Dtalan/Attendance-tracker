import 'package:attracker/Page3.dart';
import 'package:attracker/functions.dart';
import 'package:attracker/database/subject.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:attracker/data.dart';

class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  
  
  @override
  Widget build(BuildContext context) {
     return FutureBuilder(
      future:Hive.openBox("routine"),
      builder: (BuildContext context,AsyncSnapshot snapshot){
        if(snapshot.connectionState ==ConnectionState.done){
          if(snapshot.hasError)
            return Text(snapshot.error.toString());
          else{
            return Scaffold(
              key:_scaffoldKey,
              body: Stack(
                children: <Widget>[
                  Container(
                    height:MediaQuery.of(context).size.height,
                    width:MediaQuery.of(context).size.width,
                    color:Colors.white,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        height: 500,
                        width:MediaQuery.of(context).size.width,
                        child:subjectsBox.length!=0?
                        WatchBoxBuilder(
                          box:Hive.box('subjects'),
                          builder:(context,subjectsBox){
                            return ListView.builder(
                              itemCount:subjectsBox.length,
                              itemBuilder:(context,index){
                                final subject = subjectsBox.getAt(index) as Subject;
                                return shape(subject,index,subjectsBox);
                              },
                            );
                          }
                        ):Center(child: Text('Why there are no subjects !!!....  :(\n\nTo add subjects click on the "ADD" icon...')),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30,0,30,0),
                        child: InkWell(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(
                                                builder: (context) => Page3()));
                          },
                          child: Container(
                            height:60,
                            width:MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color:Colors.blue,
                            ),
                            child:Center(
                              child:Text(
                                "Submit",
                                style:TextStyle(color:Colors.white)
                              ),
                            )
                          ),
                        ),
                      ),
                      SizedBox(height:0) 
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,0,30,30),
                    child: Align(
                      alignment:Alignment.bottomRight,
                      child: InkWell(
                        onTap: (){
                          _displayDialog(context);
                        },
                        child: Container(
                          height:70,
                          width:70,
                          decoration: BoxDecoration(
                            color:Colors.blue,
                            borderRadius: BorderRadius.circular(35)
                          ),
                          child:Icon(Icons.add,color:Colors.white,size: 30)
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        }
        else{
          return Scaffold();
        }
      },
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
                      final newsubject=Subject(subname,total,attended,expected,0);
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



  void showInSnackBar(String str,{int time=800}) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(str,style: TextStyle(color:Colors.black,fontWeight: FontWeight.w900),),backgroundColor: Colors.cyan,duration: Duration(milliseconds: time)));
  }


  shape(Subject subject,int index,Box<dynamic> subjectsBox) {
    var req=((3*subject.total)-(4*subject.attend));
    var per;
    if (subject.total!=0&&subject.total!=null){
    per=(subject.attend*100)/subject.total;}
    else{
      per=0;
    }
    if(subjectsBox.length!=0){
      return InkWell(
        onLongPress: (){
          _deleteDialog(context,index,subjectsBox);
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(subject.name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                              // Text(per.toStringAsFixed(2)+"%",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                            ],
                          ),
                        ),
                      ),
                      // Center(
                      //   child: req>0?Text(req.toStringAsFixed(0),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),):Icon(Icons.check,color:Colors.green,size:35),
                      // )
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




  _deleteDialog(BuildContext context,int index,Box<dynamic> subjectsBox) async {
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
                    subjectsBox.deleteAt(index);
                    setState(() {
                      
                    });
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


}