import 'package:equatable/equatable.dart';
import 'package:salles_tools/src/services/login_service.dart';

class RegisterEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CheckNIK extends RegisterEvent {
  final username;

  CheckNIK(this.username);

  @override
  // TODO: implement props
  List<Object> get props => [username];

}

class PostRegister extends RegisterEvent {
  final RegisterPost value;

  PostRegister(this.value);

  @override
  // TODO: implement props
  List<Object> get props => [value];
}

class ResetRegister extends RegisterEvent {}
