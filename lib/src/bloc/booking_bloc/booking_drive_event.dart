import 'package:equatable/equatable.dart';
import 'package:salles_tools/src/services/booking_drive_service.dart';

import '../../services/booking_drive_service.dart';

class BookingDriveEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FetchStation extends BookingDriveEvent {

}

class FetchTestDriveCar extends BookingDriveEvent {
  final ListCarBookingPost value;

  FetchTestDriveCar(this.value);
  @override
  List<Object> get props => [value];
}

class AddBookingServiceViaEmail extends BookingDriveEvent {
  final BookingServicePost value;
  AddBookingServiceViaEmail(this.value);

  @override
  // TODO: implement props
  List<Object> get props => [value];
}

class BookingTestDriveRegister extends BookingDriveEvent {
  final BookingTestDrivePost value;
  BookingTestDriveRegister(this.value);

  @override
  // TODO: implement props
  List<Object> get props => [value];
}

class FetchListBookingDrive extends BookingDriveEvent {
  final ListBookingDrivePost value;

  FetchListBookingDrive(this.value);

  @override
  // TODO: implement props
  List<Object> get props => [value];
}
