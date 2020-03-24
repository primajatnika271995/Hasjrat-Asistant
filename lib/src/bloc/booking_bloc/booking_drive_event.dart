import 'package:equatable/equatable.dart';
import 'package:salles_tools/src/services/booking_drive_service.dart';

class BookingDriveEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FetchTestDriveCar extends BookingDriveEvent {
  @override
  List<Object> get props => [];
}


class BookingTestDriveRegister extends BookingDriveEvent{
  final BookingTestDrivePost value;
  BookingTestDriveRegister(this.value);

  @override
  // TODO: implement props
  List<Object> get props => [value];
}
