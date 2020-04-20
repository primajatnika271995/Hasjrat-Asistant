import 'package:equatable/equatable.dart';
import 'package:salles_tools/src/services/spk_service.dart';

class SpkEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
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

class ResetSpk extends SpkEvent {

}