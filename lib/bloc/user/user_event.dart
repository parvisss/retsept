import 'package:equatable/equatable.dart';
import 'package:retsept_cherno/data/models/user_model.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

//Evehnt to add user
class AddUserEvent extends UserEvent {
  final UserModel user;
  AddUserEvent({required this.user});
  @override
  List<Object> get props => [user];
}

//event to fetch user data
class FetchUserDataEvent extends UserEvent {}

class LoadUserDataEvent extends UserEvent {}
