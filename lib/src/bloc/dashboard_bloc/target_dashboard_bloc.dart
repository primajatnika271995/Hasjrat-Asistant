import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salles_tools/src/bloc/dashboard_bloc/target_dashboard_event.dart';
import 'package:salles_tools/src/bloc/dashboard_bloc/target_dashboard_state.dart';
import 'package:salles_tools/src/models/dashboard_target_model.dart';
import 'package:salles_tools/src/services/dashboard_service.dart';
import 'package:salles_tools/src/views/components/log.dart';

class TargetDashboardBloc
    extends Bloc<TargetDashboardEvent, TargetDashboardState> {
  DashboardService _dashboardService;
  TargetDashboardBloc(this._dashboardService);
  @override
  // TODO: implement initialState
  TargetDashboardState get initialState => TargetDashboardInitial();

  @override
  Stream<TargetDashboardState> mapEventToState(
      TargetDashboardEvent event) async* {
    if (event is FetchTargetDashboard) {
      yield TargetDashboardLoading();

      try {
        TargetDashboardModel value =
            await _dashboardService.fetchTargetDashboard(event.value);
        if (value == null) {
          yield TargetDashboardFailed();
        } else {
          yield TargetDashboardDisposeLoading();
          yield TargetDashboardSuccess(value);
        }
      } catch (e) {
        log.warning("Error Bloc Target Dashboard : ${e.toString()}");
        yield TargetDashboardFailed();
      }
    }
  }
}
