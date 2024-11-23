import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:test_project/constant/routes.dart';
import 'package:test_project/constant/util.dart';
import 'package:test_project/core/app/palette.dart';
import 'package:test_project/modules/contact/bloc/contact_cubit.dart';
import 'package:test_project/modules/contact/bloc/contact_state.dart';

class ContactPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ContactPageState();
}

class ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ContactCubit>();
    return Scaffold(
      appBar: AppBar(
        elevation: Util.baseWidthHeight1,
        backgroundColor: Palette.white,
        title: Text(
          "My Contact",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: Util.baseTextSize18,
          ),
        ),
      ),
      body: BlocConsumer<ContactCubit, ContactState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              vertical: Util.basePaddingMargin12,
              horizontal: Util.basePaddingMargin16,
            ),
            physics: BouncingScrollPhysics(),
            child: RefreshIndicator(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  contentInputField(context, cubit),
                  contentListContact(context, cubit),
                ],
              ),
              notificationPredicate: (ScrollNotification notification) =>
                  notification.depth == 1,
              onRefresh: () async {
                cubit.isRefresh = true;
                cubit.initCubit();
              },
            ),
          );
        },
      ),
    );
  }

  Container contentListContact(
    BuildContext context,
    ContactCubit cubit,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Util.basePaddingMargin18),
      child: GroupedListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        elements: cubit.users,
        order: GroupedListOrder.ASC,
        groupBy: (element) => element.group!,
        groupSeparatorBuilder: (String data) => Container(
          padding: EdgeInsets.symmetric(vertical: Util.basePaddingMargin8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$data",
                style: TextStyle(
                  color: Palette.blue,
                  fontWeight: FontWeight.w600,
                  fontSize: Util.baseTextSize16,
                ),
              ),
              Container(
                height: Util.baseWidthHeight1,
                padding: EdgeInsets.symmetric(
                  vertical: Util.basePaddingMargin4,
                ),
                color: Palette.lightGrey,
              ),
            ],
          ),
        ),
        itemComparator: (item1, item2) {
          return item1.group!
              .toLowerCase()
              .compareTo(item2.group!.toLowerCase());
        },
        itemBuilder: (context, user) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                Routes.detail,
                arguments: {
                  "user": user,
                  "isEdit": true,
                  "isFromProfile": false,
                },
              ).then((dynamic value) {
                if (value['isUpdate'] == true) {
                  cubit.updateData(value['user']);
                } else {
                  cubit.removeData(value['user']);
                }
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: Util.basePaddingMargin10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: Util.baseWidthHeight48,
                    height: Util.baseWidthHeight48,
                    padding: EdgeInsets.symmetric(
                      vertical: Util.basePaddingMargin16,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Palette.blue,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      user.initialName!,
                      style: TextStyle(
                        color: Palette.white,
                        fontWeight: FontWeight.w500,
                        fontSize: Util.baseTextSize14,
                      ),
                    ),
                  ),
                  SizedBox(width: Util.basePaddingMargin8),
                  RichText(
                    text: TextSpan(
                      text: "${user.firstName!}",
                      style: TextStyle(
                        color: Palette.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: Util.baseTextSize14,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: " ${user.lastName!}",
                          style: TextStyle(
                            color: Palette.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: Util.baseTextSize14,
                          ),
                        ),
                        cubit.user.email! == user.email
                            ? TextSpan(
                                text: " (you)",
                                style: TextStyle(
                                    color: Palette.grey,
                                    fontWeight: FontWeight.w500,
                                    fontSize: Util.baseTextSize14,
                                    fontStyle: FontStyle.italic),
                              )
                            : TextSpan(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget contentInputField(BuildContext context, ContactCubit cubit) {
    return Container(
      child: TextFormField(
        controller: cubit.searchController,
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
            borderSide: BorderSide(color: Palette.blue),
            borderRadius: BorderRadius.circular(Util.baseRoundedCorner15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Palette.blue),
            borderRadius: BorderRadius.circular(Util.baseRoundedCorner15),
          ),
          suffixIcon: Image.asset("assets/icons/ic_search_grey.png"),
          hintText: "Search your contact list...",
          hintStyle: TextStyle(
            color: Palette.grey,
            fontSize: Util.baseTextSize14,
          ),
        ),
      ),
    );
  }
}
