import 'package:equatable/equatable.dart';
import 'package:salles_tools/src/services/dashboard_service.dart';

class TargetDashboardEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FetchTargetDashboard extends TargetDashboardEvent {
  final TargetDashboardPost value;

  FetchTargetDashboard(this.value);

  @override
  // TODO: implement props
  List<Object> get props => [value];
}
