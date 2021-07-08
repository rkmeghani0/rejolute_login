import 'package:rejolute/util/base_equatable.dart';

class RegisterEvent extends BaseEquatable {}

class RegisterInitialEvent extends RegisterEvent {
  @override
  String toString() {
    return "RegisterInitialEvent";
  }
}

class RegisterButtonPressedEvent extends RegisterEvent {
  @override
  String toString() {
    return "RegisterButtonPressedEvent";
  }
}

class RegisterPasswordVisibilityToggleEvent extends RegisterEvent {
  @override
  String toString() {
    return "RegisterPasswordVisibilityToggleEvent";
  }
}

class LastUserRegisterCredential extends RegisterEvent {
  @override
  String toString() {
    return "LastUserRegisterCredential";
  }
}
