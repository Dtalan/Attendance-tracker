import 'package:hive/hive.dart';
part 'routine.g.dart';

@HiveType(typeId: 2)
class Routine {
  @HiveField(0)
  final int day;
  @HiveField(1)
  final int subindex;

  Routine(this.day, this.subindex);

}