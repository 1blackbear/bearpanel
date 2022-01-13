class Users {
  final String uid;
  Users({required this.uid});
}

class UserData {
  final String uid;
  final String name;
  final List disciplines;

  UserData({required this.uid, required this.name, required this.disciplines});
}
