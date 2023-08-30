import 'package:hive/hive.dart';

part 'dailyModel.g.dart';

@HiveType(typeId: 1)
class DailyModel{
  @HiveField(0)
  int id;
  @HiveField(1)
  String content;
  @HiveField(2)
  String alarm;

DailyModel( this.id, this.content, this.alarm);
}