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

class DetailContactInvalid extends DetailContactState {
  @override
  List<Object?> get props => [];
}

class DetailContactValid extends DetailContactState {
  @override
  List<Object?> get props => [];
}

class DetailContactDelete extends DetailContactState {
  @override
  List<Object?> get props => [];
}

class DetailContactUpdated extends DetailContactState {
  @override
  List<Object?> get props => [];
}
