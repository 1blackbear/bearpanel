import 'package:bearpanel/core/app_colors.dart';
import 'package:bearpanel/core/app_navigator.dart';
import 'package:bearpanel/core/app_text_styles.dart';
import 'package:bearpanel/models/user.dart';
import 'package:bearpanel/screens/widgets/app_buttons.dart';
import 'package:bearpanel/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//ignore: must_be_immutable
class EditLessonModal extends StatefulWidget {
  UserData? user;
  dynamic discipline;
  int index_lesson;
  EditLessonModal({
    Key? key,
    required this.user,
    required this.discipline,
    required this.index_lesson,
  }) : super(key: key);

  @override
  _EditLessonModalState createState() => _EditLessonModalState();
}

class _EditLessonModalState extends State<EditLessonModal> {
  bool _edit_recive = false;
  bool _edit_title = false;
  bool _edit_total = false;
  late List<String> disciplines;

  List<int> getList() {
    List<int>? list_period = [1];
    for (int i = 2; i <= widget.user!.periods; i++) list_period.add(i);
    return list_period;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 480,
      color: AppColors.background,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Material(
          color: AppColors.background,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Editar Atividade', style: AppTextStyles.titleForm),
              SizedBox(height: 30),

              //Título da Atividade
              Text('Título', style: AppTextStyles.descForm),
              TextFormField(
                initialValue: widget.discipline['Atividades']
                    [widget.index_lesson]['Titulo'],
                validator: (val) => val!.isEmpty ? '' : null,
                onChanged: (val) {
                  setState(() => widget.discipline['Atividades']
                      [widget.index_lesson]['Titulo'] = val);
                },
                readOnly: !_edit_title,
                keyboardType: TextInputType.name,
                enableInteractiveSelection:
                    !_edit_title, // will disable paste operation
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.black_pattern,
                      width: 1.0,
                    ),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _edit_title = !_edit_title;
                      });
                    },
                    child: Icon(
                      _edit_title ? Icons.edit_off : Icons.edit,
                      color: AppColors.black_pattern_dark,
                    ),
                  ),
                  contentPadding:
                      const EdgeInsets.only(top: 14.0, bottom: 8.0, left: 6),
                  hintText: 'Digite o título da atividade',
                  hintStyle: TextStyle(
                    color: AppColors.password,
                    fontSize: 14.0,
                  ),
                ),
              ),
              SizedBox(height: 30),

              //Nota Recebida
              Text('Nota Recebida', style: AppTextStyles.descForm),
              TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'[,]')),
                ],
                initialValue: widget.discipline['Atividades']
                        [widget.index_lesson]['Nota Atual']
                    .toString(),
                validator: (val) => val!.isEmpty ? '' : null,
                onChanged: (val) {
                  setState(() {
                    if (val == "") {
                      widget.discipline['Atividades'][widget.index_lesson]
                          ['Nota Atual'] = 0.0;
                    } else {
                      widget.discipline['Atividades'][widget.index_lesson]
                          ['Nota Atual'] = double.parse(val);
                    }
                  });
                },
                keyboardType: TextInputType.number,
                readOnly: !_edit_recive,
                enableInteractiveSelection:
                    !_edit_recive, // will disable paste operation
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.black_pattern,
                      width: 1.0,
                    ),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _edit_recive = !_edit_recive;
                      });
                    },
                    child: Icon(
                      _edit_recive ? Icons.edit_off : Icons.edit,
                      color: AppColors.black_pattern_dark,
                    ),
                  ),
                  contentPadding:
                      const EdgeInsets.only(top: 14.0, bottom: 8.0, left: 6),
                  hintText: 'Digite a sua nota atual',
                  hintStyle: TextStyle(
                    color: AppColors.password,
                    fontSize: 14.0,
                  ),
                ),
              ),
              SizedBox(height: 30),

              //Nota Total
              Text('Nota total da atividade', style: AppTextStyles.descForm),
              TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'[,]')),
                ],
                initialValue: widget.discipline['Atividades']
                        [widget.index_lesson]['Nota Total']
                    .toString(),
                validator: (val) => val!.isEmpty ? '' : null,
                onChanged: (val) {
                  setState(() {
                    if (val == "") {
                      widget.discipline['Atividades'][widget.index_lesson]
                          ['Nota Total'] = 0.0;
                    } else {
                      widget.discipline['Atividades'][widget.index_lesson]
                          ['Nota Total'] = double.parse(val);
                    }
                  });
                },
                keyboardType: TextInputType.number,
                readOnly: !_edit_total,
                enableInteractiveSelection:
                    !_edit_total, // will disable paste operation
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.black_pattern,
                      width: 1.0,
                    ),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _edit_total = !_edit_total;
                      });
                    },
                    child: Icon(
                      _edit_total ? Icons.edit_off : Icons.edit,
                      color: AppColors.black_pattern_dark,
                    ),
                  ),
                  contentPadding:
                      const EdgeInsets.only(top: 14.0, bottom: 8.0, left: 6),
                  hintText: 'Digite o total da atividade',
                  hintStyle: TextStyle(
                    color: AppColors.password,
                    fontSize: 14.0,
                  ),
                ),
              ),
              SizedBox(height: 50),

              //Atualizar
              CustomButton(
                  isEnabled: _edit_recive || _edit_title || _edit_total,
                  title: 'Atualizar',
                  onPressed: () async {
                    await DatabaseService(uid: widget.user!.uid)
                        .updateUserData(
                            widget.user!.name,
                            widget.user!.disciplines,
                            widget.user!.course_name,
                            widget.user!.periods)
                        .then((e) => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NavigatorBase(
                                      spin_animation: true,
                                    ))));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
