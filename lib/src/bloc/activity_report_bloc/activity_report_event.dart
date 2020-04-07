import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:salles_tools/src/services/activity_report_service.dart';

class ActivityReportEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FetchActivityReport extends ActivityReportEvent {
  @override
  List<Object> get props => [];
}

class UploadActivityReport extends ActivityReportEvent {
  final File value;
  UploadActivityReport(this.value);

  @override
  // TODO: implement props
  List<Object> get props => [value];
}

class CreateActivityReport extends ActivityReportEvent {
  final ActivityReportPost value;
  CreateActivityReport(this.value);

  @override
  // TODO: implement props
  List<Object> get props => [value];
}