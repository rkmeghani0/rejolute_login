import 'package:rejolute/util/base_equatable.dart';

class HomeTabState extends BaseEquatable {}

class HomeTabInitialState extends HomeTabState {
  final String? error;
  HomeTabInitialState({this.error});
  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) => false;
  @override
  String toString() {
    return 'HomeTabInitialState';
  }
}

class HomeTabLoadingState extends HomeTabState {
  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) => false;
  @override
  String toString() {
    return "HomeTabLoadingState";
  }
}
