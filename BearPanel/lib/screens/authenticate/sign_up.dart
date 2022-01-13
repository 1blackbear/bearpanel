import 'package:bearpanel/core/app_colors.dart';
import 'package:bearpanel/core/app_text_styles.dart';
import 'package:bearpanel/screens/authenticate/auth_screen.dart';
import 'package:bearpanel/screens/widgets/app_buttons.dart';
import 'package:bearpanel/screens/widgets/app_dialog.dart';
import 'package:bearpanel/screens/widgets/app_form.dart';
import 'package:bearpanel/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email = "", name = "", password = "", error = '', course = '';
  bool _showPassword = false, loading = false;
  int _periods = 0;
  final AuthService _auth = AuthService();
  final auth = FirebaseAuth.instance;
  //final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AuthScreen(widgets: [
      AuthCard(
        widgets: [
          Expanded(
            child: ListView(
              children: [
                const SizedBox(
                  height: 25,
                ),

                Text('Realizar cadastro', style: AppTextStyles.titleForm),
                const SizedBox(
                  height: 30,
                ),

                //Email Form
                Text('Email', style: AppTextStyles.descForm),
                CustomForm(
                  enabled: true,
                  hintText: 'Digite o seu email',
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                  keyboardType: TextInputType.emailAddress,
                  initialValue: '',
                ),
                const SizedBox(
                  height: 20,
                ),

                //Password form
                Text('Senha', style: AppTextStyles.descForm),
                TextFormField(
                  obscureText: !_showPassword,
                  validator: (val) => val!.isEmpty ? '' : null,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                      child: Icon(
                        _showPassword ? Icons.visibility : Icons.visibility_off,
                        color: AppColors.black_pattern_dark,
                      ),
                    ),
                    contentPadding: const EdgeInsets.only(top: 14.0, bottom: 8.0),
                    hintText: 'Digite sua senha',
                    hintStyle: TextStyle(
                      color: AppColors.password,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text('Confirmar Senha', style: AppTextStyles.descForm),
                TextFormField(
                  obscureText: !_showPassword,
                  validator: (val) => val!.isEmpty ? '' : null,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                      child: Icon(
                        _showPassword ? Icons.visibility : Icons.visibility_off,
                        color: AppColors.black_pattern_dark,
                      ),
                    ),
                    contentPadding: const EdgeInsets.only(top: 14.0, bottom: 8.0),
                    hintText: 'Repita sua senha',
                    hintStyle: TextStyle(
                      color: AppColors.password,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                //Name From
                Text('Nome', style: AppTextStyles.descForm),
                CustomForm(
                  enabled: true,
                  hintText: 'Digite o seu nome',
                  onChanged: (val) {
                    setState(() => name = val);
                  },
                  keyboardType: TextInputType.text,
                  initialValue: '',
                ),
                const SizedBox(
                  height: 35,
                ),

                Text('Nome do Curso', style: AppTextStyles.descForm),
                CustomForm(
                  enabled: true,
                  hintText: 'Digite o seu curso',
                  onChanged: (val) {
                    setState(() => course = val);
                  },
                  keyboardType: TextInputType.text,
                  initialValue: '',
                ),
                const SizedBox(
                  height: 35,
                ),

                Text('Períodos', style: AppTextStyles.descForm),
                CustomForm(
                  enabled: true,
                  hintText: 'Digite a quantidade de periodos',
                  onChanged: (val) {
                    setState(() => _periods = val as int);
                  },
                  keyboardType: TextInputType.number,
                  initialValue: '',
                ),
                const SizedBox(
                  height: 35,
                ),

                CustomButton(
                  title: 'Cadastrar',
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await _auth.registerWithEmailAndPassword(
                        email, password, name, course, _periods);
                    await _auth.signOut();
                    switch (result) {
                      case 1:
                        loading = false;
                        setState(() => error = 'Email em uso. Tente novamente');
                        break;
                      default:
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return ShowDialogUntil(
                                title_msg: 'Verifique seu email',
                                desc_msg:
                                'Um email para verificar sua senha foi enviado para $email.',
                              );
                            });
                        break;
                    }
                  },
                ),
                const SizedBox(
                  height: 35,
                ),

              ],
            ),
          ),
        ],
      )
    ]);
  }
}
