import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  formatsum(sum){
     final formatter = NumberFormat.decimalPattern('en_IN');
  return formatter.format(sum);
  }
}
