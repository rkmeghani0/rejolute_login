import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rejolute/authentication/authentication_bloc.dart';
import 'package:rejolute/authentication/authentication_event.dart';
import 'package:rejolute/screen/login_screen/bloc/login_screen_event.dart';
import 'package:rejolute/screen/login_screen/bloc/login_screen_state.dart';
import 'package:rejolute/util/preference_helper.dart';
import 'package:rejolute/util/string_resource.dart';
import 'package:rejolute/util/validator.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthenticationBloc authBloc;
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  final FocusNode emailControllerFocus = FocusNode();
  final FocusNode passwordControllerFocus = FocusNode();
  String? emailErrorText;
  String? passwordErrorText;
  bool isPasswordVisible = true;
  IconData passwordSuffixIcon = Icons.visibility;

  LoginBloc(this.authBloc) : super(LoginInitialState());
  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginInitialEvent) {
      yield LoginLoadingState();
      emailErrorText = null;
      passwordErrorText = null;

      yield LoginInitialState();
    }
    if (event is LoginPasswordVisibilityToggleEvent) {
      isPasswordVisible = !isPasswordVisible;
      if (isPasswordVisible)
        passwordSuffixIcon = Icons.visibility;
      else
        passwordSuffixIcon = Icons.visibility_off;
      yield LoginPasswordVisibilityToggledState();
    }
    if (event is LoginButtonPressedEvent) {
      emailErrorText = null;
      passwordErrorText = null;
      yield LoginLoadingState();

      // check for valid email
      var state = Validator.validate(emailTextEditingController.text,
          rules: ["email", "required"]);
      if (!state.status) {
        emailErrorText = StringResource.EMAIL + " " + state.error!;
        yield LoginInitialState();
        return;
      }

      // check for valid password
      state = Validator.validate(passwordTextEditingController.text,
          rules: ["required"]);
      if (!state.status) {
        passwordErrorText = StringResource.PASSWORD + " " + state.error!;
        yield LoginInitialState();
        return;
      }

      // perform login
      try {
        var snap = await FirebaseFirestore.instance
            .collection('users')
            .where("email", isEqualTo: emailTextEditingController.text)
            .where("password", isEqualTo: passwordTextEditingController.text)
            .get();
        print(snap);
        if (snap != null) {
          if (snap.docs != null) {
            if (snap.docs.length > 0) {
              await PreferenceHelper.saveEmail(emailTextEditingController.text);
              yield LoginSuccessState();
            } else {
              yield LoginInitialState(error: "Email and Password is incorrect");
            }
          } else {
            yield LoginInitialState(error: StringResource.SOMETHING_WENT_WRONG);
          }
        } else {
          yield LoginInitialState(error: StringResource.SOMETHING_WENT_WRONG);
        }
      } catch (e) {
        print(e);
        yield LoginInitialState(error: e.toString());
      }
    }
  }

  dispose() {
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
  }
}
