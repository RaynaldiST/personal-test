import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileLoading extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileLoaded extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileUnauthenticated extends ProfileState {
  @override
  List<Object?> get props => [];
}
