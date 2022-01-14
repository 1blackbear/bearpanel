import 'package:bearpanel/core/app_colors.dart';
import 'package:bearpanel/core/app_text_styles.dart';
import 'package:bearpanel/models/user.dart';
import 'package:bearpanel/screens/widgets/app_buttons.dart';
import 'package:bearpanel/screens/widgets/app_form.dart';
import 'package:bearpanel/services/database.dart';
import 'package:flutter/material.dart';

class EditLessonModal extends StatefulWidget {
  UserData user;
  int index;
  int index_lesson;
  EditLessonModal({Key? key, required this.user, required this.index, required this.index_lesson})
      : super(key: key);

  @override
  _EditLessonModalState createState() => _EditLessonModalState();
}

class _EditLessonModalState extends State<EditLessonModal> {
  Map<String, dynamic> lesson_data = {
    'Titulo': '', //
    'Nota Atual': 0.0, //
    'Nota Total': 0.0, //
  };
  bool _edit_recive = false;
  bool _edit_title = false;
  bool _edit_total = false;
  double teste = 0.0;
  late List<String> disciplines;

  List<int> getList() {
    List<int>? list_period = [1];
    for (int i = 2; i <= widget.user.periods; i++) list_period.add(i);
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
              Text(
                'Editar Atividade',
                style: AppTextStyles.titleForm,
              ),
              SizedBox(
                height: 30,
              ),
              Text('Título', style: AppTextStyles.descForm),
              TextFormField(
                initialValue: widget.user.disciplines[widget.index]['Atividades'][widget.index_lesson]['Titulo'],                validator: (val) => val!.isEmpty ? '' : null,
                onChanged: (val) {
                  setState(() => lesson_data['Nota Atual'] = val);
                },
                readOnly: !_edit_title,
                keyboardType: TextInputType.name,
                enableInteractiveSelection: !_edit_title, // will disable paste operation
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
                      _edit_title ? Icons.edit_off: Icons.edit ,
                      color: AppColors.black_pattern_dark,
                    ),
                  ),
                  contentPadding: const EdgeInsets.only(top: 14.0, bottom: 8.0, left: 6),
                  hintText: 'Digite o título da atividade',
                  hintStyle: TextStyle(
                    color: AppColors.password,
                    fontSize: 14.0,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),

              Text('Nota Recebida', style: AppTextStyles.descForm),
              TextFormField(
                initialValue: widget.user.disciplines[widget.index]['Atividades'][widget.index_lesson]['Nota Atual'].toString(),
                validator: (val) => val!.isEmpty ? '' : null,
                onChanged: (val) {
                  setState(() => lesson_data['Nota Atual'] = val);
                },
                keyboardType: TextInputType.number,
                readOnly: !_edit_recive,
                enableInteractiveSelection: !_edit_recive, // will disable paste operation
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
                      _edit_recive ? Icons.edit_off: Icons.edit ,
                      color: AppColors.black_pattern_dark,
                    ),
                  ),
                  contentPadding: const EdgeInsets.only(top: 14.0, bottom: 8.0, left: 6),
                  hintText: 'Digite a sua nota atual',
                  hintStyle: TextStyle(
                    color: AppColors.password,
                    fontSize: 14.0,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text('Nota total da atividade', style: AppTextStyles.descForm),
              TextFormField(
                initialValue: widget.user.disciplines[widget.index]['Atividades'][widget.index_lesson]['Nota Total'].toString(),
                validator: (val) => val!.isEmpty ? '' : null,
                onChanged: (val) {
                  setState(() => lesson_data['Nota Total'] = val);
                },
                keyboardType: TextInputType.number,
                readOnly: !_edit_total,
                enableInteractiveSelection: !_edit_total, // will disable paste operation
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
                      _edit_total ? Icons.edit_off: Icons.edit ,
                      color: AppColors.black_pattern_dark,
                    ),
                  ),
                  contentPadding: const EdgeInsets.only(top: 14.0, bottom: 8.0, left: 6),
                  hintText: 'Digite o total da atividade',
                  hintStyle: TextStyle(
                    color: AppColors.password,
                    fontSize: 14.0,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              CustomButton(
                isEnabled: _edit_recive || _edit_title || _edit_total,
                  title: 'Atualizar',
                  onPressed: () async {
                    Map<String, dynamic> new_lesson_data = {
                      'Titulo': lesson_data['Titulo'], //
                      'Nota Atual':
                      double.parse(lesson_data['Nota Atual'].toString()), //
                      'Nota Total':
                      double.parse(lesson_data['Nota Total'].toString()), //
                    };

                    widget.user.disciplines[widget.index]['Atividades']
                        .add(new_lesson_data);

                    widget.user.disciplines[widget.index]['Nota Atual'] += new_lesson_data['Nota Atual'];
                    widget.user.disciplines[widget.index]['Nota Total'] += new_lesson_data['Nota Total'];

                    widget.user.disciplines[widget.index]['Nota Atual'] / widget.user.disciplines[widget.index]['Nota Total']  >= 0.6 ? widget.user.disciplines[widget.index]['Status'] = 'aprovado'
                        : widget.user.disciplines[widget.index]['Status'] = 'reprovado';

                    await DatabaseService(uid: widget.user.uid).updateUserData(
                        widget.user.name,
                        widget.user.disciplines,
                        widget.user.course_name,
                        widget.user.periods);
                    Navigator.pop(context);
                  })
            ],
          ),
        ),
      ),
    );
  }
}

