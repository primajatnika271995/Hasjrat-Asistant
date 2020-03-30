import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salles_tools/src/bloc/booking_bloc/booking_drive_event.dart';
import 'package:salles_tools/src/bloc/booking_bloc/booking_drive_state.dart';
import 'package:salles_tools/src/models/test_drive_vehicle_model.dart';
import 'package:salles_tools/src/models/list_booking_drive_model.dart';
import 'package:salles_tools/src/services/booking_drive_service.dart';
import 'package:salles_tools/src/views/components/log.dart';

import 'booking_drive_event.dart';

class BookingDriveBloc extends Bloc<BookingDriveEvent, BookingDriveState> {
  BookingDriveService _bookingDriveService;
  BookingDriveBloc(this._bookingDriveService);
  @override
  // TODO: implement initialState
  BookingDriveState get initialState => BookingDriveInitial();

  @override
  Stream<BookingDriveState> mapEventToState(BookingDriveEvent event) async* {
    if (event is FetchTestDriveCar) {
      yield BookingDriveLoading();

      try {
        List<TestDriveVehicleModel> value =
            await _bookingDriveService.fetchCarList();
        yield BookingDriveDisposeLoading();
        yield CarListSuccess(value);
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

    if (event is FetchListBookingDrive) {
      yield BookingDriveLoading();

      try {
        List<BookingDriveScheduleModel> value =
            await _bookingDriveService.fetchListSchedule(event.value);
        if (value == null) {
          yield ListBookingDriveFailed();
        } else {
          yield BookingDriveDisposeLoading();
          yield ListBookingDriveSuccess(value);
        }
      } catch (e) {
        log.warning("Error : ${e.toString()}");
        yield ListBookingDriveFailed();
      }
    }
  }
}
