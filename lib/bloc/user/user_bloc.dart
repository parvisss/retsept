import 'package:bloc/bloc.dart';
import 'package:retsept_cherno/services/firestore/user_firestore.dart';

import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserFirestore userService;

  UserBloc(this.userService) : super(UserInitial()) {
    on<AddUserEvent>(_onAddUser);
    on<FetchUserDataEvent>(_onFetchUserData);
  }

  void _onAddUser(AddUserEvent event, Emitter<UserState> emit) async {
    // on add it adds new user by service that we created
    emit(UserLoading());
    try {
      await userService.addUser(event.user);
      emit(const UserLoaded({}));
    } catch (e) {
      emit(UserError('Failed to add user: $e'));
    }
  }

  void _onFetchUserData(
      FetchUserDataEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final userData = await userService.getUserData();
      emit(UserLoaded(userData));
    } catch (e) {
      emit(UserError('Failed to fetch user data: $e'));
    }
  }
}
