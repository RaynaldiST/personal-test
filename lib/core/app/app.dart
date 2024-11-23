import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/constant/routes.dart';
import 'package:test_project/core/app/route_generator.dart';
import 'package:test_project/core/app/theme.dart';
import 'package:test_project/core/env/env.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [],
      child: MultiBlocProvider(
        providers: [],
        child: MaterialApp(
          theme: basicTheme,
          debugShowCheckedModeBanner: Env.isDevelopment,
          onGenerateRoute: RouteGenerator.generateRoute,
          initialRoute: Routes.landing,
        ),
      ),
    );
  }
}
