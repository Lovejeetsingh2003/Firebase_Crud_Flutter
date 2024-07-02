import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/crud_object.dart';

class FirestoreService {
//get data
  final CollectionReference data =
      FirebaseFirestore.instance.collection('data');

//create data
  Future<void> addData(String? name, int? age, String? address) {
    return data.add({
      'name': name,
      'age': age,
      'address': address,
      'timeStamp': Timestamp.now()
    });
  }

  //get data for seeing
  Stream<QuerySnapshot> getData() {
    final dataStram = data.orderBy('timeStamp', descending: true).snapshots();
    return dataStram;
  }

  //update data
  Future<void> updateData(
      String docId, String? newName, int? newAge, String? newAddress) {
    return data.doc(docId).update({
      'name': newName,
      'age': newAge,
      'address': newAddress,
      'timeStamp': Timestamp.now()
    });
  }

  //Delete data
  Future<void> deleteData(String docId) {
    return data.doc(docId).delete();
  }
}
