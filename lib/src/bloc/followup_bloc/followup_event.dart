import 'package:equatable/equatable.dart';
import 'package:salles_tools/src/services/followup_service.dart';

class FollowupEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FetchFollowupMethode extends FollowupEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FetchClassificationFollowup extends FollowupEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class UpdateFollowup extends FollowupEvent {
  final FollowUpParams value;
  UpdateFollowup(this.value);

  @override
  // TODO: implement props
  List<Object> get props => [value];
}