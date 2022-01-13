import 'package:bearpanel/models/user.dart';
import 'package:flutter/material.dart';

class DisciplinDetail extends StatefulWidget {
  UserData user;
  int index;
  DisciplinDetail({Key? key, required this.user, required this.index}) : super(key: key);

  @override
  _DisciplinDetailState createState() => _DisciplinDetailState();
}

class _DisciplinDetailState extends State<DisciplinDetail> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Container(child: Text(widget.user.disciplines[widget.index]['Nome']),));
  }
}
