import 'package:equatable/equatable.dart';
import 'package:salles_tools/src/services/dashboard_service.dart';

class DashboardEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FetchDashboard extends DashboardEvent {
  final DashboardPost value;

  FetchDashboard(this.value);
  @override
  // TODO: implement props
  List<Object> get props => [value];
}
