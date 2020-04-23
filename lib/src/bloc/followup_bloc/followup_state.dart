import 'package:equatable/equatable.dart';
import 'package:salles_tools/src/models/classification_followup_model.dart';
import 'package:salles_tools/src/models/followup_methode_model.dart';

class FollowupState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FollowupInitial extends FollowupState {

}

class FollowupLoading extends FollowupState {

}

class FollowupDisposeLoading extends FollowupState {

}

class FollowupFailed extends FollowupState {

}

class FollowupError extends FollowupState {

}

class FollowupMethodeSuccess extends FollowupState {
  final _data;

  FollowupMethodeSuccess(this._data);
  FollowUpMethodeModel get value => _data;

  @override
  // TODO: implement props
  List<Object> get props => [_data];
}

class ClassificationFollowupSuccess extends FollowupState {
  final _data;

  ClassificationFollowupSuccess(this._data);
  ClassificationFollowUpModel get value => _data;

  @override
  // TODO: implement props
  List<Object> get props => [_data];
}

class UpdateFollowupSuccess extends FollowupState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class UpdateFollowupError extends FollowupState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}