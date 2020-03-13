import 'package:equatable/equatable.dart';
import 'package:salles_tools/src/models/error_model.dart';
import 'package:salles_tools/src/models/lead_model.dart';

class LeadState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LeadInitial extends LeadState {}

class LeadLoading extends LeadState {}

class LeadDisposeLoading extends LeadState {}

class LeadFailed extends LeadState {}

class LeadSuccess extends LeadState {
  final _data;

  LeadSuccess(this._data);
  LeadModel get value => _data;

  @override
  // TODO: implement props
  List<Object> get props => [_data];
}

class CustomerError extends LeadState {
  final _data;

  CustomerError(this._data);
  ErrorModel get error => _data;

  @override
  // TODO: implement props
  List<Object> get props => [_data];
}