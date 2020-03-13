import 'package:equatable/equatable.dart';
import 'package:salles_tools/src/services/customer_service.dart';

class LeadEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FetchLead extends LeadEvent {
  final LeadPost value;

  FetchLead(this.value);

  @override
  // TODO: implement props
  List<Object> get props => [value];
}

class ResetLead extends LeadEvent {}