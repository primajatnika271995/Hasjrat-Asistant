import 'package:equatable/equatable.dart';
import 'package:salles_tools/src/models/customer_model.dart';
import 'package:salles_tools/src/models/error_model.dart';

class CustomerState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CustomerInitial extends CustomerState {}

class CustomerLoading extends CustomerState {}

class CustomerDisposeLoading extends CustomerState {}

class CustomerFailed extends CustomerState {}


class CustomerSuccess extends CustomerState {
  final _data;

  CustomerSuccess(this._data);
  CustomerModel get value => _data;

  @override
  // TODO: implement props
  List<Object> get props => [_data];
}

class CustomerError extends CustomerState {
  final _data;

  CustomerError(this._data);
  ErrorModel get error => _data;

  @override
  // TODO: implement props
  List<Object> get props => [_data];
}