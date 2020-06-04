import 'package:hive/hive.dart';
part 'transition.g.dart';

@HiveType(typeId: 1)
class Transition {
  @HiveField(0)
  final int page;
  @HiveField(1)
  final String username;

  Transition(this.page,this.username);
}