import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/constant/routes.dart';
import 'package:test_project/constant/util.dart';
import 'package:test_project/core/app/palette.dart';
import 'package:test_project/modules/auth/bloc/auth_cubit.dart';
import 'package:test_project/modules/auth/bloc/auth_state.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AuthPageState();
}

class AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticate) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.landing,
              (Route<dynamic> route) => false,
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: Util.basePaddingMargin16,
                horizontal: Util.basePaddingMargin16,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Greeting Section
                  contentGreeting(),

                  /// Form Section
                  contentInputField(context, cubit),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Container contentGreeting() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: Util.basePaddingMargin16,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hi There!",
            style: TextStyle(
              color: Palette.blue,
              fontWeight: FontWeight.w600,
              fontSize: Util.baseTextSize16,
            ),
          ),
          Text(
            "Please login to see your contact list",
            style: TextStyle(
              color: Palette.darkGrey,
              fontWeight: FontWeight.w500,
              fontSize: Util.baseTextSize16,
            ),
          ),
        ],
      ),
    );
  }

  Container contentInputField(BuildContext context, AuthCubit cubit) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'User ID ',
              style: TextStyle(
                color: Palette.black,
                fontWeight: FontWeight.w500,
                fontSize: Util.baseTextSize14,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: '*',
                  style: TextStyle(
                    color: Palette.red,
                    fontWeight: FontWeight.w500,
                    fontSize: Util.baseTextSize14,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: Util.baseWidthHeight6),
          TextFormField(
            controller: cubit.emailController,
            onTapOutside: (value) {
              FocusManager.instance.primaryFocus!.unfocus();
            },
            onEditingComplete: () {
              FocusManager.instance.primaryFocus!.unfocus();
            },
            validator: (value) {
              return null;
            },
            decoration: InputDecoration(
              enabled: true,
              filled: false,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  Util.baseRoundedCorner15,
                ),
                borderSide: BorderSide(color: Palette.blue),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  Util.baseRoundedCorner15,
                ),
                borderSide: BorderSide(color: Palette.blue),
              ),
            ),
          ),
          SizedBox(height: Util.baseWidthHeight48),
          Container(
            width: MediaQuery.of(context).size.width,
            height: Util.baseWidthHeight48,
            child: TextButton(
              onPressed: () {
                cubit.validateUser();
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
                "Login",
                style: TextStyle(
                  color: Palette.blue,
                  fontWeight: FontWeight.w700,
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
