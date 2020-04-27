import 'package:equatable/equatable.dart';
import 'package:salles_tools/src/models/dashboard_model.dart';
import 'package:salles_tools/src/models/dashboard_target_model.dart';

class DashboardState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardDisposeLoading extends DashboardState {}

class DashboardFailed extends DashboardState {}

class DashboardSuccess extends DashboardState {
  final _data;

  DashboardSuccess(this._data);
  DashboardModel get value => _data;

  @override
  // TODO: implement props
  List<Object> get props => [_data];
}

class TargetDashboardFailed extends DashboardState {}

class TargetDashboardSuccess extends DashboardState {
  final _data;

  TargetDashboardSuccess(this._data);
  TargetDashboardModel get value => _data;

  @override
  // TODO: implement props
  List<Object> get props => [_data];
}
