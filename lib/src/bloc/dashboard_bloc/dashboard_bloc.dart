import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salles_tools/src/bloc/dashboard_bloc/dashboard_event.dart';
import 'package:salles_tools/src/bloc/dashboard_bloc/dashboard_state.dart';
import 'package:salles_tools/src/models/dashboard_model.dart';
import 'package:salles_tools/src/services/dashboard_service.dart';
import 'package:salles_tools/src/views/components/log.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardService _dashboardService;
  DashboardBloc(this._dashboardService);
  @override
  // TODO: implement initialState
  DashboardState get initialState => DashboardInitial();

  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event) async* {
    if (event is FetchDashboard) {
      yield DashboardLoading();

      try {
        DashboardModel value = await _dashboardService.fetchDashboard();
        if (value == null) {
          yield DashboardFailed();
        } else {
          yield DashboardDisposeLoading();
          yield DashboardSuccess(value);
        }
      } catch (e) {
        log.warning("Error Bloc Dashboard : ${e.toString()}");
        yield DashboardFailed();
      }
    }
  }
}
