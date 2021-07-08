import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rejolute/authentication/authentication_bloc.dart';
import 'package:rejolute/screen/home_screen/bloc/home_screen_event.dart';
import 'package:rejolute/screen/home_screen/bloc/home_screen_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  AuthenticationBloc authBloc;
  List<String> lstName = [];
  HomeBloc(this.authBloc) : super(HomeInitialState());
  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeInitialEvent) {
      yield HomeLoadingState();
      lstName.clear();
      try {
        var snap =
            await FirebaseFirestore.instance.collection('category').get();
        print(snap);
        var found = false;
        if (snap != null) {
          if (snap.docs != null) {
            if (snap.docs.length > 0) {
              for (var i = 0; i < snap.docs.length; i++) {
                if (snap.docs[i]["name"] != null) {
                  if (snap.docs[i]["name"].toString().isNotEmpty) {
                    lstName.add(snap.docs[i]["name"]);
                  }
                }
              }
            }
          }
        }
      } catch (e) {
        print(e);
        yield HomeInitialState(error: e.toString());
      }
      print(lstName);
      yield HomeInitialState();
    }
  }
}
