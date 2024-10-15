import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:post_api_app/modals.dart';

class FireStoreServices {
  FireStoreServices._();

  static final FireStoreServices instance = FireStoreServices._();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  //Collection
  String userPath = "users";

  late Product product;

  //Add User
  Future<void> addUser({required Product product}) async {
    Map<String, dynamic> data = {
      'name': product.title,
      'category': product.category,
      'price': product.price,
    };

    await fireStore.collection(userPath).doc(product.title).set(data);
  }

  //Get User
  Future<void> getUser() async {
    DocumentSnapshot snap =
        await fireStore.collection(userPath).doc(product.title).get();

    Logger().i(snap.data());
    product = Product.fromJson(json: snap.data() as Map<String, dynamic>);

    Logger().i(product.title);
  }
}
