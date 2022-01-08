import 'package:bearpanel/core/app_text_styles.dart';
import 'package:bearpanel/screens/authenticate/sign_up.dart';
import 'package:bearpanel/screens/widgets/app_bar_login.dart';
import 'package:bearpanel/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'forgot_pass.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email = "", name = "";
  String password = "", error = '';
  bool _showPassword = false;
  final AuthService _auth = AuthService();
  final auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Color(0xFF707070),
        body: SingleChildScrollView(
          child: Column(children: [
            AppBarLoginWidget(),
            Container(
                height: MediaQuery.of(context).size.height / 1.4516,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF4e4e4e),
                        spreadRadius: 0,
                        blurRadius: 55,
                        offset: Offset(0, -16), // changes position of shadow
                      ),
                    ],
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0),
                    )),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        Text('Realizar cadastro',
                            style: AppTextStyles.titleForm),
                        const SizedBox(
                          height: 30,
                        ),
                        Text('Email', style: AppTextStyles.descForm),
                        TextFormField(
                          //form field name
                          cursorColor: Color(0xFF707070),
                          decoration: InputDecoration(
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF525151),
                                width: 2.0,
                              ),
                            ),
                            contentPadding: EdgeInsets.only(top: 8, bottom: 8),
                            hintText: 'Digite o seu email',
                            hintStyle: TextStyle(
                              color: Colors.black.withOpacity(0.4),
                              fontSize: 14.0,
                            ),
                          ),
                          onChanged: (val) {
                            setState(() => email = val);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
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
                                _showPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: const Color(0xFF4e4e4e),
                              ),
                            ),
                            contentPadding:
                                const EdgeInsets.only(top: 14.0, bottom: 8.0),
                            hintText: 'Digite sua senha',
                            hintStyle: TextStyle(
                              color: Colors.black.withOpacity(0.4),
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
                                _showPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: const Color(0xFF4e4e4e),
                              ),
                            ),
                            contentPadding:
                                const EdgeInsets.only(top: 14.0, bottom: 8.0),
                            hintText: 'Repita sua senha',
                            hintStyle: TextStyle(
                              color: Colors.black.withOpacity(0.4),
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text('Nome', style: AppTextStyles.descForm),
                        TextFormField(
                          //form field name
                          cursorColor: Color(0xFF707070),
                          decoration: InputDecoration(
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF525151),
                                width: 2.0,
                              ),
                            ),
                            contentPadding: EdgeInsets.only(top: 8, bottom: 8),
                            hintText: 'Digite o seu nome',
                            hintStyle: TextStyle(
                              color: Colors.black.withOpacity(0.4),
                              fontSize: 14.0,
                            ),
                          ),
                          onChanged: (val) {
                            setState(() => name = val);
                          },
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                loading = true;
                              });
                              dynamic result =
                                  await _auth.registerWithEmailAndPassword(
                                      email, password, name);
                              await _auth.signOut();
                              switch (result) {
                                case 1:
                                  loading = false;
                                  setState(() =>
                                      error = 'Email em uso. Tente novamente');
                                  break;
                                default:
                                  _showDialog();
                                  break;
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 5,
                              primary: const Color(0xFF707070),
                              padding: const EdgeInsets.all(15.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                            child: Text(
                              'Cadastrar',
                              style: AppTextStyles.btnLogin,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                )),
          ]),
        ),
      ),
    );
  }

  void _showDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Verifique seu email'),
          content: Text(
              'Um email para verificar sua senha foi enviado para $email.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: Text(
                'Voltar',
                style: TextStyle(
                  color: Color(0xFF707070),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
