import 'package:bloc/bloc.dart';
import 'package:salles_tools/src/bloc/login_bloc/login_event.dart';
import 'package:salles_tools/src/bloc/login_bloc/login_state.dart';
import 'package:salles_tools/src/models/authentication_model.dart';
import 'package:salles_tools/src/models/employee_model.dart';
import 'package:salles_tools/src/models/error_model.dart';
import 'package:salles_tools/src/services/login_service.dart';
import 'package:salles_tools/src/utils/shared_preferences_helper.dart';
import 'package:salles_tools/src/views/components/log.dart';

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

        await SharedPreferencesHelper.setAccessToken(value.accessToken);
        await SharedPreferencesHelper.setUsername(event.username);
        await SharedPreferencesHelper.setPassword(event.password);

        EmployeeModel employee = await loginService.checkNIK(event.username);
        await SharedPreferencesHelper.setSalesName(employee.name);
        await SharedPreferencesHelper.setSalesNIK(employee.id);
        await SharedPreferencesHelper.setSalesBirthday(employee.birthDate.toString());
        await SharedPreferencesHelper.setSalesGender(employee.jenisKelamin);
        await SharedPreferencesHelper.setSalesBrach(employee.branch.name);
        await SharedPreferencesHelper.setSalesBrachId(employee.branch.id);
        await SharedPreferencesHelper.setSalesOutlet(employee.outlet.name);
        await SharedPreferencesHelper.setSalesJob(employee.section.newName);

        yield LoginSuccess(value);
      } catch(err) {
        log.warning(err.toString());
        yield LoginFailed();
      }
    }
  }
}
