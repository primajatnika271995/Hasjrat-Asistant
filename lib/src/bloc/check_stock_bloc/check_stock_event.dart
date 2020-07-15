import 'package:equatable/equatable.dart';
import 'package:salles_tools/src/services/check_stock_service.dart';

class CheckStockEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchStockHo extends CheckStockEvent {
  final CekStoKHeadOfficePost value;

  FetchStockHo(this.value);
  @override
  List<Object> get props => [];
}

class FetchKodeBranch extends CheckStockEvent {
  @override
  List<Object> get props => [];
}

class FetchJenisKendaraan extends CheckStockEvent {
  @override
  List<Object> get props => [];
}

class FetchModelKendaraan extends CheckStockEvent {
  final ModelKendaraanPost value;

  FetchModelKendaraan(this.value);
  @override
  List<Object> get props => [];
}

class FetchTipeKendaraan extends CheckStockEvent {
  final ModelKendaraanPost value;

  FetchTipeKendaraan(this.value);
  @override
  List<Object> get props => [];
}

class FetchKodeKendaraan extends CheckStockEvent {
  final KodeKendaraanPost value;

  FetchKodeKendaraan(this.value);
  @override
  List<Object> get props => [];
}
