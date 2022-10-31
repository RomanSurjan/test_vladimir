import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_vladimir/blocs/auth_bloc/auth_event.dart';
import 'package:test_vladimir/blocs/auth_bloc/auth_state.dart';
import 'package:test_vladimir/repositories/user_repository.dart';

class AuthBloc extends Bloc<AuthEvent,AuthState> {
  final UserRepository _userRepository;
  AuthBloc({required UserRepository userRepository}):
        _userRepository = userRepository,
        super(AuthStartState());




  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async*{
    if(event is AuthStartEvent){
      yield* _mapAuthStartEventToState();
      log('Success');
    }else if(event is AuthSignInEvent){
      yield* _mapAuthSignInEventToState();
    }else if(event is AuthSignOutEvent){
      yield* _mapAuthSignOutEventToState();
    }
  }

  Stream<AuthState> _mapAuthStartEventToState() async*{
    final isSignedIn = await _userRepository.isSignedIn();
    if(isSignedIn){
      final data = await _userRepository.getData();
      yield AuthSuccessState(data);
    }else{
      yield AuthDefeatState();
    }
  }

  Stream<AuthState> _mapAuthSignOutEventToState() async*{
    yield AuthDefeatState();
    _userRepository.singOut();
  }

  Stream<AuthState> _mapAuthSignInEventToState() async*{
    yield AuthSuccessState(await _userRepository.getData());
  }

}