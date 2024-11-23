import 'dart:async';

import 'package:test_project/component/bloc/base_cubit.dart';
import 'package:test_project/modules/auth/bloc/auth_state.dart';

class AuthCubit extends BaseCubit<AuthState> {
  AuthCubit() : super(AuthLoading());

  @override
  FutureOr<void> initCubit() {}

  @override
  FutureOr<void> loadCubit() {}

  @override
  FutureOr<void> postCubit() {}
}
