import 'package:flutter/material.dart';

class ShowDialog extends StatelessWidget {
  final String title_msg;
  final String desc_msg;

  const ShowDialog({Key? key, required this.title_msg, required this.desc_msg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title_msg),
      content: Text(desc_msg),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Voltar',
            style: TextStyle(
              color: Color(0xFF707070),
            ),
          ),
        ),
      ],
    );
  }
}

class ShowDialogUntil extends StatelessWidget {
  final String title_msg;
  final String desc_msg;

  const ShowDialogUntil({Key? key, required this.title_msg, required this.desc_msg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title_msg),
      content: Text(desc_msg),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
          child: Text(
            'Voltar',
            style: TextStyle(
              color: Color(0xFF707070),
            ),
          ),
        ),
      ],
    );
  }
}

