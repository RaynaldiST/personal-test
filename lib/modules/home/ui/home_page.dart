import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/modules/contact/bloc/contact_cubit.dart';
import 'package:test_project/modules/contact/ui/contact_page.dart';
import 'package:test_project/modules/home/bloc/home_cubit.dart';
import 'package:test_project/modules/home/bloc/home_state.dart';
import 'package:test_project/modules/profile/bloc/profile_cubit.dart';
import 'package:test_project/modules/profile/ui/profile_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is HomeFirstPage) {
            return BlocProvider<ContactCubit>(
              create: (context) => ContactCubit()..initCubit(),
              child: ContactPage(),
            );
          }

          if (state is HomeSecondPage) {
            return BlocProvider<ProfileCubit>(
              create: (context) => ProfileCubit()..initCubit(),
              child: ProfilePage(),
            );
          }

          return Container();
        },
      ),
      bottomNavigationBar: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          var cubit = context.read<HomeCubit>();
          return BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changePage(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Image.asset("assets/icons/ic_home_grey.png"),
                activeIcon: Image.asset("assets/icons/ic_home_blue.png"),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Image.asset("assets/icons/ic_user_grey.png"),
                activeIcon: Image.asset("assets/icons/ic_user_blue.png"),
                label: "",
              )
            ],
          );
        },
      ),
    );
  }
}
