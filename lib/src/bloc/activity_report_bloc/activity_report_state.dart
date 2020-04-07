import 'package:equatable/equatable.dart';
import 'package:salles_tools/src/models/activity_report_model.dart';

class ActivityReportState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ActivityReportInitial extends ActivityReportState {

}

class ActivityReportLoading extends ActivityReportState {

}

class ActivityReportDisposeLoading extends ActivityReportState {

}

class ActivityReportFailed extends ActivityReportState {

}

class ActivityReportError extends ActivityReportState {

}

class ActivityReportSuccess extends ActivityReportState {
  final _data;

  ActivityReportSuccess(this._data);
  ActivityReportModel get value => _data;

  @override
  List<Object> get props => [_data];
}

class CreateActivityReportSuccess extends ActivityReportState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CreateActivityReportError extends ActivityReportState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}