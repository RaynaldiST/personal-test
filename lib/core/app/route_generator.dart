import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/constant/routes.dart';
import 'package:test_project/modules/auth/bloc/auth_cubit.dart';
import 'package:test_project/modules/auth/ui/auth_page.dart';
import 'package:test_project/modules/main/bloc/main_cubit.dart';
import 'package:test_project/modules/main/ui/main_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    try {
      final dynamic args = settings.arguments;
      switch (settings.name) {
        case Routes.landing:
          return getPageRoute(
            BlocProvider(
              create: (context) => MainCubit()..initCubit(),
              child: MainPage(),
            ),
          );
        case Routes.login:
          return getPageRoute(BlocProvider(
            create: (context) => AuthCubit()..initCubit(),
            child: AuthPage(),
          ));
        default:
          return errorRoute();
      }
    } catch (e) {
      return errorRoute();
    }
  }

  static CupertinoPageRoute getPageRoute(
    Widget child, [
    RouteSettings settings = const RouteSettings(),
    bool? isFullScreenDialog = false,
  ]) =>
      CupertinoPageRoute(
        builder: (context) => child,
        fullscreenDialog: isFullScreenDialog!,
        settings: RouteSettings(
          name: settings.name,
          arguments: settings.arguments,
        ),
      );

  static Route<dynamic> errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: const Text("Oops")),
        body: const Center(child: Text("Page not found!")),
      );
    });
  }
}
