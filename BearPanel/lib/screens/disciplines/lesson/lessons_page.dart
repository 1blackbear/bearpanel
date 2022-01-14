import 'package:bearpanel/core/app_colors.dart';
import 'package:bearpanel/core/app_text_styles.dart';
import 'package:bearpanel/models/lesson.dart';
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
class DisciplinDetail extends StatefulWidget {
  UserData? user;
  int index;
  DisciplinDetail({Key? key, required this.user, required this.index})
      : super(key: key);

  @override
  _DisciplinDetailState createState() => _DisciplinDetailState();
}

class _DisciplinDetailState extends State<DisciplinDetail> {
  List<int> getList() {
    List<int>? list_period = [1];
    for (int i = 2; i <= widget.user!.periods; i++) list_period.add(i);
    return list_period;
  }

  List<Lesson>? getAtividades() {
    List<Lesson> list = [];
    Lesson les;
    widget.user!.disciplines[widget.index]['Atividades'].forEach((e) {
      les = new Lesson(
          title: e['Titulo'], current: e['Nota Atual'], total: e['Nota Total']);
      list.add(les);
    });
    return list;
  }


  double getTotal(){
    double total = 0.0;
    for(int i = 0; i < widget.user!.disciplines[widget.index]['Atividades'].length;i++)
      total += widget.user!.disciplines[widget.index]['Atividades'][i]['Nota Total'];
    return total;
  }

  double getAtual(){
    double atual = 0.0;
    for(int i = 0; i < widget.user!.disciplines[widget.index]['Atividades'].length;i++)
      atual += widget.user!.disciplines[widget.index]['Atividades'][i]['Nota Atual'];

    return atual;
  }

  double getMedia() {
    double media = 0.0;
    media = getAtual() / getTotal();
    media >= 0.6 ? widget.user!.disciplines[widget.index]['Status'] = 'aprovado'
        : widget.user!.disciplines[widget.index]['Status'] = 'reprovado';
    return media;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 65.0, left: 25, right: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.user!.disciplines[widget.index]['Nome'],
              style: AppTextStyles.titleDetailPage),
          SizedBox(
            height: 35,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MiniCard(
                  title:
                      "${getAtual() == 100 ? 100 : getAtual().toStringAsFixed(2)}/${getTotal() == 100 ? 100 : getTotal().toStringAsFixed(2)}"),
              MiniCard(
                  title:
                      "${getMedia() == 0.0 || getMedia().isNaN ? 0 : getMedia() == 1 ? 100 : (getAtual() / getTotal()).toStringAsFixed(2).substring(2)}%"),
              MiniCard(title: widget.user!.disciplines[widget.index]['Status']),
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
              value: widget.user!.disciplines[widget.index]['Período'],
              icon: const Icon(Icons.arrow_drop_down_outlined),
              underline: Container(
                height: 1,
                color: AppColors.black_pattern,
              ),
              onChanged: (int? newValue) {
                setState(() {
                  widget.user!.disciplines[widget.index]['Período'] = newValue!;
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
                widget.user!.disciplines[widget.index]['Atividades'].length == 0
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
                                                          index: widget.index,
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
                                                  ? widget.user!.disciplines[
                                                          widget.index]
                                                      ['Status'] = 'aprovado'
                                                  : widget.user!
                                                          .disciplines[widget.index]
                                                      ['Status'] = 'reprovado';
                                              widget
                                                  .user!
                                                  .disciplines[widget.index]
                                                      ['Atividades']
                                                  .removeAt(
                                                      getIndexList(item.title));
                                              await DatabaseService(
                                                      uid: widget.user!.uid)
                                                  .updateUserData(
                                                      widget.user!.name,
                                                      widget.user!.disciplines,
                                                      widget.user!.course_name,
                                                      widget.user!.periods);
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
                                      user: widget.user!,
                                      index: widget.index,
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
              value: widget.user!.disciplines[widget.index]['Finalizada?'],
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (value) {
                setState(() {
                  widget.user!.disciplines[widget.index]['Finalizada?'] =
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
                //widget.user.disciplines.add(disciplin_data);
                await DatabaseService(uid: widget.user!.uid).updateUserData(
                    widget.user!.name,
                    widget.user!.disciplines,
                    widget.user!.course_name,
                    widget.user!.periods);
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
      widget.user!.disciplines[widget.index]['Atividades'].forEach((e) {
        if (e['Titulo'] == current) throw "";
        index++;
      });
    } catch (e) {
      // leave it
    }
    return index;
  }
}
