import 'package:bearpanel/core/app_colors.dart';
import 'package:bearpanel/core/app_text_styles.dart';
import 'package:bearpanel/models/lesson.dart';
import 'package:bearpanel/core/app_data_value.dart';
import 'package:bearpanel/models/user.dart';
import 'package:bearpanel/screens/disciplines/lesson/add_lesson_modal.dart';
import 'package:bearpanel/screens/widgets/app_cards.dart';
import 'package:bearpanel/screens/widgets/app_modal.dart';
import 'package:bearpanel/services/database.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'edit_lesson_modal.dart';

//ignore: must_be_immutable
class LessonsPage extends StatefulWidget {
  UserData user;
  dynamic discipline;
  LessonsPage({Key? key, required this.discipline, required this.user})
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

  List<Lesson>? getLessons() {
    List<Lesson> list = [];
    Lesson les;
    widget.discipline['Atividades'].forEach((e) {
      les = new Lesson(
          title: e['Titulo'], current: e['Nota Atual'], total: e['Nota Total']);
      list.add(les);
    });
    return list;
  }

  List<String> actions = ['Editar', 'Voltar', 'Atualizar'];


  int getIndexList(String current) {
    int index = 0;
    try {
      widget.discipline['Atividades'].forEach((e) {
        if (e['Titulo'] == current) throw "";
        index++;
      });
    } catch (e) {
      // leave it
    }
    return index;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 65.0, left: 25, right: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.discipline['Nome'],
              style: AppTextStyles.titleDetailPage),
          SizedBox(
            height: 35,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MiniCard(
                  title:
                      "${AppGetValue.getAtual(widget.discipline) == 100 ? 100 : AppGetValue.getAtual(widget.discipline).toStringAsFixed(2)}/${AppGetValue.getTotal(widget.discipline) == 100 ? 100 : AppGetValue.getTotal(widget.discipline).toStringAsFixed(2)}"),
              MiniCard(
                  title:
                      "${AppGetValue.getMedia(widget.discipline) == 0.0 || AppGetValue.getMedia(widget.discipline).isNaN ? 0 : AppGetValue.getMedia(widget.discipline) == 1 ? 100 : AppGetValue.getMedia(widget.discipline).toStringAsFixed(2).substring(2)}%"),
              MiniCard(title: widget.discipline['Status']),
            ],
          ),
          SizedBox(
            height: 30,
          ),

          Text('Ações', style: AppTextStyles.descForm),
          SizedBox(
            height: 10,
          ),
           CarouselSlider.builder(
              itemCount: actions.length,
              itemBuilder: (context, index, pageViewIndex) => GestureDetector(onTap: () {
              },child: Container(
                width: 110,
                color: AppColors.white,
                child: Center(child: Text(actions[index])),
              ),),
              options: CarouselOptions(height: 35, viewportFraction: 0.35),
            ),

          SizedBox(
            height: 30,
          ),

          Text('Atividades', style: AppTextStyles.descForm),
          SizedBox(
            height: 10,
          ),
          Divider(
            height: 1,
            color: AppColors.black_pattern,
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: Stack(
              children: [
                widget.discipline['Atividades'].length == 0
                    ? Center(
                        child: Text(
                        "Sem Atividades",
                        style: AppTextStyles.emptyStyle,
                      ))
                    : SizedBox(
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: getLessons()
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
                                                          discipline: widget.discipline,
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
                                              AppGetValue.getMedia(widget.discipline) >= 0.6
                                                  ? widget.discipline
                                                      ['Status'] = 'aprovado'
                                                  : widget.discipline
                                                      ['Status'] = 'reprovado';
                                              widget.discipline
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
                                  child: ModalView(
                                    child: AddLessonModal(
                                      user: widget.user,
                                      disciplin: widget.discipline,
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
          SizedBox(
            height: 5,
          ),
          Divider(
            height: 1,
            color: AppColors.black_pattern,
          ),

          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
