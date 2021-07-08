import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rejolute/authentication/authentication_bloc.dart';
import 'package:rejolute/authentication/authentication_event.dart';
import 'package:rejolute/screen/register_screen/bloc/register_screen_event.dart';
import 'package:rejolute/screen/register_screen/bloc/register_screen_state.dart';
import 'package:rejolute/util/preference_helper.dart';
import 'package:rejolute/util/string_resource.dart';
import 'package:rejolute/util/validator.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  AuthenticationBloc authBloc;
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  final FocusNode emailControllerFocus = FocusNode();
  final FocusNode passwordControllerFocus = FocusNode();
  String? emailErrorText;
  String? passwordErrorText;
  bool isPasswordVisible = true;
  IconData passwordSuffixIcon = Icons.visibility;

  RegisterBloc(this.authBloc) : super(RegisterInitialState());
  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterInitialEvent) {
      yield RegisterLoadingState();
      emailErrorText = null;
      passwordErrorText = null;

      yield RegisterInitialState();
    }
    if (event is RegisterPasswordVisibilityToggleEvent) {
      isPasswordVisible = !isPasswordVisible;
      if (isPasswordVisible)
        passwordSuffixIcon = Icons.visibility;
      else
        passwordSuffixIcon = Icons.visibility_off;
      yield RegisterPasswordVisibilityToggledState();
    }
    if (event is RegisterButtonPressedEvent) {
      emailErrorText = null;
      passwordErrorText = null;
      yield RegisterLoadingState();

      // check for valid email
      var state = Validator.validate(emailTextEditingController.text,
          rules: ["email", "required"]);
      if (!state.status) {
        emailErrorText = StringResource.EMAIL + " " + state.error!;
        yield RegisterInitialState();
        return;
      }

      // check for valid password
      state = Validator.validate(passwordTextEditingController.text,
          rules: ["required"]);
      if (!state.status) {
        passwordErrorText = StringResource.PASSWORD + " " + state.error!;
        yield RegisterInitialState();
        return;
      }

      // perform Register
      try {
        var mainFormData = {
          "email": emailTextEditingController.text,
          "password": passwordTextEditingController.text
        };
        var snap = await FirebaseFirestore.instance
            .collection('users')
            .where("email", isEqualTo: emailTextEditingController.text)
            .get();
        print(snap);
        var found = false;
        if (snap != null) {
          if (snap.docs != null) {
            if (snap.docs.length > 0) {
              yield RegisterInitialState(error: "Email is already in used");
              found = true;
            }
          }
        }
        if (!found) {
          DocumentReference? ref = await FirebaseFirestore.instance
              .collection("users")
              .add(mainFormData);
          if (ref != null) {
            await PreferenceHelper.saveEmail(emailTextEditingController.text);
            yield RegisterSuccessState();
          } else {
            yield RegisterInitialState(
                error: StringResource.SOMETHING_WENT_WRONG);
          }
        }
      } catch (e) {
        print(e);
        yield RegisterInitialState(error: e.toString());
      }
    }
  }

  dispose() {
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
  }
}
