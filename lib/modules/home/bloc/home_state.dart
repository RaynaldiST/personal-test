import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeLoading extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeLoaded extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeFirstPage extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeSecondPage extends HomeState {
  @override
  List<Object?> get props => [];
}
