import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_vladimir/blocs/auth_bloc/auth_bloc.dart';
import 'package:test_vladimir/blocs/auth_bloc/auth_event.dart';
import 'package:test_vladimir/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:test_vladimir/blocs/sign_up_bloc/sign_up_state.dart';


import '../../blocs/sign_up_bloc/sign_up_event.dart';
import '../../consts/colors.dart';
import '../../consts/fonts.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  SignUpFormState createState() => SignUpFormState();
}

class SignUpFormState extends State<SignUpForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late SignUpBloc signUpBloc;

  void onLoginChange(){
    signUpBloc.add(
        SignUpLoginEvent(login:loginController.text.isNotEmpty? loginController.text:'')
    );
  }

  void onPasswordChange(){
    signUpBloc.add(
        SignUpPasswordEvent(password: passwordController.text.isNotEmpty? passwordController.text:'')
    );
  }
  void onNameChange(){
    signUpBloc.add(
        SignUpNameEvent(name: nameController.text.isNotEmpty? nameController.text:'')
    );
  }

  void onSignInWithData(){
    signUpBloc.add(
        SignUpWithDataEvent(name:nameController.text ,login: loginController.text, password: passwordController.text, )
    );
  }


  @override
  void initState() {
    super.initState();
    signUpBloc = BlocProvider.of<SignUpBloc>(context);
    nameController.addListener(() {onNameChange(); });
    loginController.addListener(() {onLoginChange(); });
    passwordController.addListener(() {onPasswordChange(); });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc,SignUpState>(
      listener: (context, state) {
        if(state.isDefeat!){
          log('Defeat');
        }
        if(state.isSuccess!){
          log('Success');
          BlocProvider.of<AuthBloc>(context).add(
              AuthSignInEvent());
          Navigator.pop(context);
        }
        if(state.isLoading!){
          log('Loading ...');
        }
      },
      child: BlocBuilder<SignUpBloc,SignUpState>(
        builder: (context, state) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Header(),
                const Padding(padding: EdgeInsets.only(top: 20)),
                Container(
                  height: 0.07 * MediaQuery.of(context).size.height,
                  width: 0.9 * MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      color: fieldColor, borderRadius: BorderRadius.circular(8)),
                  alignment: Alignment.center,
                  child: TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.name,
                    controller: nameController,
                    style: const TextStyle(fontFamily: regular),
                    cursorColor: cursorColor,
                    autocorrect: false,
                    validator: (_){
                      return !state.isNameEmpty! ?null:'Bad name';
                    },
                    decoration: const InputDecoration(
                        hintText: 'Имя',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          fontFamily: regular,
                        )),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                Container(
                  height: 0.07 * MediaQuery.of(context).size.height,
                  width: 0.9 * MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      color: fieldColor, borderRadius: BorderRadius.circular(8)),
                  alignment: Alignment.center,
                  child: TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.emailAddress,
                    controller: loginController,
                    style: const TextStyle(fontFamily: regular),
                    cursorColor: cursorColor,
                    autocorrect: false,
                    validator: (_){
                      return !state.isLoginEmpty! ?null:'Bad login';
                    },
                    decoration:const InputDecoration(
                        hintText: 'Логин',
                        border: InputBorder.none,
                        hintStyle:  TextStyle(
                          fontFamily: regular,
                        )),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                Container(
                  height: 0.07 * MediaQuery.of(context).size.height,
                  width: 0.9 * MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      color: fieldColor, borderRadius: BorderRadius.circular(8)),
                  alignment: Alignment.center,
                  child: TextFormField(
                    controller: passwordController,
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.visiblePassword,
                    autocorrect: false,
                    validator: (_){
                      return state.isPasswordEmpty! ?null:'Bad password';
                    },
                    style: const TextStyle(fontFamily: regular),
                    cursorColor: cursorColor,
                    decoration:const InputDecoration(
                        hintText: 'Пароль',
                        border: InputBorder.none,
                        hintStyle:  TextStyle(
                          fontFamily: regular,
                        )),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                InkWell(
                    onTap: () {
                      onSignInWithData();
                    },
                    child: const GradientButton(label: 'Зарегестрироваться')),
                const Padding(padding: EdgeInsets.only(top: 20)),
                const Text(
                  'У вас уже есть аккаунт?',
                  style: TextStyle(fontFamily: medium, color: buttonTextColor),
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const GradientButton(label: 'Войти')),
              ],
            ),
          );
        }),
    );
  }
}



class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Зарегестрируйтесь!',
      style: TextStyle(
          fontFamily: bold,
          color: Colors.white,
          fontSize: 0.03 * MediaQuery.of(context).size.height),
    );
  }
}

class GradientButton extends StatelessWidget {
  const GradientButton({
    Key? key,
    required this.label,
  }) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.07 * MediaQuery.of(context).size.height,
      width: 0.5 * MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24), gradient: gradientButton),
      child: Text(
        label,
        style: const TextStyle(fontFamily: bold, color: buttonTextColor),
      ),
    );
  }
}
