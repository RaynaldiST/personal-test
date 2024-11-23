import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoaded extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthAuthenticate extends AuthState {
  @override
  List<Object?> get props => [];
}
