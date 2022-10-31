import 'package:equatable/equatable.dart';

abstract class SignInEvent extends Equatable{

  @override
  List<Object?> get props => [];

}

class SignInLoginEvent extends SignInEvent{
  final String login;

  SignInLoginEvent({required this.login});

  @override
  List<Object?> get props => [login];

}

class SignInPasswordEvent extends SignInEvent{
  final String password;
  SignInPasswordEvent({required this.password});

  @override
  List<Object?> get props => [password];
}


class SignInWithDataEvent extends SignInEvent{
  final String login;
  final String password;
  SignInWithDataEvent({required this.login,required this.password});

  @override
  List<Object?> get props => [login, password];
}

