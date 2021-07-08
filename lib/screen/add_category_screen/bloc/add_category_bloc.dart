import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rejolute/authentication/authentication_bloc.dart';
import 'package:rejolute/screen/add_category_screen/bloc/add_category_event.dart';
import 'package:rejolute/screen/add_category_screen/bloc/add_category_state.dart';
import 'package:rejolute/util/string_resource.dart';
import 'package:rejolute/util/validator.dart';

class AddCategoryBloc extends Bloc<AddCategoryEvent, AddCategoryState> {
  AuthenticationBloc authBloc;
  TextEditingController txtNameController = TextEditingController();
  String? nameErrortext;
  AddCategoryBloc(this.authBloc) : super(AddCategoryInitialState());
  @override
  Stream<AddCategoryState> mapEventToState(AddCategoryEvent event) async* {
    if (event is AddCategoryInitialEvent) {
      yield AddCategoryLoadingState();

      yield AddCategoryInitialState();
    }
    if (event is SubmitEvent) {
      yield AddCategoryLoadingState();

      var state =
          Validator.validate(txtNameController.text, rules: ["required"]);
      if (!state.status) {
        nameErrortext = "Name" + " " + state.error!;
        yield AddCategoryInitialState(error: nameErrortext);
        return;
      }
      try {
        var mainFormData = {
          "name": txtNameController.text,
        };
        var snap = await FirebaseFirestore.instance
            .collection('category')
            .where("name", isEqualTo: txtNameController.text)
            .get();
        print(snap);
        var found = false;
        if (snap != null) {
          if (snap.docs != null) {
            if (snap.docs.length > 0) {
              yield AddCategoryInitialState(error: "Name is already in used");
              found = true;
            }
          }
        }
        if (!found) {
          DocumentReference? ref = await FirebaseFirestore.instance
              .collection("category")
              .add(mainFormData);
          if (ref != null) {
            yield CategorySuccessState();
          } else {
            yield AddCategoryInitialState(
                error: StringResource.SOMETHING_WENT_WRONG);
          }
        }
      } catch (e) {
        print(e);
        yield AddCategoryInitialState(error: e.toString());
      }
    }
  }
}
