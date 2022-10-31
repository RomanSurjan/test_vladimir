import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_vladimir/blocs/sign_up_bloc/sign_up_event.dart';
import 'package:test_vladimir/blocs/sign_up_bloc/sign_up_state.dart';
import 'package:test_vladimir/repositories/user_repository.dart';


class SignUpBloc extends Bloc<SignUpEvent,SignUpState>{
  final UserRepository _userRepository;

  SignUpBloc({required UserRepository userRepository})  :
        _userRepository = userRepository ,
        super(SignUpState.initializing());

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async*{
    if(event is SignUpNameEvent){
      _mapSignUpNameEventToState(event.name);
    }else if(event is SignUpLoginEvent){
      yield* _mapSignUpLoginEventToState(event.login);
    }else if(event is SignUpPasswordEvent){
      yield* _mapSignUpPasswordEventToState(event.password);
    }else if(event is SignUpWithDataEvent){
      yield* _mapSignUpWithDataEventToState(name:event.name ,login:event.login, password:event.password);
    }

  }
  Stream<SignUpState> _mapSignUpNameEventToState(String name) async*{

    yield state.update(
      isNameEmpty: false,
    );
  }

  Stream<SignUpState> _mapSignUpLoginEventToState(String login) async*{

    yield state.update(
      isLoginEmpty: false,
    );
  }
  Stream<SignUpState> _mapSignUpPasswordEventToState(String password) async*{

    yield state.update(
      isPasswordEmpty: false,
    );
  }

  Stream<SignUpState> _mapSignUpWithDataEventToState({required String name,required String login, required String password}) async*{
    yield SignUpState.loading();
    try{
      await _userRepository.singUp(name, login, password);
      yield SignUpState.success();
    }catch(_){
      yield SignUpState.defeat();
    }
  }
}