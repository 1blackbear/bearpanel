import 'package:bearpanel/core/app_text_styles.dart';
import 'package:bearpanel/screens/authenticate/auth_screen.dart';
import 'package:bearpanel/screens/authenticate/sign_up.dart';
import 'package:bearpanel/screens/widgets/app_buttons.dart';
import 'package:bearpanel/screens/widgets/app_dialog.dart';
import 'package:bearpanel/screens/widgets/app_form.dart';
import 'package:bearpanel/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'forgot_pass.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email = "",  password = "", error = '';
  bool _showPassword = false, loading = false;
  final AuthService _auth = AuthService();
  final auth = FirebaseAuth.instance;
  //final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AuthScreen(widgets: [
      AuthCard(
        widgets: [
          const SizedBox(
            height: 25,
          ),

          Text('Fazer Log-in', style: AppTextStyles.titleForm),
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

          //Password Form
          Text('Senha', style: AppTextStyles.descForm),
          TextFormField(
            obscureText: !_showPassword,
            validator: (val) => val!.isEmpty ? '' : null,
            onChanged: (val) {
              setState(() => password = val);
            },
            decoration: InputDecoration(
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF525151),
                  width: 2.0,
                ),
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _showPassword = !_showPassword;
                  });
                },
                child: Icon(
                  _showPassword ? Icons.visibility : Icons.visibility_off,
                  color: const Color(0xFF4e4e4e),
                ),
              ),
              contentPadding: const EdgeInsets.only(top: 14.0, bottom: 8.0),
              hintText: 'Digite sua senha',
              hintStyle: TextStyle(
                color: Colors.black.withOpacity(0.4),
                fontSize: 14.0,
              ),
            ),
          ),

          //Esqueci minha senha
          Container(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ForgotPassword()),
                );
              },
              style: TextButton.styleFrom(padding: EdgeInsets.only(right: 0.0)),
              child: Text('Esqueceu a senha?', style: AppTextStyles.miniForm),
            ),
          ),
          const SizedBox(
            height: 23,
          ),

          //Botão Login
          CustomButton(
            title: 'Login',
            onPressed: () async {
              setState(() {
                loading = true;
              });

              dynamic result =
                  await _auth.signInWithEmailAndPassword(email, password);
              switch (result) {
                case 1:
                  loading = false;
                  setState(() => error = 'Email ou senha incorretos');
                  break;
                case 2:
                  loading = false;
                  _auth.signOut();
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return ShowDialog(
                          title_msg: 'Verifique seu email',
                          desc_msg:
                              'Por favor, verifique o seu email para continuar.',
                        );
                      });
                  break;
                default:
                  loading = true;
                  break;
              }
            },
          ),
          const SizedBox(
            height: 5,
          ),

          //Não possui conta
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Não possui uma conta? ',
                style: AppTextStyles.mediumForm,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUp()));
                },
                style:
                    TextButton.styleFrom(padding: EdgeInsets.only(right: 0.0)),
                child: Text('Cadastre-se!', style: AppTextStyles.linkForm),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),

          //Ou faça login com
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 1,
                width: 85,
                color: Color(0xFF525151),
              ),
              Text('     Ou faça log-in com     ',
                  style: AppTextStyles.miniForm),
              Container(
                height: 1,
                width: 85,
                color: Color(0xFF525151),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),

          //Facebook e google
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Facebook
              GestureDetector(
                  onTap: () {
                    _auth.signInWithFacebook();
                  },
                  child: const Icon(
                    Icons.facebook_rounded,
                    color: Color(0xFF707070),
                    size: 50,
                  )),
              const SizedBox(
                width: 30,
              ),

              //Google
              GestureDetector(
                onTap: () {
                  _auth.signInWithGoogle();
                },
                child: Container(
                  width: 43,
                  height: 43,
                  decoration: const BoxDecoration(
                    color: Color(0xFF707070),
                    shape: BoxShape.circle,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "G",
                        style: AppTextStyles.googleBtn,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      )
    ]);
  }
}
