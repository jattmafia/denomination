import 'package:hive/hive.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class NoteModel extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String category;

  @HiveField(2)
  late DateTime date;

  @HiveField(3)
  late int total2000;

  @HiveField(4)
  late int total1000;

  @HiveField(5)
  late int total500;

  @HiveField(6)
  late int total200;

  @HiveField(7)
  late int total100;

  @HiveField(8)
  late int total50;

  @HiveField(9)
  late int total20;

  @HiveField(10)
  late int total10;

  @HiveField(11)
  late int total5;

  @HiveField(12)
  late int total2;

  @HiveField(13)
  late int total1;

  @HiveField(14)
  late int totalSum;
}
