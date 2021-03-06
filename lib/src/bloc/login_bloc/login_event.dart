import 'package:equatable/equatable.dart';

class LoginEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FetchLogin extends LoginEvent {
  final username;
  final password;

  FetchLogin(this.username, this.password);

  @override
  // TODO: implement props
  List<Object> get props => [username, password];

}

class FetchLogout extends LoginEvent {
  final idHistory;
  final deviceInfo;
  final imei;
  final latitudeLogout;
  final longitudeLogout;

  FetchLogout(this.idHistory, this.deviceInfo, this.imei, this.latitudeLogout, this.longitudeLogout);

  @override
  // TODO: implement props
  List<Object> get props => [idHistory];
}

class ChangePassword extends LoginEvent {
  final password;
  final username;

  ChangePassword(this.password, this.username);

  @override
  // TODO: implement props
  List<Object> get props => [password, username];
}

class ResetLogin extends LoginEvent {}
