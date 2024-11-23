import 'package:equatable/equatable.dart';

abstract class MainState extends Equatable {
  const MainState();
}

class MainLoading extends MainState {
  @override
  List<Object?> get props => [];
}

class MainLoaded extends MainState {
  @override
  List<Object?> get props => [];
}

class MainUnauthenticated extends MainState {
  @override
  List<Object?> get props => [];
}

class MainAuthenticated extends MainState {
  @override
  List<Object?> get props => [];
}
