import 'package:bearpanel/core/app_colors.dart';
import 'package:bearpanel/core/app_text_styles.dart';
import 'package:bearpanel/models/user.dart';
import 'package:bearpanel/screens/disciplines/lesson/lesson_crud/add/add_lesson_widget.dart';
import 'package:bearpanel/screens/disciplines/lesson/lesson_crud/delete_lesson_widget.dart';
import 'package:bearpanel/screens/widgets/app_modal.dart';
import 'package:flutter/material.dart';
import '../lesson_data_struct.dart';
import 'edit_lesson_modal.dart';

//ignore: must_be_immutable
class RetrieveLesson extends StatefulWidget {
  dynamic discipline;
  UserData user;
  RetrieveLesson({Key? key, required this.discipline, required this.user})
      : super(key: key);

  @override
  _RetrieveLessonState createState() => _RetrieveLessonState();
}

class _RetrieveLessonState extends State<RetrieveLesson> {
  @override
  Widget build(BuildContext context) {
    LessonsData lesson_data = new LessonsData(discipline: widget.discipline, user: widget.user);
    return Expanded(
      child: Stack(
        children: [
          widget.discipline['Atividades'].length == 0
              ? Center(child: Text("Sem Atividades", style: AppTextStyles.emptyStyle))
              : SizedBox(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: lesson_data
                            .getLessons()
                            ?.map((item) => Container(
                                  color: AppColors.white,
                                  child: ListTile(
                                      onTap: () {
                                        showGeneralDialog(
                                            context: context,
                                            transitionDuration:
                                                Duration(milliseconds: 200),
                                            barrierDismissible: true,
                                            barrierLabel: '',
                                            transitionBuilder:
                                                (context, a1, a2, widgetd) {
                                              return Transform.scale(
                                                scale: a1.value,
                                                child: Opacity(
                                                  opacity: a1.value,
                                                  child: ModalView(
                                                    child: EditLessonModal(
                                                      user: widget.user,
                                                      discipline:
                                                          widget.discipline,
                                                      index_lesson: lesson_data
                                                          .getIndexList(
                                                              item.title),
                                                    ),
                                                    top: 150,
                                                    bottom: 120,
                                                  ),
                                                ),
                                              );
                                            },
                                            pageBuilder: (context, animation1,
                                                animation2) {
                                              throw ("");
                                            });
                                      },
                                      title: Text(item.title),
                                      subtitle: Text("Pontuação: ${item.current}/${item.total}"),
                                      trailing: DeleteLesson(
                                        discipline: widget.discipline,
                                        user: widget.user,
                                        index: lesson_data
                                            .getIndexList(item.title),
                                      )),
                                )).toList() ?? [],
                  ),
                ),
          AddLesson(discipline: widget.discipline, user: widget.user)
        ],
      ),
    );
  }
}