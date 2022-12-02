import 'package:hive/hive.dart';

abstract class BaseData extends HiveObject {
  @HiveField(0)
  int id = 0;
}