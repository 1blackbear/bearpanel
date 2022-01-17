import 'package:bearpanel/models/user.dart';
import 'package:bearpanel/services/database.dart';
import 'package:flutter/material.dart';

class DeleteLesson extends StatelessWidget {
  final dynamic discipline;
  final dynamic index;
  final UserData user;
  DeleteLesson(
      {Key? key,
      required this.discipline,
      required this.user,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Icon(Icons.delete),
      onTap: () async {
        discipline['Atividades'].removeAt(index);
        await DatabaseService(uid: user.uid).updateUserData(
            user.name, user.disciplines, user.course_name, user.periods);
      },
    );
  }
}