import 'package:equatable/equatable.dart';
import 'package:salles_tools/src/models/spk_model.dart';

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
  final List<Datum> listSpk;
  final bool hasReachedMax;

  SpkSuccess({this.listSpk, this.hasReachedMax});

  SpkSuccess copyWith({List<Datum> listSpk, bool hasReachedMax}) {
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