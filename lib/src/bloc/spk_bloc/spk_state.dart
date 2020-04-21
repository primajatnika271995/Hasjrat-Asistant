import 'package:equatable/equatable.dart';
import 'package:salles_tools/src/models/spk_model.dart' as spk;
import 'package:salles_tools/src/models/spk_number_model.dart';

class SpkState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SpkInitial extends SpkState {

}

class SpkLoading extends SpkState {

}

class SpkDisposeLoading extends SpkState {

}

class SpkFailed extends SpkState {

}

class SpkError extends SpkState {

}

class SpkSuccess extends SpkState {
  final List<spk.Datum> listSpk;
  final bool hasReachedMax;

  SpkSuccess({this.listSpk, this.hasReachedMax});

  SpkSuccess copyWith({List<spk.Datum> listSpk, bool hasReachedMax}) {
    return SpkSuccess(
      listSpk: listSpk ?? this.listSpk,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [listSpk, hasReachedMax];

  @override
  String toString() =>
      'Spk Loaded { prospect: ${listSpk.length}, hasReachedMax: $hasReachedMax }';

}

class SpkNumberSuccess extends SpkState {
  final SpkNumberModel value;

  SpkNumberSuccess(this.value);

  @override
  // TODO: implement props
  List<Object> get props => [value];
}