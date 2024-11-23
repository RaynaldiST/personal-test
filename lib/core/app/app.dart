import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_project/constant/routes.dart';
import 'package:test_project/core/app/route_generator.dart';
import 'package:test_project/core/app/theme.dart';
import 'package:test_project/core/env/env.dart';
import 'package:test_project/modules/auth/bloc/auth_cubit.dart';
import 'package:test_project/modules/auth/ui/auth_page.dart';
import 'package:test_project/modules/contact/bloc/contact_cubit.dart';
import 'package:test_project/modules/contact/ui/contact_page.dart';
import 'package:test_project/modules/main/bloc/main_cubit.dart';
import 'package:test_project/modules/main/ui/main_page.dart';
import 'package:test_project/modules/profile/bloc/profile_cubit.dart';
import 'package:test_project/modules/profile/ui/profile_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainCubit>(
          create: (context) => MainCubit()..initCubit(),
          child: MainPage(),
        ),
        BlocProvider<ContactCubit>(
          create: (context) => ContactCubit()..initCubit(),
          child: ContactPage(),
        ),
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit()..initCubit(),
          child: ProfilePage(),
        ),
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit()..initCubit(),
          child: AuthPage(),
        ),
      ],
      child: MaterialApp(
        theme: basicTheme,
        builder: FToastBuilder(),
        debugShowCheckedModeBanner: Env.isDevelopment,
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: Routes.landing,
      ),
    );
  }
}
