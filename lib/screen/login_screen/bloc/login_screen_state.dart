import 'package:rejolute/util/base_equatable.dart';

class LoginState extends BaseEquatable {}

class LoginInitialState extends LoginState {
  final String? error;
  LoginInitialState({this.error});
  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) => false;
  @override
  String toString() {
    return 'LoginInitialState';
  }
}

class LoginLoadingState extends LoginState {
  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) => false;
  @override
  String toString() {
    return "LoginLoadingState";
  }
}

class LoginPasswordVisibilityToggledState extends LoginState {
  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) => false;

  @override
  String toString() {
    return "LoginPasswordVisibilityToggledState";
  }
}

class LoginLoadState extends LoginState {
  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) => false;

  @override
  String toString() {
    return "LoginLoadState";
  }
}

class LoginSuccessState extends LoginState {
  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) => false;

  @override
  String toString() {
    return "LoginSuccessState";
  }
}

class LoginGoogleLoggedInState extends LoginState {
  @override
  String toString() {
    return "LoginGoogleLoggedInState";
  }
}
