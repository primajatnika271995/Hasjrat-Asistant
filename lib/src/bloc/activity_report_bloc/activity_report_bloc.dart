import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salles_tools/src/bloc/activity_report_bloc/activity_report_event.dart';
import 'package:salles_tools/src/bloc/activity_report_bloc/activity_report_state.dart';
import 'package:salles_tools/src/models/activity_report_model.dart';
import 'package:salles_tools/src/services/activity_report_service.dart';
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
        ActivityReportModel value = await _activityReportService.activityReport();

        if (value.data.isEmpty || value.data == null) {
          yield ActivityReportFailed();
        } else {
          yield ActivityReportDisposeLoading();
          yield ActivityReportSuccess(value);
        }
      } catch(error) {
        log.warning("Error : ${error.toString()}");
        yield ActivityReportError();
      }
    }

    if (event is CreateActivityReport) {
      yield ActivityReportFailed();

      try {
        await _activityReportService.createActivityReport(event.value);

        yield CreateActivityReportSuccess();
      } catch(error) {
        yield ActivityReportDisposeLoading();
        yield CreateActivityReportError();
        log.warning("Error : ${error.toString()}");
      }
    }
  }
}