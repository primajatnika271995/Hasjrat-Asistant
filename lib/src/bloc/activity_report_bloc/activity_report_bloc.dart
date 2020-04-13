import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salles_tools/src/bloc/activity_report_bloc/activity_report_event.dart';
import 'package:salles_tools/src/bloc/activity_report_bloc/activity_report_state.dart';
import 'package:salles_tools/src/models/activity_report_model.dart';
import 'package:salles_tools/src/models/upload_media_model.dart';
import 'package:salles_tools/src/services/activity_report_service.dart';
import 'package:salles_tools/src/services/upload_media_service.dart';
import 'package:salles_tools/src/views/components/log.dart';

class ActivityReportBloc extends Bloc<ActivityReportEvent, ActivityReportState> {
  ActivityReportService _activityReportService;
  ActivityReportBloc(this._activityReportService);

  @override
  // TODO: implement initialState
  ActivityReportState get initialState => ActivityReportInitial();

  @override
  Stream<ActivityReportState> mapEventToState(ActivityReportEvent event) async* {
    if (event is FetchActivityReport) {
      yield ActivityReportLoading();

      try {
        ActivityReportModel value = await _activityReportService.activityReport(event.branchCode, event.outletCode);

        if (value.data.isEmpty || value.data == null) {
          yield ActivityReportDisposeLoading();
          yield ActivityReportFailed();
        } else {
          yield ActivityReportDisposeLoading();
          yield ActivityReportSuccess(value);
        }
      } catch(error) {
        log.warning("Error : ${error.toString()}");
        yield ActivityReportDisposeLoading();
        yield ActivityReportError();
      }
    }

    if (event is CreateActivityReport) {
      yield ActivityReportLoading();

      try {
        await _activityReportService.createActivityReport(event.value);

        yield ActivityReportDisposeLoading();
        yield CreateActivityReportSuccess();
      } catch(error) {
        yield ActivityReportDisposeLoading();
        yield CreateActivityReportError();
        log.warning("Error : ${error.toString()}");
      }
    }

    if (event is UploadActivityReport) {
      yield ActivityReportLoading();

      try {
        UploadMediaModel value =  await _activityReportService.uploadFile(event.value);

        yield ActivityReportDisposeLoading();
        yield UploadActivityReportSuccess(value);
      } catch(error) {
        yield ActivityReportDisposeLoading();
        yield UploadActivityReportError();
        log.warning("Error : ${error.toString()}");
      }
    }
  }
}