import 'dart:developer';

import 'package:denomination/app/screens/homepage/model/note_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:number_to_words_english/number_to_words_english.dart';

class HomepageProvider with ChangeNotifier {
  TextEditingController rs2000fieldController = TextEditingController();
  TextEditingController rs1000fieldController = TextEditingController();
  TextEditingController rs500fieldController = TextEditingController();
  TextEditingController rs200fieldController = TextEditingController();
  TextEditingController rs100fieldController = TextEditingController();
  TextEditingController rs50fieldController = TextEditingController();
  TextEditingController rs20fieldController = TextEditingController();
  TextEditingController rs10fieldController = TextEditingController();
  TextEditingController rs5fieldController = TextEditingController();
  TextEditingController rs2fieldController = TextEditingController();
  TextEditingController rs1fieldController = TextEditingController();

  NoteModel? currentNote;

  int total2000 = 0;
  int total1000 = 0;
  int total500 = 0;
  int total200 = 0;
  int total100 = 0;
  int total50 = 0;
  int total20 = 0;
  int total10 = 0;
  int total5 = 0;
  int total2 = 0;
  int total1 = 0;

  int totalSum = 0;

  multiplyrs2000() {
    total2000 = int.parse(rs2000fieldController.text) * 2000;
    notifyListeners();
  }

  multiplyrs1000() {
    total1000 = int.parse(rs1000fieldController.text) * 1000;
    notifyListeners();
  }

  multiplyrs500() {
    total500 = int.parse(rs500fieldController.text) * 500;
    notifyListeners();
  }

  multiplyrs200() {
    total200 = int.parse(rs200fieldController.text) * 200;
    notifyListeners();
  }

  multiplyrs100() {
    total100 = int.parse(rs100fieldController.text) * 100;
    notifyListeners();
  }

  multiplyrs50() {
    total50 = int.parse(rs50fieldController.text) * 50;
    notifyListeners();
  }

  multiplyrs20() {
    total20 = int.parse(rs20fieldController.text) * 20;
    notifyListeners();
  }

  multiplyrs10() {
    total10 = int.parse(rs10fieldController.text) * 10;
    notifyListeners();
  }

  multiplyrs5() {
    total5 = int.parse(rs5fieldController.text) * 5;
    notifyListeners();
  }

  multiplyrs2() {
    total2 = int.parse(rs2fieldController.text) * 2;
    notifyListeners();
  }

  multiplyrs1() {
    total1 = int.parse(rs1fieldController.text) * 1;
    notifyListeners();
  }

  clearrs2000() {
    rs2000fieldController.clear();
    total2000 = 0;
    notifyListeners();
  }

  clearrs1000() {
    rs1000fieldController.clear();
    total1000 = 0;
    notifyListeners();
  }

  clearrs500() {
    rs500fieldController.clear();
    total500 = 0;
    notifyListeners();
  }

  clearrs200() {
    rs200fieldController.clear();
    total200 = 0;
    notifyListeners();
  }

  clearrs100() {
    rs100fieldController.clear();
    total100 = 0;

    notifyListeners();
  }

  clearrs50() {
    rs50fieldController.clear();
    total50 = 0;
    notifyListeners();
  }

  clearrs20() {
    rs20fieldController.clear();
    total20 = 0;
    notifyListeners();
  }

  clearrs10() {
    rs10fieldController.clear();
    total10 = 0;
    notifyListeners();
  }

  clearrs5() {
    rs5fieldController.clear();
    total5 = 0;
    notifyListeners();
  }

  clearrs2() {
    rs2fieldController.clear();
    total2 = 0;
    notifyListeners();
  }

  clearrs1() {
    rs1fieldController.clear();
    total1 = 0;
    notifyListeners();
  }

  calculatetotal() {
    totalSum = total2000 +
        total1000 +
        total500 +
        total200 +
        total100 +
        total50 +
        total20 +
        total10 +
        total5 +
        total2 +
        total1;

    log(totalSum.toString());

    notifyListeners();
  }

  formatsum(sum) {
    final formatter = NumberFormat.decimalPattern('en_IN');
    return formatter.format(sum);
  }

  Future<void> saveData(String name, String category) async {
    final box = Hive.box<NoteModel>('notes');
    final note = NoteModel()
      ..name = name
      ..category = category
      ..date = DateTime.now()
      ..total2000 = total2000
      ..total1000 = total1000
      ..total500 = total500
      ..total200 = total200
      ..total100 = total100
      ..total50 = total50
      ..total20 = total20
      ..total10 = total10
      ..total5 = total5
      ..total2 = total2
      ..total1 = total1
      ..totalSum = totalSum;
    await box.add(note);
  }

  void editNote(NoteModel note) {
    int count2000 = note.total2000 ~/ 2000;
    int count1000 = note.total1000 ~/ 1000;
    int count500 = note.total500 ~/ 500;
    int count200 = note.total200 ~/ 200;
    int count100 = note.total100 ~/ 100;
    int count50 = note.total50 ~/ 50;
    int count20 = note.total20 ~/ 20;
    int count10 = note.total10 ~/ 10;
    int count5 = note.total5 ~/ 5;
    int count2 = note.total2 ~/ 2;
    int count1 = note.total1 ~/ 1;

    rs2000fieldController.text = count2000.toString();
    rs1000fieldController.text = count1000.toString();
    rs500fieldController.text = count500.toString();
    rs200fieldController.text = count200.toString();
    rs100fieldController.text = count100.toString();
    rs50fieldController.text = count50.toString();
    rs20fieldController.text = count20.toString();
    rs10fieldController.text = count10.toString();
    rs5fieldController.text = count5.toString();
    rs2fieldController.text = count2.toString();
    rs1fieldController.text = count1.toString();
    totalSum = note.totalSum;

    currentNote = note;

    multiplyrs1();
    multiplyrs10();
    multiplyrs100();
    multiplyrs1000();
    multiplyrs2();
    multiplyrs20();
    multiplyrs200();
    multiplyrs2000();
    multiplyrs5();
    multiplyrs50();
    multiplyrs500();

    notifyListeners();
  }

  Future<void> updateNote(String name, String category) async {
    final note = currentNote;
    if (note != null) {
      note
        ..total2000 = total2000
        ..total1000 = total1000
        ..total500 = total500
        ..total200 = total200
        ..total100 = total100
        ..total50 = total50
        ..total20 = total20
        ..total10 = total10
        ..total5 = total5
        ..total2 = total2
        ..total1 = total1
        ..totalSum = totalSum
        ..category = category
        ..name = name;

      await note.save();

      currentNote = null;
      notifyListeners();
    }
  }

  clearAllFields() {
    rs2000fieldController.clear();
    rs1000fieldController.clear();
    rs500fieldController.clear();
    rs200fieldController.clear();
    rs100fieldController.clear();
    rs50fieldController.clear();
    rs20fieldController.clear();
    rs10fieldController.clear();
    rs5fieldController.clear();
    rs2fieldController.clear();
    rs1fieldController.clear();

    total2000 = 0;
    total1000 = 0;
    total500 = 0;
    total200 = 0;
    total100 = 0;
    total50 = 0;
    total20 = 0;
    total10 = 0;
    total5 = 0;
    total2 = 0;
    total1 = 0;
    totalSum = 0;

    currentNote = null;
  }

  String generateShareContent(NoteModel note) {
    final formattedDate = DateFormat('dd-MMM-yyyy hh:mm a').format(note.date);

    final totalCounts = note.total2000 ~/ 2000 +
        note.total1000 ~/ 1000 +
        note.total500 ~/ 500 +
        note.total200 ~/ 200 +
        note.total100 ~/ 100 +
        note.total50 ~/ 50 +
        note.total20 ~/ 20 +
        note.total10 ~/ 10 +
        note.total5 ~/ 5 +
        note.total2 ~/ 2 +
        note.total1 ~/ 1;

    final grandTotal = note.totalSum;
    final grandTotalInWords = NumberToWordsEnglish.convert(grandTotal);

    return '''
General
Denomination
$formattedDate
${note.category}
---------------------------------------
Rupee x Counts = Total
₹ 2,000 x ${note.total2000 ~/ 2000} = ₹ ${note.total2000}
₹ 500 x ${note.total500 ~/ 500} = ₹ ${note.total500}
₹ 200 x ${note.total200 ~/ 200} = ₹ ${note.total200}
₹ 100 x ${note.total100 ~/ 100} = ₹ ${note.total100}
---------------------------------------
Total Counts:
$totalCounts
Grand Total Amount:
₹ $grandTotal
${toBeginningOfSentenceCase(grandTotalInWords)} only/-
''';
  }
}
