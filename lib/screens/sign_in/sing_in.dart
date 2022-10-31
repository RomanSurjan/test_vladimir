

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_vladimir/blocs/sing_in_bloc/sign_in_bloc.dart';
import 'package:test_vladimir/consts/colors.dart';
import 'package:test_vladimir/repositories/user_repository.dart';
import 'package:test_vladimir/screens/sign_in/sign_in_form.dart';



class SingIn extends StatefulWidget {
  const SingIn({Key? key, required this.userRepository,}) : super(key: key);

  final UserRepository userRepository;


  @override
  SingInState createState() => SingInState();
}

class SingInState extends State<SingIn> {




  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: false,
      body: BlocProvider<SignInBloc>(
        create: (context) => SignInBloc(userRepository: widget.userRepository),
        child: SignInForm(userRepository: widget.userRepository,)
          ),
      );
  }
}




