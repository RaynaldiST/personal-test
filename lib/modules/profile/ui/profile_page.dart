import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/constant/routes.dart';
import 'package:test_project/constant/util.dart';
import 'package:test_project/core/app/palette.dart';
import 'package:test_project/modules/profile/bloc/profile_cubit.dart';
import 'package:test_project/modules/profile/bloc/profile_state.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ProfileCubit>();
    return Scaffold(
      appBar: AppBar(
        elevation: Util.baseWidthHeight1,
        backgroundColor: Palette.white,
        title: Text(
          "My Profile",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: Util.baseTextSize18,
          ),
        ),
        actions: [
          Container(
            child: TextButton(
              onPressed: () {
                cubit.postCubit();
              },
              child: Text(
                "Logout",
                style: TextStyle(
                  color: Palette.blue,
                  fontWeight: FontWeight.w800,
                  fontSize: Util.baseTextSize18,
                ),
              ),
            ),
          )
        ],
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileUnauthenticated) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.login,
              (Route<dynamic> route) => false,
            );
          }
        },
        builder: (context, state) {
          return contentProfile(context, cubit);
        },
      ),
    );
  }

  Container contentProfile(
    BuildContext context,
    ProfileCubit cubit,
  ) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        vertical: Util.basePaddingMargin36,
        horizontal: Util.basePaddingMargin16,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: Util.baseWidthHeight120,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Palette.blue,
            ),
            child: Text(
              "${cubit.userInitial}",
              style: TextStyle(
                color: Palette.white,
                fontWeight: FontWeight.w200,
                fontSize: Util.baseTextSize52,
              ),
            ),
          ),
          SizedBox(height: Util.baseWidthHeight8),
          Container(
            height: Util.baseWidthHeight24,
            alignment: Alignment.center,
            child: Text(
              "${cubit.user.firstName} ${cubit.user.lastName}",
              style: TextStyle(
                color: Palette.grey500,
                fontWeight: FontWeight.w500,
                fontSize: Util.baseTextSize16,
              ),
            ),
          ),
          SizedBox(height: Util.baseWidthHeight8),
          Container(
            alignment: Alignment.center,
            height: Util.baseWidthHeight24,
            child: Text(
              "${cubit.user.email}",
              style: TextStyle(
                color: Palette.grey500,
                fontWeight: FontWeight.w500,
                fontSize: Util.baseTextSize16,
              ),
            ),
          ),
          SizedBox(height: Util.baseWidthHeight8),
          Container(
            alignment: Alignment.center,
            height: Util.baseWidthHeight24,
            child: Text(
              "${cubit.user.dob}",
              style: TextStyle(
                color: Palette.grey500,
                fontWeight: FontWeight.w500,
                fontSize: Util.baseTextSize16,
              ),
            ),
          ),
          SizedBox(height: Util.baseWidthHeight16),
          Container(
            width: MediaQuery.of(context).size.width,
            height: Util.baseWidthHeight48,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  Routes.detail,
                  arguments: {
                    "user": cubit.user,
                    "isEdit": true,
                    "isFromProfile": true,
                  },
                );
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Palette.lightBlue),
                shape: WidgetStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Util.baseRoundedCorner),
                  ),
                ),
              ),
              child: Text(
                "Update my detail",
                style: TextStyle(
                  color: Palette.blue,
                  fontWeight: FontWeight.w800,
                  fontSize: Util.baseTextSize18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
