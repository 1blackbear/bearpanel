import 'package:bearpanel/core/app_colors.dart';
import 'package:bearpanel/core/app_text_styles.dart';
import 'package:bearpanel/models/user.dart';
import 'package:bearpanel/screens/widgets/app_buttons.dart';
import 'package:bearpanel/screens/widgets/app_form.dart';
import 'package:bearpanel/services/database.dart';
import 'package:flutter/material.dart';

class AddLessonModal extends StatefulWidget {
  UserData user;
  int index;
  AddLessonModal({Key? key, required this.user, required this.index}) : super(key: key);

  @override
  _AddLessonModalState createState() => _AddLessonModalState();
}

class _AddLessonModalState extends State<AddLessonModal> {
  Map<String, dynamic> lesson_data = {
    'Titulo': '',//
    'Nota Atual': 1,//
    'Nota Total': 1, //
  };
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
      height: MediaQuery.of(context).size.height - 170,
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
                'Adicionar Atividade',
                style: AppTextStyles.titleForm,
              ),
              SizedBox(
                height: 30,
              ),

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
              SizedBox(
                height: 30,
              ),

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
              SizedBox(
                height: 30,
              ),

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

              SizedBox(
                height: 180,
              ),

              CustomButton(title: 'Adicionar',
                  onPressed: () async {
                    widget.user.disciplines[widget.index]['Atividades'].add(lesson_data);
                    await DatabaseService(uid: widget.user.uid).updateUserData(
                        widget.user.name,
                        widget.user.disciplines,
                        widget.user.course_name,
                        widget.user.periods
                    );
                    Navigator.pop(context);
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
