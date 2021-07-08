import 'package:rejolute/util/base_equatable.dart';

class LoginEvent extends BaseEquatable {}

class LoginInitialEvent extends LoginEvent {
  @override
  String toString() {
    return "LoginInitialEvent";
  }
}

class LoginButtonPressedEvent extends LoginEvent {
  @override
  String toString() {
    return "LoginButtonPressedEvent";
  }
}

class LoginPasswordVisibilityToggleEvent extends LoginEvent {
  @override
  String toString() {
    return "LoginPasswordVisibilityToggleEvent";
  }
}

class LastUserLoginCredential extends LoginEvent {
  @override
  String toString() {
    return "LastUserLoginCredential";
  }
}
