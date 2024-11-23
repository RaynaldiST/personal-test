import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/constant/routes.dart';
import 'package:test_project/core/app/route_generator.dart';
import 'package:test_project/core/app/theme.dart';
import 'package:test_project/core/env/env.dart';
import 'package:test_project/modules/main/bloc/main_cubit.dart';
import 'package:test_project/modules/main/ui/main_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainCubit>(
          create: (context) => MainCubit()..initCubit(),
          child: MainPage(),
        ),
      ],
      child: MaterialApp(
        theme: basicTheme,
        debugShowCheckedModeBanner: Env.isDevelopment,
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: Routes.landing,
      ),
    );
  }
}
