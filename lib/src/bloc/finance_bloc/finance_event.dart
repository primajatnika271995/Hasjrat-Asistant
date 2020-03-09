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
  final String branchCode;
  FetchAssetKind(this.branchCode);

  @override
  // TODO: implement props
  List<Object> get props => [branchCode];
}

class FetchInsuranceType extends FinanceEvent {
  final String branchCode;
  final String assetKindCode;
  FetchInsuranceType(this.branchCode, this.assetKindCode);

  @override
  // TODO: implement props
  List<Object> get props => [branchCode, this.assetKindCode];
}

class FetchAssetGroup extends FinanceEvent {
  final String branchCode;
  final String assetKindCode;
  final String insuranceAssetCode;
  FetchAssetGroup(this.branchCode, this.assetKindCode, this.insuranceAssetCode);

  @override
  // TODO: implement props
  List<Object> get props => [branchCode, assetKindCode, insuranceAssetCode];
}

class FetchAssetType extends FinanceEvent {
  final String branchCode;
  final String assetKindCode;
  final String insuranceAssetCode;
  final String assetGroupCode;
  FetchAssetType(this.branchCode, this.assetKindCode, this.insuranceAssetCode, this.assetGroupCode);

  @override
  // TODO: implement props
  List<Object> get props => [branchCode, assetKindCode, insuranceAssetCode, assetGroupCode];
}