import 'package:bloc/bloc.dart';
import 'package:salles_tools/src/bloc/login_bloc/login_event.dart';
import 'package:salles_tools/src/bloc/login_bloc/login_state.dart';
import 'package:salles_tools/src/models/authentication_model.dart';
import 'package:salles_tools/src/models/change_password_model.dart';
import 'package:salles_tools/src/models/employee_model.dart';
import 'package:salles_tools/src/models/error_model.dart';
import 'package:salles_tools/src/models/histori_login_model.dart';
import 'package:salles_tools/src/services/login_service.dart';
import 'package:salles_tools/src/utils/shared_preferences_helper.dart';
import 'package:salles_tools/src/views/components/log.dart';

import '../../utils/shared_preferences_helper.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginService loginService;
  LoginBloc(this.loginService);

  @override
  // TODO: implement initialState
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is FetchLogin) {
      yield LoginLoading();

      try {
        AuthenticationModel value = await loginService.login(event.username, event.password);

        if (value.accessToken != null) {
          await SharedPreferencesHelper.setAccessToken(value.accessToken);
          await SharedPreferencesHelper.setUsername(event.username);
          await SharedPreferencesHelper.setPassword(event.password);

          EmployeeModel employee = await loginService.checkNIK(event.username);
          log.info(employee.id);
          await SharedPreferencesHelper.setSalesName(employee.name);
          await SharedPreferencesHelper.setSalesNIK(employee.id);
          await SharedPreferencesHelper.setSalesBirthday(employee.birthDate.toString());
          await SharedPreferencesHelper.setSalesGender(employee.jenisKelamin);

          await SharedPreferencesHelper.setSalesBrach(employee.branch.name);
          await SharedPreferencesHelper.setSalesBrachId(employee.branch.id);

          await SharedPreferencesHelper.setSalesOutlet(employee.outlet.name);
          await SharedPreferencesHelper.setSalesOutletId(employee.outlet.id);

          await SharedPreferencesHelper.setSalesJob(employee.section.newName);
          await SharedPreferencesHelper.setSalesJoinDate(employee.joinDate);

          await SharedPreferencesHelper.setSalesGrading(employee.grading);
          await SharedPreferencesHelper.setSalesContact(employee.contact);

          var imei = await SharedPreferencesHelper.getImeiDevice();
          var deviceInfo = await SharedPreferencesHelper.getDeviceInfo();
          var latitudeLogin = await SharedPreferencesHelper.getLatitudeLogin();
          var longitudeLogin = await SharedPreferencesHelper.getLongitudeLogin();

          log.info(latitudeLogin);

//          HistoriLoginModel histori = await loginService.historyLogin(
//            employee.branch.id,
//            employee.branch.name,
//            deviceInfo,
//            employee.id,
//            imei,
//            latitudeLogin,
//            longitudeLogin,
//            employee.outlet.id,
//            employee.outlet.name,
//          );

//          await SharedPreferencesHelper.setHistoryLoginId(histori.id);

          yield LoginSuccess(value);
        } else {
          log.warning(value.errorDescription);
          yield LoginError(value);
        }
      } catch (err) {
        log.warning(err.toString());
        yield LoginFailed();
      }
    }

    if (event is ChangePassword) {
      yield LoginLoading();

      try {
        ChangePasswordModel value = await loginService.changePassword(event.username, event.password);

        yield ChangePasswordSuccess(value);
      } catch (err) {
        log.warning(err.toString());
        yield ChangePasswordFailed();
      }
    }

    if (event is FetchLogout) {
      try {
        HistoriLoginModel value = await loginService.historyLogout(event.idHistory, event.deviceInfo, event.imei, event.latitudeLogout, event.longitudeLogout);

        await SharedPreferencesHelper.setAccessToken(null);
      } catch (err) {
        log.warning(err.toString());
      }
    }
  }
}
