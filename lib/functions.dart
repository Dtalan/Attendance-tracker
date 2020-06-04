import 'package:attracker/database/subject.dart';
import 'package:attracker/database/routine.dart';
import 'data.dart';

int addSubject(Subject subject) {
    var flag=0;
    
    for(int i=0;i<subjectsBox.length;i++){
      if(subjectsBox.getAt(i).name==subject.name){
        print("subject already exist");
        flag=1;
      }
    }
    if(flag==0)
    subjectsBox.add(subject);
    return flag;
  }

  addroutine(Routine routine){
    routineBox.add(routine);
  }


 List daysInfo(int ij){
    List a;
    switch(ij){
      case 0:a= mon;
        break;
      case 1:a= tue;
        break;
      case 2:a= wed;
        break;
      case 3:a= thu;
        break;
      case 4:a= fri;
        break;
      case 5:a= sat;
        break;
      case 6:a= sun;
        break;
    }
    return a;
  }

  