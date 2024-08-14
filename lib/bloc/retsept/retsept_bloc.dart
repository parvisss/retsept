import 'package:bloc/bloc.dart';
import 'package:retsept_cherno/services/firestore/retsept_firestore.dart';
import 'retsept_event.dart';
import 'retsept_state.dart';

class RetseptBloc extends Bloc<RetseptEvent, RetseptState> {
  final RetseptFirestore retseptService;

  RetseptBloc(this.retseptService) : super(RetseptInitial()) {
    on<AddRetseptEvent>(_onAddRetsept);
    on<EditRetseptEvent>(_onEditRetsept);
    on<DeleteRetseptEvent>(_onDeleteRetsept);
    on<StreamRetseptsEvent>(_onStreamRetsepts);
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

  Stream _onStreamRetsepts(
      StreamRetseptsEvent event, Emitter<RetseptState> emit) async* {
    try {
      await for (final retsepts in retseptService.getRawRetseptsStream()) {
        yield RetseptLoaded(retsepts);
      }
    } catch (e) {
      yield RetseptError('Failed to stream retsepts: $e');
    }
  }
}
