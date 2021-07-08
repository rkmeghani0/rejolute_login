import 'package:rejolute/util/base_equatable.dart';

class HomeState extends BaseEquatable {}

class HomeInitialState extends HomeState {
  final String? error;
  HomeInitialState({this.error});
  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) => false;
  @override
  String toString() {
    return 'HomeInitialState';
  }
}

class HomeLoadingState extends HomeState {
  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) => false;
  @override
  String toString() {
    return "HomeLoadingState";
  }
}
