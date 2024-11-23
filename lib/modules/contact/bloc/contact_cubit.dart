import 'dart:async';

import 'package:test_project/component/bloc/base_cubit.dart';
import 'package:test_project/modules/contact/bloc/contact_state.dart';

class ContactCubit extends BaseCubit<ContactState> {
  ContactCubit() : super(ContactLoading());

  @override
  FutureOr<void> initCubit() {}

  @override
  FutureOr<void> loadCubit() {}

  @override
  FutureOr<void> postCubit() {}
}
