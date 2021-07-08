import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rejolute/authentication/authentication_bloc.dart';
import 'package:rejolute/screen/add_category_screen/add_category_screen.dart';
import 'package:rejolute/screen/add_category_screen/bloc/add_category_bloc.dart';
import 'package:rejolute/screen/add_category_screen/bloc/add_category_event.dart';
import 'package:rejolute/screen/cart_screen/bloc/cart_screen_bloc.dart';
import 'package:rejolute/screen/cart_screen/bloc/cart_screen_event.dart';
import 'package:rejolute/screen/cart_screen/cart_screen.dart';
import 'package:rejolute/screen/home_screen/bloc/home_screen_bloc.dart';
import 'package:rejolute/screen/home_screen/bloc/home_screen_event.dart';
import 'package:rejolute/screen/home_screen/home_screen.dart';
import 'package:rejolute/screen/home_tab_screen/bloc/home_tab_screen_bloc.dart';
import 'package:rejolute/screen/home_tab_screen/bloc/home_tab_screen_event.dart';
import 'package:rejolute/screen/home_tab_screen/home_tab_screen.dart';
import 'package:rejolute/screen/login_screen/bloc/login_screen_bloc.dart';
import 'package:rejolute/screen/login_screen/bloc/login_screen_event.dart';
import 'package:rejolute/screen/login_screen/login_screen.dart';
import 'package:rejolute/screen/product_screen/bloc/product_screen_bloc.dart';
import 'package:rejolute/screen/product_screen/bloc/product_screen_event.dart';
import 'package:rejolute/screen/product_screen/product_screen.dart';
import 'package:rejolute/screen/register_screen/bloc/register_screen_bloc.dart';
import 'package:rejolute/screen/register_screen/bloc/register_screen_event.dart';
import 'package:rejolute/screen/register_screen/register_screen.dart';
import 'package:rejolute/screen/splash_screen.dart';
import 'package:rejolute/util/color_resource.dart';
import 'package:rejolute/util/route_aware_widget.dart';
import 'authentication/authentication_state.dart';

class AppRoutes {
  static const String SPLASH_SCREEN = "splash_screen";
  static const String PRODUCT_SCREEN = "product_screen";
  static const String CART_SCREEN = "cart_screen";
  static const String LOGIN_SCREEN = "login_screen";
  static const String REGISTER_SCREEN = "register_screen";
  static const String HOME_TAB_SCREEN = 'home_tab_screen';
  static const String HOME_SCREEN = 'home_screen';
  static const String ADD_CATEGORY_SCREEN = 'add_category_screen';
}

Route<dynamic>? getRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.SPLASH_SCREEN:
      return buildSplashScreen(settings);
    case AppRoutes.PRODUCT_SCREEN:
      return buildProductScreen(settings);
    case AppRoutes.CART_SCREEN:
      return buildCartScreen(settings);
    case AppRoutes.LOGIN_SCREEN:
      return buildLoginScreen(settings);
    case AppRoutes.REGISTER_SCREEN:
      return buildRegisterScreen(settings);
    case AppRoutes.HOME_TAB_SCREEN:
      return buildHomeTabScreen(settings);
    case AppRoutes.HOME_SCREEN:
      return buildHomeScreen(settings);
    case AppRoutes.ADD_CATEGORY_SCREEN:
      return buildAddCategoryScreen(settings);
  }
  return null;
}

Route buildSplashScreen(RouteSettings settings) {
  return MaterialPageRoute(
    builder: (context) =>
        addAuthBloc(context, PageBuilder.buildSplashScreen(settings)),
  );
}

Route buildProductScreen(RouteSettings settings) {
  return MaterialPageRoute(
    settings: RouteSettings(name: AppRoutes.PRODUCT_SCREEN),
    builder: (context) =>
        addAuthBloc(context, PageBuilder.buildProductScreen(settings)),
  );
}

Route buildCartScreen(RouteSettings settings) {
  return MaterialPageRoute(
    settings: RouteSettings(name: AppRoutes.CART_SCREEN),
    builder: (context) =>
        addAuthBloc(context, PageBuilder.buildCartScreen(settings)),
  );
}

Route buildLoginScreen(RouteSettings settings) {
  return MaterialPageRoute(
    settings: RouteSettings(name: AppRoutes.LOGIN_SCREEN),
    builder: (context) =>
        addAuthBloc(context, PageBuilder.buildLoginScreen(settings)),
  );
}

Route buildRegisterScreen(RouteSettings settings) {
  return MaterialPageRoute(
    settings: RouteSettings(name: AppRoutes.REGISTER_SCREEN),
    builder: (context) =>
        addAuthBloc(context, PageBuilder.buildRegisterScreen(settings)),
  );
}

Route buildHomeTabScreen(RouteSettings settings) {
  return MaterialPageRoute(
    settings: RouteSettings(name: AppRoutes.HOME_TAB_SCREEN),
    builder: (context) =>
        addAuthBloc(context, PageBuilder.buildHomeTabScreen(settings)),
  );
}

Route buildHomeScreen(RouteSettings settings) {
  return MaterialPageRoute(
    settings: RouteSettings(name: AppRoutes.HOME_SCREEN),
    builder: (context) =>
        addAuthBloc(context, PageBuilder.buildHomeScreen(settings)),
  );
}

Route buildAddCategoryScreen(RouteSettings settings) {
  return MaterialPageRoute(
    settings: RouteSettings(name: AppRoutes.ADD_CATEGORY_SCREEN),
    builder: (context) =>
        addAuthBloc(context, PageBuilder.buildAddCategoryScreen(settings)),
  );
}

class PageBuilder {
  static Widget buildSplashScreen(RouteSettings settings) {
    return SplashScreen();
  }

  static Widget buildProductScreen(RouteSettings settings) {
    return BlocProvider<ProductBloc>(
      create: (context) {
        return ProductBloc()..add(ProductInitialEvent());
      },
      child: RouteAwareWidget(AppRoutes.PRODUCT_SCREEN, child: ProductScreen()),
    );
  }

  static Widget buildCartScreen(RouteSettings settings) {
    return BlocProvider<CartBloc>(
      create: (context) {
        return CartBloc()..add(CartInitialEvent());
      },
      child: RouteAwareWidget(AppRoutes.CART_SCREEN, child: CartScreen()),
    );
  }

  static Widget buildLoginScreen(RouteSettings settings) {
    return BlocProvider<LoginBloc>(
      create: (context) {
        return LoginBloc(BlocProvider.of<AuthenticationBloc>(context))
          ..add(LoginInitialEvent());
      },
      child: RouteAwareWidget(AppRoutes.LOGIN_SCREEN, child: LoginScreen()),
    );
  }

  static Widget buildRegisterScreen(RouteSettings settings) {
    return BlocProvider<RegisterBloc>(
      create: (context) {
        return RegisterBloc(BlocProvider.of<AuthenticationBloc>(context))
          ..add(RegisterInitialEvent());
      },
      child:
          RouteAwareWidget(AppRoutes.REGISTER_SCREEN, child: RegisterScreen()),
    );
  }

  static Widget buildAddCategoryScreen(RouteSettings settings) {
    return BlocProvider<AddCategoryBloc>(
      create: (context) {
        return AddCategoryBloc(BlocProvider.of<AuthenticationBloc>(context))
          ..add(AddCategoryInitialEvent());
      },
      child: RouteAwareWidget(AppRoutes.ADD_CATEGORY_SCREEN,
          child: AddCategoryScreen()),
    );
  }

  static Widget buildHomeTabScreen(RouteSettings settings) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            AuthenticationBloc authBloc =
                BlocProvider.of<AuthenticationBloc>(context);
            return HomeTabBloc(authBloc)..add(HomeTabInitialEvent());
          },
        ),
        BlocProvider<HomeBloc>(
          create: (context) {
            return HomeBloc(BlocProvider.of<AuthenticationBloc>(context))
              ..add(HomeInitialEvent());
          },
        ),
      ],
      child: HomeTabScreen(),
    );
  }

  static Widget buildHomeScreen(RouteSettings settings) {
    return BlocProvider<HomeBloc>(
      create: (context) {
        return HomeBloc(BlocProvider.of<AuthenticationBloc>(context))
          ..add(HomeInitialEvent());
      },
      child: RouteAwareWidget(AppRoutes.HOME_SCREEN, child: HomeScreen()),
    );
  }
}

addAuthBloc(BuildContext context, Widget widget) {
  return BlocListener<AuthenticationBloc, AuthenticationState>(
    bloc: BlocProvider.of<AuthenticationBloc>(context),
    listener: (BuildContext context, AuthenticationState state) {
      if (state is AuthenticationSplashScreen) {
        Navigator.pushReplacementNamed(context, AppRoutes.SPLASH_SCREEN);
      }
      if (state is AuthenticationunAuthenticatedState) {
        print("State is comming");
        Navigator.pushReplacementNamed(
            (context.findRootAncestorStateOfType<ScaffoldState>() != null)
                ? context.findRootAncestorStateOfType<ScaffoldState>()!.context
                : context,
            AppRoutes.LOGIN_SCREEN);
      }
      if (state is AuthenticationMedicalScreenSate) {
        Navigator.pushReplacementNamed(context, AppRoutes.PRODUCT_SCREEN);
      }
      if (state is AuthenticationAuthenticatedState) {
        Navigator.pushNamedAndRemoveUntil(
            (context.findRootAncestorStateOfType<ScaffoldState>() != null)
                ? context.findRootAncestorStateOfType<ScaffoldState>()!.context
                : context,
            AppRoutes.LOGIN_SCREEN,
            (route) => false);
      }
    },
    child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
      bloc: BlocProvider.of<AuthenticationBloc>(context),
      builder: (context, state) {
        if (state is AuthenticationUninitializedState ||
            state is AuthenticationLoadingState) {
          return Container(color: ColorResource.BACKGROUND_WHITE);
        } else {
          return widget;
        }
      },
    ),
  );
}
