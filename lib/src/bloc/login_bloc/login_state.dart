import 'package:equatable/equatable.dart';
import 'package:salles_tools/src/models/authentication_model.dart';
import 'package:salles_tools/src/models/change_password_model.dart';
import 'package:salles_tools/src/models/error_model.dart';
import 'package:salles_tools/src/models/histori_login_model.dart';

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
  AuthenticationModel get error => _data;

  @override
  // TODO: implement props
  List<Object> get props => [_data];
}

class LoginSuccess extends LoginState {
  final _data;

  LoginSuccess(this._data);
  AuthenticationModel get authenticated => _data;

  @override
  // TODO: implement props
  List<Object> get props => [_data];
}

class ChangePasswordSuccess extends LoginState {
  final _data;

  ChangePasswordSuccess(this._data);
  ChangePasswordModel get _model => _data;

  @override
  // TODO: implement props
  List<Object> get props => [_data];
}

class HistoryLogout extends LoginState {
  final _data;

  HistoryLogout(this._data);
  HistoriLoginModel get _model => _data;

  @override
  // TODO: implement props
  List<Object> get props => super.props;
}

class ChangePasswordFailed extends LoginState {

}
