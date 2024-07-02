import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/dialog_screen.dart';
import 'package:flutter/material.dart';

import 'firestore_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirestoreService firestoreService = FirestoreService();
  String? docId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: const Text(
            "FirebaseCrud",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => DialogScreen(docId));
          },
          backgroundColor: Colors.black,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: firestoreService.getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List dataList = snapshot.data!.docs;
              return ListView.builder(
                itemCount: dataList.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = dataList[index];
                  String docId = document.id;
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  String name = data['name'];
                  int age = data['age'];
                  String address = data['address'];
                  return Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    color: Colors.pink,
                    child: ListBody(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  name,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  age.toString(),
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  address,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) =>
                                              DialogScreen(docId));
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      size: 40,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: GestureDetector(
                                    onTap: () {
                                      firestoreService.deleteData(docId);
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      size: 40,
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              );
            } else {
              return const Text("No Data.....!");
            }
          },
        ));
  }
}
