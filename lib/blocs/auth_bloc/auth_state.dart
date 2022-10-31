import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable{
  const AuthState();
  @override
  List<Object?> get props => [];

}


class AuthStartState extends AuthState{}

class AuthSuccessState extends AuthState{
  final List<String>? data;
  const AuthSuccessState(this.data);
  @override
  List<Object?> get props => [data];
}

class AuthDefeatState extends AuthState{}