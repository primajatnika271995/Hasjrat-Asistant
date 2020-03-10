import 'package:equatable/equatable.dart';
import 'package:salles_tools/src/models/authentication_model.dart';
import 'package:salles_tools/src/models/error_model.dart';

class LoginState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoginInitial extends LoginState {

}

class LoginLoading extends LoginState {

}

class LoginFailed extends LoginState {

}

class LoginError extends LoginState {
  final _data;

  LoginError(this._data);
  ErrorModel get error => _data;

  @override
  // TODO: implement props
  List<Object> get props => [_data];
}

class LoginSuccess  extends LoginState {
  final _data;

  LoginSuccess(this._data);
  AuthenticationModel get _authenticated => _data;

  @override
  // TODO: implement props
  List<Object> get props => [_data];
}
