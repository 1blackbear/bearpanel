import 'package:bearpanel/core/app_colors.dart';
import 'package:bearpanel/core/app_text_styles.dart';
import 'package:bearpanel/models/lesson.dart';
import 'package:bearpanel/core/app_data_value.dart';
import 'package:bearpanel/models/user.dart';
import 'package:bearpanel/screens/disciplines/lesson/add_lesson_modal.dart';
import 'package:bearpanel/screens/shared/navigator_base.dart';
import 'package:bearpanel/screens/widgets/app_buttons.dart';
import 'package:bearpanel/screens/widgets/app_cards.dart';
import 'package:bearpanel/screens/widgets/app_modal.dart';
import 'package:bearpanel/services/database.dart';
import 'package:flutter/material.dart';
import 'edit_lesson_modal.dart';

//ignore: must_be_immutable
class LessonsPage extends StatefulWidget {
  UserData user;
  dynamic disciplin;
  LessonsPage({Key? key, required this.disciplin, required this.user})
      : super(key: key);

  @override
  _LessonsPageState createState() => _LessonsPageState();
}

class _LessonsPageState extends State<LessonsPage> {

  List<int> getList() {
    List<int>? list_period = [1];
    for (int i = 2; i <= widget.user.periods; i++) list_period.add(i);
    for (int i = 2; i <= widget.user.periods; i++) list_period.add(i);
    return list_period;
  }

  List<Lesson>? getAtividades() {
    List<Lesson> list = [];
    Lesson les;
    widget.disciplin['Atividades'].forEach((e) {
      les = new Lesson(
          title: e['Titulo'], current: e['Nota Atual'], total: e['Nota Total']);
      list.add(les);
    });
    return list;
  }


  double getMedia() {
    AppGetValue.getMedia(widget.disciplin) >= 0.6 ? widget.disciplin['Status'] = 'aprovado'
        : widget.disciplin['Status'] = 'reprovado';
    return AppGetValue.getMedia(widget.disciplin);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 65.0, left: 25, right: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.disciplin['Nome'],
              style: AppTextStyles.titleDetailPage),
          SizedBox(
            height: 35,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MiniCard(
                  title:
                      "${AppGetValue.getAtual(widget.disciplin) == 100 ? 100 : AppGetValue.getAtual(widget.disciplin).toStringAsFixed(2)}/${AppGetValue.getTotal(widget.disciplin) == 100 ? 100 : AppGetValue.getTotal(widget.disciplin).toStringAsFixed(2)}"),
              MiniCard(
                  title:
                      "${getMedia() == 0.0 || getMedia().isNaN ? 0 : getMedia() == 1 ? 100 : AppGetValue.getMedia(widget.disciplin).toStringAsFixed(2).substring(2)}%"),
              MiniCard(title: widget.disciplin['Status']),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Text('Período', style: AppTextStyles.descForm),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            child: DropdownButton<int>(
              isExpanded: true,
              value: widget.disciplin['Período'],
              icon: const Icon(Icons.arrow_drop_down_outlined),
              underline: Container(
                height: 1,
                color: AppColors.black_pattern,
              ),
              onChanged: (int? newValue) {
                setState(() {
                  widget.disciplin['Período'] = newValue!;
                });
              },
              items: getList().map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text('Atividades', style: AppTextStyles.descForm),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Stack(
              children: [
                widget.disciplin['Atividades'].length == 0
                    ? Center(
                        child: Text(
                        "Atividades Vazias",
                        style: AppTextStyles.emptyStyle,
                      ))
                    : SizedBox(
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: getAtividades()
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
                                                      child: ModalViewr(
                                                        child: EditLessonModal(
                                                          user: widget.user,
                                                          disciplin: widget.disciplin,
                                                          index_lesson:
                                                              getIndexList(
                                                                  item.title),
                                                        ),
                                                        top: 150,
                                                        bottom: 120,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                pageBuilder: (context,
                                                    animation1, animation2) {
                                                  throw ("");
                                                });
                                          },
                                          title: Text(item.title),
                                          subtitle: Text(
                                              "Pontuação: ${item.current}/${item.total}"),
                                          trailing: GestureDetector(
                                            child: Icon(Icons.delete),
                                            onTap: () async {
                                              getMedia() >= 0.6
                                                  ? widget.disciplin
                                                      ['Status'] = 'aprovado'
                                                  : widget.disciplin
                                                      ['Status'] = 'reprovado';
                                              widget.disciplin
                                                      ['Atividades']
                                                  .removeAt(
                                                      getIndexList(item.title));
                                              await DatabaseService(
                                                      uid: widget.user.uid)
                                                  .updateUserData(
                                                      widget.user.name,
                                                      widget.user.disciplines,
                                                      widget.user.course_name,
                                                      widget.user.periods);
                                            },
                                          ),
                                        ),
                                      ))
                                  .toList() ??
                              [],
                        ),
                      ),
                Positioned(
                  right: 10,
                  bottom: 20,
                  child: SizedBox(
                    height: 52,
                    child: FloatingActionButton(
                      backgroundColor: AppColors.white,
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
                                  child: ModalViewr(
                                    child: AddLessonModal(
                                      user: widget.user,
                                      disciplin: widget.disciplin,
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
                ),
              ],
            ),
          ),
          CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              title:
                  Text('Disciplina finalizada?', style: AppTextStyles.descForm),
              activeColor: AppColors.black_pattern,
              value: widget.disciplin['Finalizada?'],
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (value) {
                setState(() {
                  widget.disciplin['Finalizada?'] =
                      value!;
                });
              }),
          SizedBox(
            height: 20,
          ),
          CustomButton(
              title: 'Salvar',
              isEnabled: true,
              onPressed: () async {
                await DatabaseService(uid: widget.user.uid).updateUserData(
                    widget.user.name,
                    widget.user.disciplines,
                    widget.user.course_name,
                    widget.user.periods);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NavigatorBase(
                              spin_animation: true,
                            )));
              }),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  int getIndexList(String current) {
    int index = 0;
    try {
      widget.disciplin['Atividades'].forEach((e) {
        if (e['Titulo'] == current) throw "";
        index++;
      });
    } catch (e) {
      // leave it
    }
    return index;
  }
}
