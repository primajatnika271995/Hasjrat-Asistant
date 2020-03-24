import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salles_tools/src/bloc/booking_bloc/booking_drive_event.dart';
import 'package:salles_tools/src/bloc/booking_bloc/booking_drive_state.dart';
import 'package:salles_tools/src/models/test_drive_model.dart';
import 'package:salles_tools/src/services/booking_drive_service.dart';
import 'package:salles_tools/src/views/components/log.dart';

class BookingDriveBloc extends Bloc<BookingDriveEvent, BookingDriveState> {
  BookingDriveService _bookingDriveService;
  BookingDriveBloc(this._bookingDriveService);
  @override
  // TODO: implement initialState
  BookingDriveState get initialState => BookingDriveInitial();

  @override
  Stream<BookingDriveState> mapEventToState(BookingDriveEvent event) async* {
    // TODO: implement mapEventToState
    if (event is FetchTestDriveCar) {
      try {
        TestDriveModel value = await _bookingDriveService.fetchCarList();
      } catch (e) {
        log.warning(e.toString());
        yield CarListFailed();
      }
    }
    if (event is BookingTestDriveRegister) {
      yield BookingDriveLoading();

      try {
        await _bookingDriveService.registerBookingTestDrive(event.value);

        yield BookingDriveDisposeLoading();
        yield RegisterBookingTestDriveSuccess();
      } catch (error) {
        yield BookingDriveDisposeLoading();
        yield RegisterBookingTestDriveError();
        log.warning("Error : ${error.toString()}");
      }
    }
  }
}
