import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/database_helper.dart';

class NotesProvider extends ChangeNotifier {
  List<Map<String, dynamic>> allData = [];

  void refreshData() async {
    allData = await DatabaseHelper.getAllData();
    notifyListeners();
  }

  Future<void> addData(String title, String desc) async {
    await DatabaseHelper.createData(title, desc);
    refreshData();
    notifyListeners();
  }

  Future<void> updateData(int id, String title, String desc) async {
    await DatabaseHelper.updateData(id, title, desc);
    refreshData();
    notifyListeners();
  }

  void deletedata(int id) async {
    await DatabaseHelper.deleteData(id);
    refreshData();
    notifyListeners();
  }

  List<Map<String, dynamic>> getNotes() => allData;
}
