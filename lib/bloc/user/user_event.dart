import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repostory.dart';

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
class FetchUserDataEvent extends UserEvent {}
