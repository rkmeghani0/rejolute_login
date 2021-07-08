import 'package:rejolute/util/base_equatable.dart';

class HomeEvent extends BaseEquatable {}

class HomeInitialEvent extends HomeEvent {
  @override
  String toString() {
    return "HomeInitialEvent";
  }
}
