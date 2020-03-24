import 'package:equatable/equatable.dart';
import 'package:salles_tools/src/models/test_drive_model.dart';

class BookingDriveState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class BookingDriveInitial extends BookingDriveState {}

class BookingDriveLoading extends BookingDriveState {}

class BookingDriveDisposeLoading extends BookingDriveState {}

class BookingDriveFailed extends BookingDriveState {}

class CarListFailed extends BookingDriveState {}

class CarListSuccess extends BookingDriveState {
  final _data;

  CarListSuccess(this._data);
  TestDriveModel get value => _data;

  @override
  List<Object> get props => [_data];

}

class RegisterBookingTestDriveSuccess extends BookingDriveState{
  @override

  List<Object> get props => [];
}

class RegisterBookingTestDriveError extends BookingDriveState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}