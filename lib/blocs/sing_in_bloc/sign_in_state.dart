

class SignInState {
  final bool? isLoginEmpty;
  final bool? isPasswordEmpty;
  final bool? isSuccess;
  final bool? isDefeat;
  final bool? isLoading;

  SignInState({
    this.isLoginEmpty, this.isPasswordEmpty,this.isSuccess, this.isDefeat, this.isLoading,
  });


  bool get isSignInSuccess => !isLoginEmpty! && !isPasswordEmpty!;

  factory SignInState.initializing() {
    return SignInState(
      isLoginEmpty:false,
      isPasswordEmpty:false,
      isSuccess:false,
      isDefeat:false,
      isLoading: false,

    );
  }
  factory SignInState.loading() {
    return SignInState(
      isLoginEmpty:false,
      isPasswordEmpty:false,
      isSuccess:false,
      isDefeat:false,
      isLoading: true,

    );
  }

  factory SignInState.success() {
    return SignInState(
      isLoginEmpty:false,
      isPasswordEmpty:false,
      isSuccess:true,
      isDefeat:false,
      isLoading: false,

    );
  }
  factory SignInState.defeat() {
    return SignInState(
      isLoginEmpty:true,
      isPasswordEmpty:true,
      isSuccess:false,
      isDefeat:false,
      isLoading: false,

    );
  }

  SignInState update({
    bool? isLoginEmpty,
    bool? isPasswordEmpty,
  }) {
    return copyWith(
      isLoginEmpty: isLoginEmpty,
      isPasswordEmpty: isPasswordEmpty,
      isSuccess: false,
      isDefeat: false,
      isLoading: false,
    );
  }

  SignInState copyWith({
    bool? isLoginEmpty,
    bool? isPasswordEmpty,
    bool? isSuccess,
    bool? isDefeat,
    bool? isLoading,
  }) {
    return SignInState(
      isLoginEmpty: isLoginEmpty,
      isPasswordEmpty: isPasswordEmpty,
      isSuccess: isSuccess,
      isDefeat: isDefeat,
      isLoading:isLoading,
    );
  }
}