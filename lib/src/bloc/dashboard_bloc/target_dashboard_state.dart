import 'package:equatable/equatable.dart';
import 'package:salles_tools/src/models/dashboard_target_model.dart';

class TargetDashboardState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class TargetDashboardInitial extends TargetDashboardState {}

class TargetDashboardLoading extends TargetDashboardState {}

class TargetDashboardDisposeLoading extends TargetDashboardState {}


class TargetDashboardFailed extends TargetDashboardState {}

class TargetDashboardSuccess extends TargetDashboardState {
  final _data;

  TargetDashboardSuccess(this._data);
  TargetDashboardModel get value => _data;

  @override
  // TODO: implement props
  List<Object> get props => [_data];
}
