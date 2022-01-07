
import 'package:bearpanel/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  //colection reference
  final CollectionReference userDataCollection =
      FirebaseFirestore.instance.collection('userData');

  //update user data
  Future updateUserData(String name) async {
    return await userDataCollection.doc(uid).set({
      'Nome': name,
    });
  }

  //user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data()!['Nome'],
    );
  }

  // get user doc stream
  Stream<UserData> get userData {
    return userDataCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

}

