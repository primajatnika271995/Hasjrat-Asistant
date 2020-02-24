import 'package:equatable/equatable.dart';

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

class ResetRegister extends RegisterEvent {}
