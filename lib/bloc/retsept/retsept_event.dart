import 'package:equatable/equatable.dart';
import 'package:retsept_cherno/data/models/retsept_model.dart';

abstract class RetseptEvent extends Equatable {
  const RetseptEvent();

  @override
  List<Object> get props => [];
}

// Event to add a retsept
class AddRetseptEvent extends RetseptEvent {
  final RetseptModel retsept;

  const AddRetseptEvent(this.retsept);

  @override
  List<Object> get props => [retsept];
}

// Event to delete a retsept
class DeleteRetseptEvent extends RetseptEvent {
  final String id;

  const DeleteRetseptEvent(this.id);

  @override
  List<Object> get props => [id];
}

//event to edit retsept
class EditRetseptEvent extends RetseptEvent {
  final String id;
  final RetseptModel retsept;
  const EditRetseptEvent({required this.id, required this.retsept});
  @override
  List<Object> get props => [id, retsept];
}

// Event to stream retsepts
class LoadRetsepts extends RetseptEvent {}
