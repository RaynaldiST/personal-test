import 'package:equatable/equatable.dart';

abstract class ContactState extends Equatable {
  const ContactState();
}

class ContactLoading extends ContactState {
  @override
  List<Object?> get props => [];
}

class ContactLoaded extends ContactState {
  @override
  List<Object?> get props => [];
}
