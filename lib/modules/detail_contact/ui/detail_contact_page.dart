import 'dart:developer';

import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
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
    var cubit = context.read<DetailContactCubit>();
    FToast toast = FToast().init(context);

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
        listener: (context, state) {
          if (state is DetailContactValid) {
            /// Navigate to last page and update the selected data
            Navigator.of(context).pop({
              "isUpdate": true,
              "user": cubit.userUpdate,
            });
          }

          if (state is DetailContactDelete) {
            Navigator.of(context).pop({
              "isUpdate": false,
              "user": cubit.user,
            });
          }

          if (state is DetailContactUpdated) {
            Navigator.of(context).pop();
          }

          if (state is DetailContactInvalid) {
            toast.showToast(
              gravity: ToastGravity.BOTTOM,
              child: Container(
                alignment: Alignment.center,
                width: Util.baseWidthHeight210,
                height: Util.baseWidthHeight32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Util.baseRoundedCorner),
                  color: Palette.red,
                ),
                child: Text(
                  "${cubit.errorMessage}",
                  style: TextStyle(
                    color: Palette.white,
                    fontSize: Util.baseTextSize14,
                  ),
                ),
              ),
              toastDuration: Duration(seconds: 3),
            );
          }
        },
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
            child: cubit.isSaveActive
                ? Image.asset("assets/icons/ic_user_white.png")
                : Text(
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

          inputTextField(
              context, cubit, cubit.firstNameController, "First Name", true),

          inputTextField(
              context, cubit, cubit.lastNameController, "Last Name", true),

          SizedBox(height: Util.baseWidthHeight16),

          /// Sub Information
          containerSpacer("Sub Information"),

          inputTextField(
              context, cubit, cubit.emailController, "Email", false, [
            FilteringTextInputFormatter.allow(
              RegExp(r'([a-z]|[A-Z]|[0-9]|[@.])'),
            )
          ]),

          inputTextField(context, cubit, cubit.dobController, "Date of Birth",
              false, [], true),

          SizedBox(height: Util.baseWidthHeight16),
          containerActionButton(context, cubit),
        ],
      ),
    );
  }

  Widget containerActionButton(
    BuildContext context,
    DetailContactCubit cubit,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Button Update
        Visibility(
          visible: cubit.isUpdateActive,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: Util.baseWidthHeight48,
            child: TextButton(
              onPressed: () {
                if (cubit.data["isFromProfile"]) {
                  cubit.postCubit();
                } else {
                  cubit.validateInput();
                }
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
                "Update",
                style: TextStyle(
                  color: Palette.blue,
                  fontWeight: FontWeight.w800,
                  fontSize: Util.baseTextSize18,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: Util.baseWidthHeight12),

        /// Button Remove
        Visibility(
          visible: cubit.isRemoveActive,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: Util.baseWidthHeight48,
            child: TextButton(
              onPressed: () {
                cubit.removeData();
              },
              style: ButtonStyle(
                // backgroundColor: WidgetStateProperty.all(Palette.red),
                shape: WidgetStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Util.baseRoundedCorner),
                    side: BorderSide(color: Palette.red),
                  ),
                ),
              ),
              child: Text(
                "Remove",
                style: TextStyle(
                  color: Palette.red,
                  fontWeight: FontWeight.w500,
                  fontSize: Util.baseTextSize18,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: Util.baseWidthHeight12),

        /// Button Save
        Visibility(
          visible: cubit.isSaveActive,
          child: Container(
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
                "Save",
                style: TextStyle(
                  color: Palette.blue,
                  fontWeight: FontWeight.w800,
                  fontSize: Util.baseTextSize18,
                ),
              ),
            ),
          ),
        ),
      ],
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
              fontStyle: FontStyle.italic,
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

  /// Input Text Field
  Container inputTextField(
    BuildContext context,
    DetailContactCubit cubit,
    TextEditingController controller,
    String title, [
    bool isRequired = false,
    List<TextInputFormatter>? inputFormatters,
    bool readOnly = false,
  ]) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Util.basePaddingMargin12),
      child: Form(
        autovalidateMode: AutovalidateMode.disabled,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: title,
                style: TextStyle(
                  color: Palette.black,
                  fontWeight: FontWeight.w500,
                  fontSize: Util.baseTextSize14,
                ),
                children: <TextSpan>[
                  isRequired
                      ? TextSpan(
                          text: '*',
                          style: TextStyle(
                            color: Palette.red,
                            fontWeight: FontWeight.w500,
                            fontSize: Util.baseTextSize14,
                          ),
                        )
                      : TextSpan(),
                ],
              ),
            ),
            SizedBox(height: Util.baseWidthHeight6),
            TextFormField(
              controller: controller,
              inputFormatters: inputFormatters,
              onTapOutside: (value) {
                FocusManager.instance.primaryFocus!.unfocus();
              },
              onEditingComplete: () {
                FocusManager.instance.primaryFocus!.unfocus();
              },
              validator: (value) {
                if (cubit.firstNameController.text.isEmpty) {
                  return "First name required";
                }

                if (cubit.lastNameController.text.isEmpty) {
                  return "Last name required";
                }

                return null;
              },
              onTap: () async {
                if (readOnly) {
                  var date = await showDatePickerDialog(
                    context: context,
                    maxDate: DateTime.now(),
                    minDate: DateTime(1980),
                  );
                  String dateFormat = DateFormat("dd/MM/yyyy").format(date!);

                  cubit.dobController.text = dateFormat;
                }
              },
              readOnly: readOnly,
              decoration: InputDecoration(
                filled: false,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    Util.baseRoundedCorner15,
                  ),
                  borderSide: BorderSide(color: Palette.blue),
                ),
                disabledBorder: OutlineInputBorder(
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
      ),
    );
  }
}
