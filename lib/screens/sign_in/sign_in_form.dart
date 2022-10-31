import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_vladimir/blocs/auth_bloc/auth_bloc.dart';
import 'package:test_vladimir/blocs/auth_bloc/auth_event.dart';
import 'package:test_vladimir/blocs/sing_in_bloc/sign_in_bloc.dart';
import 'package:test_vladimir/blocs/sing_in_bloc/sign_in_state.dart';
import 'package:test_vladimir/repositories/user_repository.dart';
import 'package:test_vladimir/screens/sign_up/sing_up.dart';

import '../../blocs/sing_in_bloc/sign_in_event.dart';
import '../../consts/colors.dart';
import '../../consts/fonts.dart';


class SignInForm extends StatefulWidget {
  const SignInForm({Key? key, required this.userRepository}) : super(key: key);
  final UserRepository userRepository;
  @override
  SignInFormState createState() => SignInFormState();
}

class SignInFormState extends State<SignInForm> {


  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late final SignInBloc loginBloc;

  void onLoginChange(){
    loginBloc.add(
        SignInLoginEvent(login:loginController.text)
    );
  }

  void onPasswordChange(){
    loginBloc.add(
        SignInPasswordEvent(password:passwordController.text)
    );
  }

  void onSignInWithData(){
    loginBloc.add(
        SignInWithDataEvent(login: loginController.text, password: passwordController.text)
    );
  }

  @override
  void initState() {

    super.initState();
    loginBloc = BlocProvider.of<SignInBloc>(context);
    loginController.addListener(() {onLoginChange();});
    passwordController.addListener(() {onPasswordChange();});
  }



  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: BlocListener<SignInBloc,SignInState>(
        listener: (context, state) {
          if(state.isDefeat!){
            log('Defeat');
          }
          if(state.isSuccess!){
            BlocProvider.of<AuthBloc>(context).add(AuthSignInEvent());
          }
          if(state.isLoading!){
            log('Loading ...');
          }
        },
        child: BlocBuilder<SignInBloc,SignInState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Header(),
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  Container(
                    height: 0.07*MediaQuery.of(context).size.height,
                    width: 0.9*MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        color: fieldColor,
                        borderRadius: BorderRadius.circular(8)
                    ),
                    alignment: Alignment.center,
                    child: TextFormField(
                      controller: loginController,
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      validator: (_){
                        return state.isLoginEmpty!?'Bad email':null;
                      },
                      style:const TextStyle(
                          fontFamily: regular
                      ),
                      cursorColor: cursorColor,
                      decoration: const InputDecoration(
                          hintText: 'Логин',
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontFamily: regular,
                          )
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  Container(
                    height: 0.07*MediaQuery.of(context).size.height,
                    width: 0.9*MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        color: fieldColor,
                        borderRadius: BorderRadius.circular(8)
                    ),
                    alignment: Alignment.center,
                    child: TextFormField(
                      controller: passwordController,
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.visiblePassword,
                      style:const TextStyle(
                          fontFamily: regular
                      ),
                      cursorColor: cursorColor,
                      autocorrect: false,
                      validator: (_){
                        return state.isPasswordEmpty!?'Bad password':null;
                      },
                      decoration: const InputDecoration(
                          hintText: 'Пароль',
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontFamily: regular,
                          )
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  InkWell(
                      onTap: (){
                        onSignInWithData();
                      },
                      child: const GradientButton(label: 'Войти', )
                  ),
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  const Text(
                    'У вас ещё нет аккаунта?',
                    style: TextStyle(
                        fontFamily: medium,
                        color: buttonTextColor
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return SingUp(userRepository: widget.userRepository,);
                      }));
                    },
                    child: const GradientButton(
                      label: 'Зарегестрироваться',
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Войдите!',
      style: TextStyle(
          fontFamily: bold,
          color: Colors.white,
          fontSize: 0.03*MediaQuery.of(context).size.height
      ),
    );
  }
}

class GradientButton extends StatelessWidget {
  const GradientButton({Key? key, required this.label}) : super(key: key);
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.07*MediaQuery.of(context).size.height,
      width: 0.5*MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: gradientButton
      ),
      child:  Text(
        label,
        style: const TextStyle(
            fontFamily: bold,
            color: buttonTextColor
        ),
      ),
    );
  }

}

