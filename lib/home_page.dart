import 'package:flutter/material.dart';
import 'package:post_api_app/controller/controller.dart';
import 'package:post_api_app/controller/sql_controller.dart';
import 'package:provider/provider.dart';

import 'controller/firebase_controller.dart';
import 'modals.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    ApiController apiController = Provider.of<ApiController>(context);
    DbController dbController = Provider.of<DbController>(context);
    FirestoreController firestoreController =
        Provider.of<FirestoreController>(context);

    TextEditingController controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.read_more),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: apiController.allProduct.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage:
                  NetworkImage(apiController.allProduct[index].thumbnail),
            ),
            title: Text(apiController.allProduct[index].title),
            trailing: IconButton(
              onPressed: () {
                firestoreController.addUser(
                    product: apiController.allProduct[index]);
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: TextFormField(
                      onChanged: (val) {
                        dbController.controller.text = val;
                      },
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          dbController.insertData(
                              controller: apiController.allProduct[index]);
                        },
                        child: const Text("Add"),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
