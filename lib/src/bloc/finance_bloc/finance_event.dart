import 'package:equatable/equatable.dart';

class FinanceEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FetchBranch extends FinanceEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FetchAssetKind extends FinanceEvent {
  String branchCode;
  FetchAssetKind(this.branchCode);

  @override
  // TODO: implement props
  List<Object> get props => [branchCode];
}