import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/constant/routes.dart';
import 'package:test_project/modules/main/bloc/main_state.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        body: BlocConsumer(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is MainUnauthenticated) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.login,
                (Route<dynamic> route) => false,
              );
            }

            if (state is MainFirstPage) {
              // First Page
              return Container();
            }

            if (state is MainSecondPage) {
              // Second Page
              return Container();
            }

            return Container();
          },
        ),
      ),
    );
  }
}
