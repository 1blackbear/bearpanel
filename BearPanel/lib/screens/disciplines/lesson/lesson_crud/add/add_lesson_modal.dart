import 'package:bearpanel/core/app_colors.dart';
import 'package:bearpanel/core/app_text_styles.dart';
import 'package:bearpanel/models/user.dart';
import 'package:bearpanel/screens/widgets/app_buttons.dart';
import 'package:bearpanel/screens/widgets/app_form.dart';
import 'package:bearpanel/services/database.dart';
import 'package:flutter/material.dart';

//ignore: must_be_immutable
class AddLessonModal extends StatefulWidget {
  UserData user;
  dynamic discipline;
  AddLessonModal({Key? key, required this.user, required this.discipline})
      : super(key: key);

  @override
  _AddLessonModalState createState() => _AddLessonModalState();
}

class _AddLessonModalState extends State<AddLessonModal> {

  late List<String> disciplines;

  Map<String, dynamic> lesson_data = {
    'Titulo': '', //
    'Nota Atual': 0.0, //
    'Nota Total': 0.0, //
  };

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
              Text('Adicionar Atividade', style: AppTextStyles.titleForm),
              SizedBox(height: 30),

              Text('Título', style: AppTextStyles.descForm),
              CustomForm(
                enabled: true,
                hintText: 'Digite o título da atividade',
                onChanged: (val) {
                  setState(() => lesson_data['Titulo'] = val);
                },
                keyboardType: TextInputType.name,
                initialValue: '',
              ),
              SizedBox(height: 30),

              Text('Nota Recebida', style: AppTextStyles.descForm),
              CustomForm(
                enabled: true,
                hintText: 'Digite a sua nota atual',
                onChanged: (val) {
                  setState(() => lesson_data['Nota Atual'] = val);
                },
                keyboardType: TextInputType.number,
                initialValue: '',
              ),
              SizedBox(height: 30),

              Text('Nota total da atividade', style: AppTextStyles.descForm),
              CustomForm(
                enabled: true,
                hintText: 'Digite o total da atividade',
                onChanged: (val) {
                  setState(() => lesson_data['Nota Total'] = val);
                },
                keyboardType: TextInputType.number,
                initialValue: '',
              ),
              SizedBox(height: 50),

              CustomButton(
                  isEnabled: true,
                  title: 'Adicionar',
                  onPressed: () async {
                    Map<String, dynamic> new_lesson_data = {
                      'Titulo': lesson_data['Titulo'], //
                      'Nota Atual':
                          double.parse(lesson_data['Nota Atual'].toString()), //
                      'Nota Total':
                          double.parse(lesson_data['Nota Total'].toString()), //
                    };

                    widget.discipline['Atividades'].add(new_lesson_data);

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
