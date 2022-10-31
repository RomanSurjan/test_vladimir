

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_vladimir/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:test_vladimir/consts/colors.dart';
import 'package:test_vladimir/repositories/user_repository.dart';
import 'package:test_vladimir/screens/sign_up/sign_up_form.dart';


class SingUp extends StatefulWidget {
  const SingUp({Key? key, required this.userRepository}) : super(key: key);
  final UserRepository userRepository;
  @override
  SingUpState createState() => SingUpState();
}

class SingUpState extends State<SingUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: false,
      body: BlocProvider<SignUpBloc>(
          create: (context) => SignUpBloc(userRepository: widget.userRepository),
          child:const  SignUpForm())
    );
  }
}

