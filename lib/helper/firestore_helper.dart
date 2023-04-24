import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper {
  FirestoreHelper._();

  static final FirestoreHelper firestoreHelper = FirestoreHelper._();

  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> insertRecords({required Map<String, dynamic> data}) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await db.collection("counter").doc("note_counter").get();

    Map<String, dynamic>? counterData = documentSnapshot.data();

    int counter = counterData!['counter'];
    int length = counterData['length'];

    counter++;
    length++;

    await db.collection("tbl_note").doc("$counter").set(data);

    await db
        .collection("counter")
        .doc("note_counter")
        .update({"counter": counter, "length": length});
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchRecords() {
    return db.collection("tbl_note").snapshots();
  }

  Future<void> deleteRecords({required String id}) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await db.collection("counter").doc("note_counter").get();

    Map<String, dynamic>? counterData = documentSnapshot.data();

    int length = counterData!['length'];

    await db.collection("tbl_note").doc(id).delete();

    length--;

    await db
        .collection("counter")
        .doc("note_counter")
        .update({"length": length});
  }

  Future<void> updateRecord(
      {required String id, required Map<String, dynamic> data}) async {
    await db.collection("tbl_note").doc(id).update(data);
  }
}
