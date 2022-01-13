import 'package:bearpanel/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  //colection reference
  final CollectionReference userDataCollection =
      FirebaseFirestore.instance.collection('userData');

  //update user data
  Future updateUserData(String name, List disciplines) async {
    return await userDataCollection.doc(uid).set({
      'Nome': name,
      'Disciplinas': disciplines
    });
  }

  //user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.get('Nome'),
      disciplines: snapshot.get('Disciplinas'),
    );
  }

  // get user doc stream
  Stream<UserData> get userData {
    return userDataCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }


}

