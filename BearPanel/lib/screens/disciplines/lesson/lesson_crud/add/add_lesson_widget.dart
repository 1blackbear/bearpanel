import 'package:bearpanel/core/app_colors.dart';
import 'package:bearpanel/models/user.dart';
import 'package:bearpanel/screens/widgets/app_modal.dart';
import 'package:flutter/material.dart';
import 'add_lesson_modal.dart';

//ignore: must_be_immutable
class AddLesson extends StatelessWidget {
  dynamic discipline;
  UserData user;

  AddLesson({Key? key, required this.discipline, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 10,
      bottom: 20,
      child: SizedBox(
        height: 52,
        child: FloatingActionButton(
          backgroundColor: AppColors.white,
          tooltip: 'Adicionar Atividade',
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
                        child: AddLessonModal(
                          user: user,
                          discipline: discipline,
                        ),
                        top: 150,
                        bottom: 120,
                      ),
                    ),
                  );
                },
                pageBuilder: (context, animation1, animation2) {
                  throw ("");
                });
          },
          child: Icon(
            Icons.add,
            color: AppColors.black_pattern_dark,
            size: 45,
          ),
        ),
      ),
    );
  }
}