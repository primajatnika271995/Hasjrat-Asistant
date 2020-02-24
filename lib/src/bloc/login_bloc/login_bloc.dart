import 'package:bloc/bloc.dart';
import 'package:salles_tools/src/bloc/login_bloc/login_event.dart';
import 'package:salles_tools/src/bloc/login_bloc/login_state.dart';
import 'package:salles_tools/src/models/authentication_model.dart';
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

        yield LoginSuccess(value);
      } catch(err) {
        log.warning(err.toString());
        yield LoginFailed();
      }
    }
  }
}