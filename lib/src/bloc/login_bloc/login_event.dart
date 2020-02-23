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

class ResetLogin extends LoginEvent {}
