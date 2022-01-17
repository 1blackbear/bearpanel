import 'package:bearpanel/core/app_colors.dart';
import 'package:bearpanel/models/user.dart';
import 'package:bearpanel/screens/widgets/app_modal.dart';
import 'package:flutter/material.dart';

import 'add_discipline_modal.dart';

//ignore: must be immutable
class AddDiscipline extends StatelessWidget {
  UserData user;
  AddDiscipline({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Positioned(
      right: 50,
      bottom: 50,
      child: FloatingActionButton(
        backgroundColor: Colors.white,
        tooltip: 'Adicionar Disciplina',
        onPressed: () {
          showGeneralDialog(
              context: context,
              transitionDuration: Duration(milliseconds: 200),
              barrierDismissible: true,
              barrierLabel: '',
              transitionBuilder: (context, a1, a2, widgetd) {
                return Transform.scale(
                  scale: a1.value,
                  child: Opacity(
                    opacity: a1.value,
                    child: ModalView(
                      child: AddDisciplineModal(user: user),
                      top: 170,
                      bottom: 130,
                    ),
                  ),
                );
              },
              pageBuilder: (context, animation1, animation2) {throw("");}
          );
        },
        child: Icon(
          Icons.add,
          color: AppColors.black_pattern_dark,
          size: 45,
        ),
      ),
    );
  }
}
