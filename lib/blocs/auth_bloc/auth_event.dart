import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable{
  @override
  List<Object?> get props =>[];

}


class AuthStartEvent extends AuthEvent{}

class AuthSignInEvent extends AuthEvent{}

class AuthSignOutEvent extends AuthEvent{}