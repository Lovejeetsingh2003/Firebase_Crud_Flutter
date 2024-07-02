import 'package:firebase_crud/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DialogScreen extends StatefulWidget {
  final documentId;
  const DialogScreen(this.documentId, {super.key});

  @override
  State<DialogScreen> createState() => _DialogScreenState();
}

class _DialogScreenState extends State<DialogScreen> {
  var nameController = TextEditingController();
  var ageController = TextEditingController();
  var addressController = TextEditingController();
  var task = "Save";
  final FirestoreService firestoreService = FirestoreService();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
      child: Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Employee Details",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                    borderSide: BorderSide(width: 3, color: Colors.black),
                  ),
                  hintText: "Enter the Name",
                  hintStyle: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: ageController,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                    borderSide: BorderSide(width: 3, color: Colors.black),
                  ),
                  hintText: "Enter the Age",
                  hintStyle: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: addressController,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                    borderSide: BorderSide(width: 3, color: Colors.black),
                  ),
                  hintText: "Enter the Address",
                  hintStyle: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                onPressed: () {
                  if (nameController.text.isEmpty) {
                    Fluttertoast.showToast(msg: "Enter the Name");
                  } else if (ageController.text.isEmpty) {
                    Fluttertoast.showToast(msg: "Enter the Age");
                  } else if (addressController.text.isEmpty) {
                    Fluttertoast.showToast(msg: "Enter the Address");
                  } else {
                    if (widget.documentId == null) {
                      firestoreService.addData(
                          nameController.text.toString(),
                          int.parse(ageController.text),
                          addressController.text.toString());
                    } else {
                      firestoreService.updateData(
                          widget.documentId,
                          nameController.text.toString(),
                          int.parse(ageController.text),
                          addressController.text.toString());
                    }
                    Fluttertoast.showToast(msg: "Data Added");
                    Navigator.of(context).pop();
                    nameController.clear();
                    ageController.clear();
                    addressController.clear();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    task,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
