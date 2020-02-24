import 'package:bloc/bloc.dart';
import 'package:salles_tools/src/bloc/register_bloc/register_event.dart';
import 'package:salles_tools/src/bloc/register_bloc/register_state.dart';
import 'package:salles_tools/src/models/employee_model.dart';
import 'package:salles_tools/src/services/login_service.dart';
import 'package:salles_tools/src/utils/shared_preferences_helper.dart';
import 'package:salles_tools/src/views/components/log.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  LoginService loginService;
  RegisterBloc(this.loginService);

  @override
  // TODO: implement initialState
  RegisterState get initialState => RegisterInitial();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is CheckNIK) {
      yield CheckNIKLoading();

      try {
        EmployeeModel value = await loginService.checkNIK(event.username);

        yield CheckNIKSuccess(value);
      } catch(err) {
        log.warning(err.toString());
        yield CheckNIKFailed();
      }
    }
  }
}
