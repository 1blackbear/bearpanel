import 'package:bearpanel/core/app_colors.dart';
import 'package:bearpanel/core/app_navigator.dart';
import 'package:bearpanel/core/app_text_styles.dart';
import 'package:bearpanel/core/app_data_value.dart';
import 'package:bearpanel/models/user.dart';
import 'package:bearpanel/screens/disciplines/disciplines_crud/edit_discipline_modal.dart';
import 'package:bearpanel/screens/widgets/app_cards.dart';
import 'package:bearpanel/screens/widgets/app_modal.dart';
import 'package:bearpanel/services/auth.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'lesson_crud/retrieve_lesson_widget.dart';

//ignore: must_be_immutable
class LessonsPage extends StatefulWidget {
  UserData user;
  dynamic discipline;
  Widget return_page;
  AuthService auth;
  LessonsPage(
      {Key? key,
      required this.discipline,
      required this.user,
      required this.return_page,
      required this.auth})
      : super(key: key);

  @override
  _LessonsPageState createState() => _LessonsPageState();
}

class _LessonsPageState extends State<LessonsPage> {
  List<String> actions = ['Editar', 'Voltar', 'Atualizar'];

  @override
  Widget build(BuildContext context) {
    return !AppNavigator.activate_detail
        ? widget.return_page
        : Padding(
            padding: const EdgeInsets.only(top: 65.0, left: 25, right: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.discipline['Nome'], style: AppTextStyles.titleDetailPage),
                SizedBox(height: 35),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MiniCard(
                        title:
                            "${AppGetValue.getAtual(widget.discipline) == 100 ? 100 : AppGetValue.getAtual(widget.discipline).toStringAsFixed(2)}/${AppGetValue.getTotal(widget.discipline) == 100 ? 100 : AppGetValue.getTotal(widget.discipline).toStringAsFixed(2)}"),
                    MiniCard(
                        title:
                            "${AppGetValue.getPercentTitle(AppGetValue.getMedia(widget.discipline))}%"),
                    MiniCard(title: AppGetValue.getStatus(widget.discipline)),
                  ],
                ),
                SizedBox(height: 30),

                Text('Ações', style: AppTextStyles.descForm),
                SizedBox(height: 10),
                CarouselSlider.builder(
                  itemCount: actions.length,
                  itemBuilder: (context, index, pageViewIndex) =>
                      GestureDetector(
                    onTap: () {
                      switch (index) {
                        case 0:
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
                                      child: EditDisciplineModal(auth: widget.auth,discipline: widget.discipline, user: widget.user),
                                      top: 150,
                                      bottom: 120,
                                    ),
                                  ),
                                );
                              },
                              pageBuilder: (context, animation1, animation2) {
                                throw ("");
                              });
                          break;
                        case 1:
                          setState(() {
                            AppNavigator.uid = '';
                            AppNavigator.activate_detail = false;
                          });
                          break;
                        case 2:
                          break;
                      }
                      ;
                    },
                    child: Container(
                      width: 110,
                      color: AppColors.white,
                      child: Center(child: Text(actions[index])),
                    ),
                  ),
                  options: CarouselOptions(height: 35, viewportFraction: 0.35),
                ),
                SizedBox(height: 30),

                Text('Atividades', style: AppTextStyles.descForm),
                SizedBox(height: 10),

                Divider(height: 1, color: AppColors.black_pattern),
                SizedBox(height: 5),
                RetrieveLesson(user: widget.user, discipline: widget.discipline, auth: widget.auth),
                SizedBox(height: 5),
                Divider(height: 1, color: AppColors.black_pattern),

                SizedBox(height: 30),
              ],
            ),
          );
  }
}