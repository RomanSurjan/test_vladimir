

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_vladimir/blocs/auth_bloc/auth_bloc.dart';
import 'package:test_vladimir/blocs/auth_bloc/auth_state.dart';
import 'package:test_vladimir/blocs/my_bloc_observer.dart';
import 'package:test_vladimir/blocs/navbar_bloc/navbar_bloc.dart';
import 'package:test_vladimir/blocs/navbar_bloc/navbar_state.dart';
import 'package:test_vladimir/repositories/user_repository.dart';
import 'package:test_vladimir/screens/home.dart';
import 'package:test_vladimir/screens/sign_in/sing_in.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  final UserRepository userRepository = UserRepository();
  runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(create:(context)=> AuthBloc(userRepository: userRepository),),
          //BlocProvider(create: (context)=>SignInBloc(userRepository: userRepository)),
        ],

          child:  MyApp(userRepository:userRepository,)
      )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.userRepository});
  final UserRepository userRepository;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool check;
  List<String>? list = [];
  Future<List<String>?> getData() async{
   list  = await widget.userRepository.getData();
  }
  @override
  void initState() {
    super.initState();
    getData();

  }
  @override
  Widget build(BuildContext context) {
    check = list != null && list!.isNotEmpty;

    return  MaterialApp(
      home:  BlocBuilder<AuthBloc,AuthState>(
        builder:(context,state){

          return
             state is AuthDefeatState||state is AuthStartState&& !check
                 ? SingIn(userRepository: widget.userRepository,)
          : state is AuthSuccessState || check ?
             BlocProvider(
                  create: (_) => NavbarBloc(ShowFirstState()),
                 child:  HomePage(userRepository: widget.userRepository,)):
             Container();
        }

      ),
    );
  }
}


