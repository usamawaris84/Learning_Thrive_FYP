import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learning_thrive/messaging/constants/firestore_constants.dart';

class HomeProvider {
  final FirebaseFirestore firebaseFirestore;

  HomeProvider({required this.firebaseFirestore});

  Future<void> updateDataFirestore(String collectionPath, String path, Map<String, String> dataNeedUpdate) {
    return firebaseFirestore.collection(collectionPath).doc(path).update(dataNeedUpdate);
  }

  Stream<QuerySnapshot> getStreamFireStore(String pathCollection, int limit, String? textSearch) {
    if (textSearch?.isNotEmpty == true) {
      return firebaseFirestore
          .collection(pathCollection)
          .limit(limit)
          .where(FirestoreConstants.disc, isGreaterThanOrEqualTo: textSearch)
          //.where((user) => FirestoreConstants.firstName.toLowerCase().contains(textSearch!))
          .snapshots();
    } else {
      return firebaseFirestore.collection(pathCollection).limit(limit).snapshots();
    }
  }
}
