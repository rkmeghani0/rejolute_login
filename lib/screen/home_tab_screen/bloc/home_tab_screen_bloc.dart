import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rejolute/authentication/authentication_bloc.dart';
import 'package:rejolute/screen/home_tab_screen/bloc/home_tab_screen_event.dart';
import 'package:rejolute/screen/home_tab_screen/bloc/home_tab_screen_state.dart';
import 'package:rejolute/util/preference_helper.dart';

class HomeTabBloc extends Bloc<HomeTabEvent, HomeTabState> {
  AuthenticationBloc authBloc;
  String? email = "";
  HomeTabBloc(this.authBloc) : super(HomeTabInitialState());
  @override
  Stream<HomeTabState> mapEventToState(HomeTabEvent event) async* {
    if (event is HomeTabInitialEvent) {
      yield HomeTabLoadingState();
      email = await PreferenceHelper.getEmail();
      yield HomeTabInitialState();
    }
  }
}
