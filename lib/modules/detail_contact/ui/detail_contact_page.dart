import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/constant/routes.dart';
import 'package:test_project/constant/util.dart';
import 'package:test_project/core/app/palette.dart';
import 'package:test_project/modules/detail_contact/bloc/detail_contact_cubit.dart';
import 'package:test_project/modules/detail_contact/bloc/detail_contact_state.dart';

class DetailContactPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DetailContactPageState();
}

class DetailContactPageState extends State<DetailContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Contact Details",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: Util.baseTextSize18,
          ),
        ),
      ),
      body: BlocConsumer<DetailContactCubit, DetailContactState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: contentContactDetail(context),
          );
        },
      ),
    );
  }

  Container contentContactDetail(BuildContext context) {
    var cubit = context.read<DetailContactCubit>();

    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        vertical: Util.basePaddingMargin36,
        horizontal: Util.basePaddingMargin18,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /// Header Profile
          Container(
            alignment: Alignment.center,
            width: Util.baseWidthHeight110,
            height: Util.baseWidthHeight110,
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
          SizedBox(height: Util.baseWidthHeight32),

          /// Main Information
          containerSpacer("Main Information"),

          formFirstName(cubit),

          formLastName(cubit),

          /// Sub Information
          containerSpacer("Sub Information"),

          formEmail(cubit),

          formDob(cubit),

          SizedBox(height: Util.baseWidthHeight56),
          Container(
            width: MediaQuery.of(context).size.width,
            height: Util.baseWidthHeight48,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  Routes.detail,
                  arguments: {"user": cubit.user, "isEdit": true},
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

  Widget containerSpacer(String title) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(vertical: Util.basePaddingMargin4),
          child: Text(
            title,
            style: TextStyle(
              color: Palette.blue,
              fontWeight: FontWeight.w500,
              fontSize: Util.baseTextSize16,
            ),
          ),
        ),
        Container(
          color: Palette.darkGrey,
          height: Util.baseWidthHeight1,
        ),
      ],
    );
  }

  /// First Name Form
  Container formFirstName(DetailContactCubit cubit) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Util.basePaddingMargin12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'First Name ',
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
            controller: cubit.firstNameController,
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
        ],
      ),
    );
  }

  /// Last Name Form
  Container formLastName(DetailContactCubit cubit) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Util.basePaddingMargin12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'Last Name ',
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
            controller: cubit.lastNameController,
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
        ],
      ),
    );
  }

  Container formEmail(DetailContactCubit cubit) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Util.basePaddingMargin12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'Email',
              style: TextStyle(
                color: Palette.black,
                fontWeight: FontWeight.w500,
                fontSize: Util.baseTextSize14,
              ),
              children: <TextSpan>[],
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
        ],
      ),
    );
  }

  Container formDob(DetailContactCubit cubit) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Util.basePaddingMargin12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'Date of Birth',
              style: TextStyle(
                color: Palette.black,
                fontWeight: FontWeight.w500,
                fontSize: Util.baseTextSize14,
              ),
              children: <TextSpan>[],
            ),
          ),
          SizedBox(height: Util.baseWidthHeight6),
          TextFormField(
            controller: cubit.firstNameController,
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
        ],
      ),
    );
  }
}
