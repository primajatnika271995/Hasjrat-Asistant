import 'package:equatable/equatable.dart';
import 'package:salles_tools/src/models/authentication_model.dart';
import 'package:salles_tools/src/models/employee_model.dart';

class RegisterState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {

}

class RegisterLoading extends RegisterState {

}

class RegisterFailed extends RegisterState {

}

class RegisterSuccess  extends RegisterState {
  final _data;

  RegisterSuccess(this._data);
  EmployeeModel get _employee => _data;

  @override
  // TODO: implement props
  List<Object> get props => [_data];
}

class CheckNIKLoading extends RegisterState {

}

class CheckNIKFailed extends RegisterState {

}

class CheckNIKSuccess  extends RegisterState {
  final _data;

  CheckNIKSuccess(this._data);
  EmployeeModel get _employee => _data;

  @override
  // TODO: implement props
  List<Object> get props => [_data];
}
