import 'package:flutter/cupertino.dart';

import '../helper/product_helper.dart';
import '../modals.dart';

class DbController extends ChangeNotifier {
  DbController() {
    initData();
  }
  TextEditingController controller = TextEditingController();
  List<Product> allData = [];

  Future<void> initData() async {
    DbHelper.dbHelper.initDb();
    notifyListeners();
  }

  Future<void> getAllData() async {
    allData = await DbHelper.dbHelper.getAllData();
    notifyListeners();
  }

  Future<void> insertData({required Product controller}) async {
    await DbHelper.dbHelper.insertData(product: controller);
    getAllData();
  }

  Future<void> updateData({required Product controller}) async {
    await DbHelper.dbHelper.updateData(product: controller);
    getAllData();
  }

  Future<void> deleteData({required Product controller}) async {
    await DbHelper.dbHelper.deleteData(product: controller);
    getAllData();
  }
}
