import 'package:flutter/cupertino.dart';

import '../modals.dart';
import '../services/firebase_services.dart';

class FirestoreController extends ChangeNotifier {
  Future<void> getData() async {
    await FireStoreServices.instance.getUser();
  }

  Future<void> addUser({required Product product}) async {
    await FireStoreServices.instance.addUser(product: product);
  }
}
