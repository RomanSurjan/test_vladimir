import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable{

  @override
  List<Object?> get props => [];

}

class SignUpLoginEvent extends SignUpEvent{
  final String login;

  SignUpLoginEvent({required this.login});

  @override
  List<Object?> get props => [login];

}

class SignUpPasswordEvent extends SignUpEvent{
  final String password;
  SignUpPasswordEvent({required this.password});

  @override
  List<Object?> get props => [password];
}

class SignUpNameEvent extends SignUpEvent{
  final String name;
  SignUpNameEvent({required this.name});

  @override
  List<Object?> get props => [name];
}


class SignUpWithDataEvent extends SignUpEvent{
  final String name;
  final String login;
  final String password;
  SignUpWithDataEvent( {required this.name,required this.login,required this.password});

  @override
  List<Object?> get props => [name, login, password];
}

