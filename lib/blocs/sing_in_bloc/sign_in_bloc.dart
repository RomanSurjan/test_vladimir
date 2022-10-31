import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_vladimir/blocs/sing_in_bloc/sign_in_event.dart';
import 'package:test_vladimir/blocs/sing_in_bloc/sign_in_state.dart';
import 'package:test_vladimir/repositories/user_repository.dart';


class SignInBloc extends Bloc<SignInEvent,SignInState>{
  final UserRepository _userRepository;

  SignInBloc({required UserRepository userRepository})  :
        _userRepository = userRepository ,
        super(SignInState.initializing());

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async*{
    if(event is SignInLoginEvent){
      yield* _mapSignInLoginEventToState(event.login);
    }else if(event is SignInPasswordEvent){
      yield* _mapSignInPasswordEventToState(event.password);
    }else if(event is SignInWithDataEvent){
      yield* _mapSignInWithDataEventToState(login:event.login, password:event.password);
    }

  }
  Stream<SignInState> _mapSignInLoginEventToState(String login) async*{

     yield state.update(
         isLoginEmpty: false,
     );
  }
  Stream<SignInState> _mapSignInPasswordEventToState(String password) async*{

    yield state.update(
      isPasswordEmpty: false,
    );
  }

  Stream<SignInState> _mapSignInWithDataEventToState({required String login, required String password}) async*{
    yield SignInState.loading();
    try{
     await _userRepository.singIn(login, password);
     yield SignInState.success();
    }catch(_){
      yield SignInState.defeat();
    }
  }
}