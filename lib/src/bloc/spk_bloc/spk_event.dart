import 'package:equatable/equatable.dart';
import 'package:salles_tools/src/services/spk_service.dart';

class SpkEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CreateSpk extends SpkEvent {
  final SpkParams value;
  CreateSpk(this.value);

  @override
  // TODO: implement props
  List<Object> get props => [value];
}

class FetchSpk extends SpkEvent {
  final SpkFilterPost value;

  FetchSpk(this.value);

  @override
  // TODO: implement props
  List<Object> get props => [value];
}

class RefreshSpk extends SpkEvent {
  final SpkFilterPost value;

  RefreshSpk(this.value);

  @override
  // TODO: implement props
  List<Object> get props =>  [value];
}

class FetchSpkFilter extends SpkEvent {
  final SpkFilterPost value;

  FetchSpkFilter(this.value);

  @override
  // TODO: implement props
  List<Object> get props => [value];
}

class FetchSpkNumber extends SpkEvent {

}

class FetchCustomerCriteria extends SpkEvent {

}

class FetchLeasing extends SpkEvent {

}

class FetchLeasingTenor extends SpkEvent {

}

class FetchProvince extends SpkEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ResetSpk extends SpkEvent {

}