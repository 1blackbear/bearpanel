import 'package:bearpanel/models/disciplin.dart';

class Users {
  final String uid;
  Users({required this.uid});
}

class UserData {
  final String uid;
  final String name;
  final List disciplines;
  final String course_name;
  final int periods;

  UserData({required this.uid, required this.name, required this.disciplines, required this.course_name, required this.periods});
}
