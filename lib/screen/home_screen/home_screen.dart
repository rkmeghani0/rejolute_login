import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rejolute/router.dart';
import 'package:rejolute/screen/home_screen/bloc/home_screen_bloc.dart';
import 'package:rejolute/screen/home_screen/bloc/home_screen_event.dart';
import 'package:rejolute/screen/home_screen/bloc/home_screen_state.dart';
import 'package:rejolute/screen/home_tab_screen/home_tab_screen.dart';
import 'package:rejolute/util/app_utils.dart';
import 'package:rejolute/util/color_resource.dart';
import 'package:rejolute/util/image_resource.dart';
import 'package:rejolute/widget/custom_app_bar.dart';
import 'package:rejolute/widget/custom_scaffold.dart';
import 'package:rejolute/widget/custom_text.dart';
import 'package:rejolute/widget/loading_animation.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc? homeBloc;
  @override
  void initState() {
    super.initState();
    homeBloc = BlocProvider.of<HomeBloc>(context);

    WidgetsBinding.instance!
        .addPostFrameCallback((_) => buildAfterComplete(context));
  }

  buildAfterComplete(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: ColorResource.BACKGROUND_WHITE,
      isBottomReSize: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.ADD_CATEGORY_SCREEN)
            ..then((value) {
              homeBloc!.add(HomeInitialEvent());
            });
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        child: layout(),
        color: ColorResource.BACKGROUND_WHITE,
      ),
    );
  }

  Widget layout() {
    return BlocListener<HomeBloc, HomeState>(
      listener: (BuildContext context, HomeState state) {
        if (state is HomeInitialState) {
          if (state.error != null) {
            AppUtils.showToast(state.error!);
          }
        }
      },
      bloc: homeBloc,
      child: BlocBuilder<HomeBloc, HomeState>(
        bloc: homeBloc,
        builder: (BuildContext context, HomeState state) {
          print(state);
          return buildMainBody(state);
        },
      ),
    );
  }

  Widget buildMainBody(HomeState state) {
    return Container(
      child: Column(
        children: [
          buildAppBarCustom(),
          Expanded(
            child: state is HomeLoadingState
                ? LoadingAnimationIndicator()
                : buildProduct(),
          ),
        ],
      ),
    );
  }

  Widget buildProduct() {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = 200;
    final double itemWidth = size.width / 2;
    var productLength = homeBloc!.lstName.length;

    return Container(
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: (itemWidth / itemHeight),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          for (int index = 0; index < homeBloc!.lstName.length; index++)
            productItem(index)
        ],
      ),
    );
  }

  Widget productItem(int index) {
    String str = homeBloc!.lstName[index];
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      color: Colors.grey[200],
      child: Column(
        children: [
          Expanded(
              child: Image.network(
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1200px-Image_created_with_a_mobile_phone.png")),
          CustomText(AppUtils.truncateWithEllipsis(20, str)),
        ],
      ),
    );
  }

  Widget buildAppBarCustom() {
    return CustomAppBar(
      appBarBackgroundColor: ColorResource.PRIMARY,
      centerWidget: Image.asset(
        ImageResource.APP_LOGO,
        height: 30,
      ),
      onTrailingWidgetActionPressed: () {
        // Navigator.pushNamed(context, AppRoutes.CART_SCREEN);
        print("Click");
        // navigatorKey.currentContext.findRootAncestorStateOfType(
        final ScaffoldState? scaffoldState =
            this.context.findRootAncestorStateOfType<ScaffoldState>();
        scaffoldState!.openEndDrawer();
      },
      trailingWidget: InkWell(
        child: Stack(children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.bar_chart,
              color: Colors.white,
            ),
            onPressed: null,
          ),
        ]),
      ),
    );
  }
}
