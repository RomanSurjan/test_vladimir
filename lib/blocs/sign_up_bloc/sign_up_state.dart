

class SignUpState {
  final bool? isLoginEmpty;
  final bool? isPasswordEmpty;
  final bool? isNameEmpty;
  final bool? isSuccess;
  final bool? isDefeat;
  final bool? isLoading;

  SignUpState( {this.isNameEmpty,
    this.isLoginEmpty, this.isPasswordEmpty,this.isSuccess, this.isDefeat, this.isLoading,
  });


  bool get isSignInSuccess =>!isNameEmpty!&& !isLoginEmpty! && !isPasswordEmpty!;

  factory SignUpState.initializing() {
    return SignUpState(
      isLoginEmpty:false,
      isPasswordEmpty:false,
      isNameEmpty: false,
      isSuccess:false,
      isDefeat:false,
      isLoading: false,

    );
  }
  factory SignUpState.loading() {
    return SignUpState(
      isLoginEmpty:false,
      isPasswordEmpty:false,
      isNameEmpty: false,
      isSuccess:false,
      isDefeat:false,
      isLoading: true,

    );
  }

  factory SignUpState.success() {
    return SignUpState(
      isLoginEmpty:false,
      isPasswordEmpty:false,
      isNameEmpty: false,
      isSuccess:true,
      isDefeat:false,
      isLoading: false,

    );
  }
  factory SignUpState.defeat() {
    return SignUpState(
      isLoginEmpty:true,
      isPasswordEmpty:true,
      isNameEmpty: true,
      isSuccess:false,
      isDefeat:false,
      isLoading: false,

    );
  }

  SignUpState update({
    bool? isLoginEmpty,
    bool? isPasswordEmpty,
    bool? isNameEmpty,
  }) {
    return copyWith(
      isLoginEmpty: isLoginEmpty,
      isPasswordEmpty: isPasswordEmpty,
      isNameEmpty: isNameEmpty,
      isSuccess: false,
      isDefeat: false,
      isLoading: false,
    );
  }

  SignUpState copyWith({
    bool? isLoginEmpty,
    bool? isPasswordEmpty,
    bool? isSuccess,
    bool? isDefeat,
    bool? isLoading,
    bool? isNameEmpty,
  }) {
    return SignUpState(
      isLoginEmpty: isLoginEmpty,
      isPasswordEmpty: isPasswordEmpty,
      isNameEmpty: isNameEmpty,
      isSuccess: isSuccess,
      isDefeat: isDefeat,
      isLoading:isLoading,
    );
  }
}