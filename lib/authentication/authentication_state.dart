import 'package:rejolute/util/base_equatable.dart';

abstract class AuthenticationState extends BaseEquatable {}

class AuthenticationSplashScreen extends AuthenticationState {
  @override
  String toString() {
    return "AuthenticationSplashScreen";
  }
}

class AuthenticationUninitializedState extends AuthenticationState {
  @override
  String toString() {
    return 'AuthenticationUninitializedState';
  }
}

class AuthenticationLoadingState extends AuthenticationState {
  @override
  String toString() {
    return 'AuthenticationLoadingState';
  }
}

class AuthenticationunAuthenticatedState extends AuthenticationState {
  @override
  String toString() {
    return 'AuthenticationunAuthenticatedState';
  }
}

class AuthenticationAuthenticatedState extends AuthenticationState {
  @override
  String toString() {
    return 'AuthenticationAuthenticatedState';
  }
}

class AuthenticationMedicalScreenSate extends AuthenticationState {
  @override
  String toString() {
    return 'AuthenticationMedicalScreenSate';
  }
}
