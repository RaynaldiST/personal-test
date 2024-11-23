import 'package:equatable/equatable.dart';

abstract class DetailContactState extends Equatable {
  const DetailContactState();
}

class DetailContactLoading extends DetailContactState {
  @override
  List<Object?> get props => [];
}

class DetailContactLoaded extends DetailContactState {
  @override
  List<Object?> get props => [];
}
