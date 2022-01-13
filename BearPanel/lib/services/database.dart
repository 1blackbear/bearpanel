import 'package:bearpanel/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  //colection reference
  final CollectionReference userDataCollection =
      FirebaseFirestore.instance.collection('userData');

  //update user data
  Future updateUserData(String name, List disciplines, String course_name, int periods) async {
    return await userDataCollection.doc(uid).set({
      'Nome': name,
      'Disciplinas': disciplines,
      'Nome do curso': course_name,
      'Qtd de periodos': periods
    });
  }

  //user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.get('Nome'),
      disciplines: snapshot.get('Disciplinas'),
      course_name: snapshot.get('Nome do curso'),
      periods: snapshot.get('Qtd de periodos'),
    );
  }

  // get user doc stream
  Stream<UserData> get userData {
    return userDataCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }


}

