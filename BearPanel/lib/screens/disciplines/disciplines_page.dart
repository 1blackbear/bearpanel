import 'package:flutter/material.dart';

class DisciplinesPage extends StatefulWidget {
  const DisciplinesPage({Key? key}) : super(key: key);

  @override
  _DisciplinesPageState createState() => _DisciplinesPageState();
}

class _DisciplinesPageState extends State<DisciplinesPage> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Center(child: Text("Disciplinas"))
    ]);
  }
}
