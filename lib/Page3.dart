import 'package:attracker/data.dart';
import 'package:attracker/functions.dart';
import 'package:attracker/myuipage.dart';
import 'package:attracker/database/routine.dart';
import 'package:attracker/database/subject.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Page3 extends StatefulWidget {
  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  
 
  // PageController _controller= PageController(
  //   initialPage: 0,
  // );
  
  @override
  // void dispose(){
  //   _controller.dispose();
  //   super.dispose();
  // }
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height:MediaQuery.of(context).size.height,
          width:MediaQuery.of(context).size.width,
          child:Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0,0,0,30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height/1.16,
                    width:MediaQuery.of(context).size.width,
                    //  child:Container(
                    //    height: MediaQuery.of(context).size.height,
                    //  width:MediaQuery.of(context).size.width,
                    //  color:Colors.blue,
                    //  )
                    child:PageView.builder(
                      itemCount: 7,
                      itemBuilder: (context,position){
                        return  day(listday[position]);
                      },
                    )
                  ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30,0,30,0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height:40,
                          width:MediaQuery.of(context).size.width/4,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(30)
                          ),
                          child:Center(
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Icon(Icons.keyboard_arrow_left),
                                Text("Back",style:TextStyle(fontWeight: FontWeight.w900,fontSize:20)),
                              ],
                            )
                          )
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          for(int k=0;k<mon.length;k++){
                            final newroutine= Routine(0,mon[k]);
                            addroutine(newroutine);
                          }
                          for(int k=0;k<tue.length;k++){
                            final newroutine= Routine(1,tue[k]);
                            addroutine(newroutine);
                          }
                          for(int k=0;k<wed.length;k++){
                            final newroutine= Routine(2,wed[k]);
                            addroutine(newroutine);
                          }
                          for(int k=0;k<thu.length;k++){
                            final newroutine= Routine(3,thu[k]);
                            addroutine(newroutine);
                          }
                          for(int k=0;k<fri.length;k++){
                            final newroutine= Routine(4,fri[k]);
                            addroutine(newroutine);
                          }
                          for(int k=0;k<sat.length;k++){
                            final newroutine= Routine(5,sat[k]);
                            addroutine(newroutine);
                          }
                          for(int k=0;k<sun.length;k++){
                            final newroutine= Routine(6,sun[k]);
                            addroutine(newroutine);
                          }






                          Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => Uipage()));
                        },
                        child: Container(
                          height:40,
                          width:MediaQuery.of(context).size.width/4,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(30)
                          ),
                          child:Center(
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text("Next",style:TextStyle(fontWeight: FontWeight.w900,fontSize:20)),
                                Icon(Icons.keyboard_arrow_right)
                              ],
                            )
                          )
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    ),
  );
}
  
  Widget shape(Subject subject, int index, Box subjectsBox,String s) {
    var ind=index*2;
    Widget w;
    if(ind+1<=subjectsBox.length-1){
      w=Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                onTap: (){
                  if(subjectsBox.getAt(ind).tap==0){
                    subjectsBox.getAt(ind).tap=1;
                  }
                  else if(subjectsBox.getAt(ind).tap==1){
                    subjectsBox.getAt(ind).tap=0;
                  }
                  // daysInfo(i).length=daysInfo(i).length+1;
                  // if(daysInfo(i).)
                  if(daysInfo(i).contains(ind)){}
                  else{
                    daysInfo(i).add(ind); 
                  }
                  // daysInfo[_controller as int][i]=ind;
                  // _controller
                  setState(() {
                    
                  });
                },
                child: Container(
                  height:50,
                  width:MediaQuery.of(context).size.width/3,
                  decoration: BoxDecoration(
                    // color:_colorsection(subjectsBox.getAt(ind).tap),
                    color:Colors.black,
                    borderRadius: BorderRadius.circular(25,)
                  ),
                  child:Center(child: Text(subjectsBox.getAt(ind).name,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w800,color:Colors.white),),)
                ),
              ),
              InkWell(
                onTap: (){
                  if(subjectsBox.getAt(ind+1).tap==0){
                    subjectsBox.getAt(ind+1).tap=1;
                  }
                  else if(subjectsBox.getAt(ind+1).tap==1){
                    subjectsBox.getAt(ind+1).tap=0;
                  }
                  // daysInfo(i).length=daysInfo(i).length+1;
                  if(daysInfo(i).contains(ind+1)){}
                  else{
                    daysInfo(i).add(ind+1); 
                  }
                  setState(() {
                    
                  });
                },
                child: Container(
                  height:50,
                  width:MediaQuery.of(context).size.width/3,
                  decoration: BoxDecoration(
                    // color:_colorsection(subjectsBox.getAt(ind+1).tap),
                    color:Colors.black,
                    borderRadius: BorderRadius.circular(25,)
                  ),
                  child:Center(child: Text(subjectsBox.getAt(ind+1).name,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w800,color:Colors.white)),)
                ),
              ),
            ],
          ),
          SizedBox(height:10)
        ],
      );
    }
    else if(ind+1<=subjectsBox.length){
      w=Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          InkWell(
            onTap: (){
              if(subjectsBox.getAt(ind).tap==0){
                    subjectsBox.getAt(ind).tap=1;
                  }
                  else if(subjectsBox.getAt(ind).tap==1){
                    subjectsBox.getAt(ind).tap=0;
                  }
                  // daysInfo(i).length=daysInfo(i).length+1;
                  if(daysInfo(i).contains(ind)){}
                  else{
                    daysInfo(i).add(ind); 
                  }
                  setState(() {
                    
                  });
            },
            child: Container(
            height:50,
              width:MediaQuery.of(context).size.width/1.5,
              decoration: BoxDecoration(
                // color:_colorsection(subjectsBox.getAt(ind).tap),
                color:Colors.black,
                borderRadius: BorderRadius.circular(25)
              ),
              child:Center(child: Text(subjectsBox.getAt(ind).name,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w800,color:Colors.white)),)
            ),
          ),
        ],
      );
    }
    else{
      w=Row(
        children: <Widget>[
          
        ],
      );
    }
    return w;
  }

  _colorsection(tap) {
    Color c;
    if(tap==0){
      c=Colors.yellow;
    }
    else{
      c=Colors.brown;
    }
    return c;
  }

  day(String s) {
    switch(s){
      case "Monday":{ i=0;}
        break;
      case "Tuesday":{i=1;}
        break;
      case "Wednesday":{i=2;}
        break;
      case "Thursday":{i=3;}
        break;
      case "Friday":{i=4;}
        break;
      case "Saturday":{i=5;}
        break;
      case "Sunday":{i=6;}
        break;
    }
    // print(i);
    print("length = "+daysInfo(i).length.toInt().toString());
    return Container(
      height:MediaQuery.of(context).size.height,
      width:MediaQuery.of(context).size.width,
      child:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(height:5),
            Center(
              child:Text(s.toUpperCase(),style:TextStyle(fontSize: 19,fontWeight: FontWeight.w900)),),
            Container(
              height:MediaQuery.of(context).size.height-390,
              width:MediaQuery.of(context).size.width,
              child:ListView.builder(
                itemCount:daysInfo(i).length.toInt(),
                itemBuilder:(context,index){
                  final subject = subjectsBox.getAt(daysInfo(i)[index]) as Subject;
                  return shapetile(subject,daysInfo(i)[index],subjectsBox);
                },             
              )
            ),
            Container(
              height: MediaQuery.of(context).size.height/3.5,
              width:MediaQuery.of(context).size.width,
              child:subjectsBox.length!=0?ListView.builder(
                itemCount:subjectsBox.length,
                itemBuilder:(context,index){
                  final subject = subjectsBox.getAt(index) as Subject;
                  return shape(subject,index,subjectsBox,s);
                },
              ):Center(
                child: Text("no subjects added")
                ),
            ),
          ],
        ),
      )
    );
  }



  shapetile(Subject subject,int index,Box<dynamic> subjectsBox) {
    print("index passed : "+index.toInt().toString());
    var req=((3*subject.total)-(4*subject.attend));
    var per;
    if (subject.total!=0&&subject.total!=null){
    per=(subject.attend*100)/subject.total;}
    else{
      per=0;
    }
    if(subject.name!=''){
      return InkWell(
        onTap: (){
          setState(() {
          });
        },
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(subject.name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
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