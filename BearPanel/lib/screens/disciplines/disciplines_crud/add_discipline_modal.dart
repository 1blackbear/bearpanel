import 'package:bearpanel/core/app_colors.dart';
import 'package:bearpanel/core/app_navigator.dart';
import 'package:bearpanel/core/app_routes.dart';
import 'package:bearpanel/core/app_text_styles.dart';
import 'package:bearpanel/models/user.dart';
import 'package:bearpanel/screens/disciplines/lesson/lesson_data_struct.dart';
import 'package:bearpanel/screens/widgets/app_buttons.dart';
import 'package:bearpanel/screens/widgets/app_form.dart';
import 'package:bearpanel/services/auth.dart';
import 'package:bearpanel/services/database.dart';
import 'package:flutter/material.dart';

//ignore: must_be_immutable
class AddDisciplineModal extends StatefulWidget {
  UserData user;
  AuthService auth;
  AddDisciplineModal({Key? key, required this.user, required this.auth}) : super(key: key);

  @override
  _AddDisciplineModalState createState() => _AddDisciplineModalState();
}

class _AddDisciplineModalState extends State<AddDisciplineModal> {
  Map<String, dynamic> disciplin_data = {
    'Nome': '', //
    'Período': 1, //
    'Finalizada?': false, //
    'Atividades': [],
  };
  late List<String> disciplines;

  @override
  Widget build(BuildContext context) {
    LessonsData lessons_data = LessonsData.onlyUser(user: widget.user);
    return Container(
      width: double.infinity,
      height: 450,
      color: AppColors.background,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Material(
          color: AppColors.background,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Adicionar Disciplina', style: AppTextStyles.titleForm),
              SizedBox(height: 30),

              Text('Nome', style: AppTextStyles.descForm),
              CustomForm(
                enabled: true,
                hintText: 'Digite o nome da disciplina',
                onChanged: (val) {
                  setState(() => disciplin_data['Nome'] = val);
                },
                keyboardType: TextInputType.name,
                initialValue: '',
              ),
              SizedBox(height: 30),

              Text('Período', style: AppTextStyles.descForm),
              Container(
                width: double.infinity,
                child: DropdownButton<int>(
                  isExpanded: true,
                  value: disciplin_data['Período'],
                  icon: const Icon(Icons.arrow_drop_down_outlined),
                  underline: Container(
                    height: 1,
                    color: AppColors.black_pattern,
                  ),
                  onChanged: (int? newValue) {
                    setState(() {
                      disciplin_data['Período'] = newValue!;
                    });
                  },
                  items: lessons_data.getList().map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 30),

              CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text('Disciplina finalizada?',
                      style: AppTextStyles.descForm),
                  activeColor: AppColors.black_pattern,
                  value: disciplin_data['Finalizada?'],
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (value) {
                    setState(() {
                      disciplin_data['Finalizada?'] = value!;
                    });
                  }),
              SizedBox(height: 30),

              CustomButton(
                  title: 'Adicionar',
                  isEnabled: true,
                  onPressed: () async {
                    widget.user.disciplines.add(disciplin_data);
                    await DatabaseService(uid: widget.user.uid).updateUserData(
                        widget.user.name,
                        widget.user.disciplines,
                        widget.user.course_name,
                        widget.user.periods);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AppRoutes(
                                  spin_animation: true,
                              userData: widget.user,
                              auth: widget.auth,
                                )));
                  })
            ],
          ),
        ),
      ),
    );
  }
}