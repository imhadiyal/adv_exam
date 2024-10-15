import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:post_api_app/modals.dart';

import '../api.dart';

class ApiController extends ChangeNotifier {
  ApiController() {
    initdata();
  }
  List<Product> allProduct = [];

  Future<void> initdata() async {
    allProduct = await Api.api.init();
    notifyListeners();
  }

  Future<void> delete({required int id}) async {
    allProduct = await Api.api.delete(id);
    Logger().i('deleted');
    allProduct.removeAt(id);
    notifyListeners();
  }

  Future<void> upDate({required title, required int index}) async {
    allProduct = await Api.api.upDate(title);
    Logger().i('updated');
    allProduct[index].title = title;
    notifyListeners();
  }
}
