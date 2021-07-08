import 'package:rejolute/util/base_equatable.dart';

class RegisterState extends BaseEquatable {}

class RegisterInitialState extends RegisterState {
  final String? error;
  RegisterInitialState({this.error});
  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) => false;
  @override
  String toString() {
    return 'RegisterInitialState';
  }
}

class RegisterLoadingState extends RegisterState {
  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) => false;
  @override
  String toString() {
    return "RegisterLoadingState";
  }
}

class RegisterPasswordVisibilityToggledState extends RegisterState {
  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) => false;

  @override
  String toString() {
    return "RegisterPasswordVisibilityToggledState";
  }
}

class RegisterLoadState extends RegisterState {
  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) => false;

  @override
  String toString() {
    return "RegisterLoadState";
  }
}

class RegisterSuccessState extends RegisterState {
  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) => false;

  @override
  String toString() {
    return "RegisterSuccessState";
  }
}

class RegisterGoogleLoggedInState extends RegisterState {
  @override
  String toString() {
    return "RegisterGoogleLoggedInState";
  }
}
