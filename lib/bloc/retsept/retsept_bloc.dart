import 'package:bloc/bloc.dart';
import 'package:retsept_cherno/services/firestore/retsept_firebase.dart';
import 'retsept_event.dart';
import 'retsept_state.dart';

class RetseptBloc extends Bloc<RetseptEvent, RetseptState> {
  final RetseptFirebase retseptService;

  RetseptBloc(this.retseptService) : super(RetseptInitial()) {
    on<AddRetseptEvent>(_onAddRetsept);
    on<EditRetseptEvent>(_onEditRetsept);
    on<DeleteRetseptEvent>(_onDeleteRetsept);
    on<LoadRetsepts>(_onLoadRetsepts);
  }

  void _onAddRetsept(AddRetseptEvent event, Emitter<RetseptState> emit) async {
    emit(RetseptLoading());
    try {
      await retseptService.addRetsept(event.retsept);
    } catch (e) {
      emit(RetseptError('Failed to add retsept: $e'));
    }
  }

  void _onEditRetsept(
      EditRetseptEvent event, Emitter<RetseptState> emit) async {
    try {
      await retseptService.editRetsept(event.id, event.retsept);
    } catch (e) {}
  }

  void _onDeleteRetsept(
      DeleteRetseptEvent event, Emitter<RetseptState> emit) async {
    emit(RetseptLoading());
    try {
      await retseptService.deleteRetsept(event.id);
    } catch (e) {
      emit(RetseptError('Failed to delete retsept: $e'));
    }
  }

  _onLoadRetsepts(LoadRetsepts event, Emitter<RetseptState> emit) async {
    try {
      final retsept = await retseptService.getRetsepts();
      print(retsept.first);
      emit(RetseptLoaded(retsept));
    } catch (e) {
      print("error : $e");
    }
  }
}
