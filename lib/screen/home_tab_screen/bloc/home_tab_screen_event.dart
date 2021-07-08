import 'package:rejolute/util/base_equatable.dart';

class HomeTabEvent extends BaseEquatable {}

class HomeTabInitialEvent extends HomeTabEvent {
  @override
  String toString() {
    return "HomeTabInitialEvent";
  }
}
