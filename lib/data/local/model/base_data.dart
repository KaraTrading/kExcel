import 'package:hive/hive.dart';

abstract class BaseData extends HiveObject {
  @HiveField(0)
  int id;

  BaseData({this.id = 0});
}