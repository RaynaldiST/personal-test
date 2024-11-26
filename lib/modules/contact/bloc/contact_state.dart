import 'package:equatable/equatable.dart';
import 'package:test_project/component/data/models/user.dart';

abstract class ContactState extends Equatable {
  const ContactState();
}

class ContactLoading extends ContactState {
  @override
  List<Object?> get props => [];
}

class ContactLoaded extends ContactState {
  final List<User> users;

  ContactLoaded(this.users);

  @override
  List<Object?> get props => [users];
}

class ContactSearchStart extends ContactState {
  @override
  List<Object?> get props => [];
}

class ContactSearchLoading extends ContactState {
  @override
  List<Object?> get props => [];
}

class ContactSearchLoaded extends ContactState {
  final List<User> users;

  ContactSearchLoaded(this.users);

  @override
  List<Object?> get props => [users];
}
