import 'package:equatable/equatable.dart';

abstract class RetseptState extends Equatable {
  const RetseptState();

  @override
  List<Object> get props => [];
}

class RetseptInitial extends RetseptState {}

class RetseptLoading extends RetseptState {}

class RetseptLoaded extends RetseptState {
  final List<Map<String, dynamic>> retsepts;

  const RetseptLoaded(this.retsepts);

  @override
  List<Object> get props => [retsepts];
}

class RetseptError extends RetseptState {
  final String message;

  const RetseptError(this.message);

  @override
  List<Object> get props => [message];
}
