import 'package:rejolute/util/base_equatable.dart';

class AddCategoryState extends BaseEquatable {}

class AddCategoryInitialState extends AddCategoryState {
  final String? error;
  AddCategoryInitialState({this.error});
  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) => false;
  @override
  String toString() {
    return 'AddCategoryInitialState';
  }
}

class AddCategoryLoadingState extends AddCategoryState {
  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) => false;
  @override
  String toString() {
    return "AddCategoryLoadingState";
  }
}

class CategorySuccessState extends AddCategoryState {
  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) => false;
  @override
  String toString() {
    return "CategorySuccessState";
  }
}