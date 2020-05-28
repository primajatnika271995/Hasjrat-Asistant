import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salles_tools/src/bloc/followup_bloc/followup_event.dart';
import 'package:salles_tools/src/bloc/followup_bloc/followup_state.dart';
import 'package:salles_tools/src/models/classification_followup_model.dart';
import 'package:salles_tools/src/models/followup_methode_model.dart';
import 'package:salles_tools/src/models/followup_reminder_model.dart';
import 'package:salles_tools/src/services/followup_service.dart';
import 'package:salles_tools/src/views/components/log.dart';

class FollowupBloc extends Bloc<FollowupEvent, FollowupState> {
  FollowupService _followupService;
  FollowupBloc(this._followupService);

  @override
  // TODO: implement initialState
  FollowupState get initialState => FollowupInitial();

  @override
  Stream<FollowupState> mapEventToState(FollowupEvent event) async* {
    if (event is FetchFollowupReminder) {
      try {
        FollowUpReminderModel value = await _followupService.followUpReminderList();

        if (value.data.isEmpty || value.data == null) {
          yield FollowupFailed();
        } else {
          yield FollowupReminderSuccess(value);
        }
      } catch(error) {
        log.warning("Error : ${error.toString()}");
      }
    }

    if (event is FetchClassificationFollowup) {
      try {
        ClassificationFollowUpModel value = await _followupService.classificationList();

        if (value.data.isEmpty || value.data == null) {
          yield FollowupFailed();
        } else {
          yield ClassificationFollowupSuccess(value);
        }
      } catch(error) {
        log.warning("Error : ${error.toString()}");
      }
    }

    if (event is FetchFollowupMethode) {
      try {
        FollowUpMethodeModel value = await _followupService.followUpMethodeList();

        if (value.data.isEmpty || value.data == null) {
          yield FollowupFailed();
        } else {
          yield FollowupMethodeSuccess(value);
        }
      } catch(error) {
        log.warning("Error : ${error.toString()}");
      }
    }

    if (event is UpdateFollowup) {
      yield FollowupLoading();

      try {
        await _followupService.updateFollowup(event.value);

        yield FollowupDisposeLoading();
        yield UpdateFollowupSuccess();
      } catch(error) {
        yield FollowupDisposeLoading();
        yield UpdateFollowupError();
        log.warning("Error : ${error.toString()}");
      }
    }
  }
}