import 'package:hive/hive.dart';
part 'subject.g.dart';

@HiveType(typeId: 0)
class Subject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  int total;
  @HiveField(2)
  int attend;
  @HiveField(3)
  int expected;
  @HiveField(4)
  int tap;

  Subject(this.name, this.total, this.attend,this.expected,this.tap);
}