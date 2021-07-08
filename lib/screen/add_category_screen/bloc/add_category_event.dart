import 'package:rejolute/util/base_equatable.dart';

class AddCategoryEvent extends BaseEquatable {}

class AddCategoryInitialEvent extends AddCategoryEvent {
  @override
  String toString() {
    return "AddCategoryInitialEvent";
  }
}

class SubmitEvent extends AddCategoryEvent {
  @override
  String toString() {
    return "SubmitEvent";
  }
}
