import 'package:bloc/bloc.dart';
import 'package:retsept_cherno/services/firestore/retsept/like_retsept.dart';
import 'package:retsept_cherno/services/firestore/retsept/retsept_firebase.dart';
import 'package:retsept_cherno/services/firestore/retsept/send_coment_service.dart';
import 'retsept_event.dart';
import 'retsept_state.dart';

class RetseptBloc extends Bloc<RetseptEvent, RetseptState> {
  final RetseptFirebase retseptService;

  RetseptBloc(this.retseptService) : super(RetseptInitial()) {
    on<AddRetseptEvent>(_onAddRetsept);
    on<EditRetseptEvent>(_onEditRetsept);
    on<DeleteRetseptEvent>(_onDeleteRetsept);
    on<LoadRetsepts>(_onLoadRetsepts);
    on<LikeRetseptEvent>(_onLikeRetsept);
    on<ComentRetseptEvent>(_onSendComent);
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
    } catch (e) {
      emit(RetseptError(e.toString()));
    }
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
    emit(RetseptLoading());
    try {
      final retsept = await retseptService.getRetsepts();
      emit(RetseptLoaded(retsept));
    } catch (e) {
      emit(RetseptError(e.toString()));
    }
  }

  void _onLikeRetsept(
      LikeRetseptEvent event, Emitter<RetseptState> emit) async {
    try {
      await LikeRetsept().likeRetsept(event.retseptId, event.isLike);
      add(LoadRetsepts());
    } catch (e) {
      emit(RetseptError(e.toString()));
    }
  }

  void _onSendComent(
      ComentRetseptEvent event, Emitter<RetseptState> emit) async {
    try {
      await SendComentService()
          .sendComent(retseptId: event.retseptId, coment: event.coment);
      final retsept = await retseptService.getRetsepts();
      emit(RetseptLoaded(retsept));
    } catch (e) {
      emit(RetseptError(e.toString()));
    }
  }
}
