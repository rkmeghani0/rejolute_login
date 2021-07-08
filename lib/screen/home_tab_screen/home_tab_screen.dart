import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rejolute/authentication/authentication_event.dart';
import 'package:rejolute/router.dart';
import 'package:rejolute/screen/home_screen/home_screen.dart';
import 'package:rejolute/screen/home_tab_screen/bloc/home_tab_screen_bloc.dart';
import 'package:rejolute/screen/home_tab_screen/bloc/home_tab_screen_state.dart';
import 'package:rejolute/util/app_utils.dart';
import 'package:rejolute/util/color_resource.dart';
import 'package:rejolute/widget/custom_scaffold.dart';
import 'package:rejolute/widget/custom_text.dart';

var navigatorKey = GlobalKey<NavigatorState>();

class HomeTabScreen extends StatefulWidget {
  @override
  _HomeTabScreenState createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  HomeTabBloc? homeTabBloc;
  int currentIndex = 0;
  List<Widget> lstpage = [
    HomeScreen(),
  ];
  @override
  void initState() {
    super.initState();
    homeTabBloc = BlocProvider.of<HomeTabBloc>(context);

    WidgetsBinding.instance!
        .addPostFrameCallback((_) => buildAfterComplete(context));
  }

  buildAfterComplete(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    // return layout();

    return CustomScaffold(
      backgroundColor: ColorResource.BACKGROUND_WHITE,
      endDrawer: buildNavigationDrawer(),
      body: layout(),
    ); // return CustomScaffold(
    //   backgroundColor: ColorResource.BACKGROUND_WHITE,
    //   isBottomReSize: true,
    //   body: Container(
    //     child: layout(),
    //     color: ColorResource.BACKGROUND_WHITE,
    //   ),
    // );
  }

  Widget layout() {
    return BlocListener<HomeTabBloc, HomeTabState>(
      listener: (BuildContext context, HomeTabState state) {
        if (state is HomeTabInitialState) {
          if (state.error != null) {
            AppUtils.showToast(state.error!);
          }
        }
      },
      bloc: homeTabBloc,
      child: BlocBuilder<HomeTabBloc, HomeTabState>(
        bloc: homeTabBloc,
        builder: (BuildContext context, HomeTabState state) {
          print(state);
          return Container(
            child: lstpage[currentIndex],
          );
        },
      ),
    );
  }

  buildNavigationDrawer() {
    return Drawer(
      child: BlocBuilder<HomeTabBloc, HomeTabState>(
        builder: (BuildContext context, HomeTabState state) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: ListView(
              children: [
                CustomText("Welcome " + (homeTabBloc!.email ?? "")),
                buildNavItem("Home", () {}),
                buildNavItem("Settings", () {}),
                buildNavItem("Help", () {
                  Navigator.pushNamed(context, AppRoutes.PRODUCT_SCREEN);
                }),
                buildNavItem("Logout", () {
                  homeTabBloc!.authBloc.add(LoggedOutEvent());
                  Navigator.pushReplacementNamed(
                      (context.findRootAncestorStateOfType<ScaffoldState>() !=
                              null)
                          ? context
                              .findRootAncestorStateOfType<ScaffoldState>()!
                              .context
                          : context,
                      AppRoutes.LOGIN_SCREEN);
                }),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildNavItem(String text, Function()? onClickItem) {
    return InkWell(
      onTap: onClickItem,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(color: Colors.grey[200]),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        width: MediaQuery.of(context).size.width,
        child: CustomText(text),
      ),
    );
  }
}
