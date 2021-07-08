import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rejolute/authentication/authentication_event.dart';
import 'package:rejolute/util/preference_helper.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  bool isIos = Platform.isIOS;

  AuthenticationBloc() : super(AuthenticationUninitializedState());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    // eventBus.on<UnAuthenticatedEvent>().listen((event) {
    //   add(LoggedOutEvent());
    // });
    if (event is LoggedOutEvent) {
      print("event is comming");
      //yield AuthenticationunAuthenticatedState();
      await PreferenceHelper.clearStorage();
    }
    if (event is AppStartedEvent) {
      yield AuthenticationSplashScreen();
      await Future.delayed(Duration(seconds: 1));
      String? email = await PreferenceHelper.getEmail();
      if (email != null) {
        if (email.isNotEmpty) {
          yield AuthenticationAuthenticatedState();
        } else {
          yield AuthenticationunAuthenticatedState();
        }
      } else {
        yield AuthenticationunAuthenticatedState();
      }
    }
  }
}
