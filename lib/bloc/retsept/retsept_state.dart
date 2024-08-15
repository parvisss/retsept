import 'package:equatable/equatable.dart';
import 'package:retsept_cherno/data/models/retsept_model.dart';

abstract class RetseptState extends Equatable {
  const RetseptState();

  @override
  List<Object> get props => [];
}

class RetseptInitial extends RetseptState {}

class RetseptLoading extends RetseptState {}

class RetseptLoaded extends RetseptState {  
  final List<RetseptModel> retsepts;
  
  const RetseptLoaded(this.retsepts);
  
  @override
  List<RetseptModel> get props => [...retsepts];
}

class RetseptError extends RetseptState {
  final String message;

  const RetseptError(this.message);

  @override
  List<Object> get props => [message];
}
