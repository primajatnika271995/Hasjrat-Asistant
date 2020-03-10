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

class FetchOutlet extends FinanceEvent {
  final String branchCode;
  FetchOutlet(this.branchCode);

  @override
  // TODO: implement props
  List<Object> get props => [branchCode];
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
  List<Object> get props => [branchCode, assetKindCode];
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

class FetchAssetPrice extends FinanceEvent {
  final String branchCode;
  final String assetKindCode;
  final String insuranceAssetCode;
  final String assetGroupCode;
  final String assetTypeCode;
  FetchAssetPrice(this.branchCode, this.assetKindCode, this.insuranceAssetCode, this.assetGroupCode, this.assetTypeCode);

  @override
  // TODO: implement props
  List<Object> get props => [branchCode, assetKindCode, insuranceAssetCode, assetGroupCode, assetTypeCode];
}

class FetchSimulationDownPayment extends FinanceEvent {
  final String branchCode;
  final String assetKindCode;
  final String insuranceAssetCode;
  final String assetGroupCode;
  final String assetTypeCode;
  final String priceListId;
  final String price;
  final String downPayment;
  FetchSimulationDownPayment(this.branchCode, this.assetKindCode, this.insuranceAssetCode, this.assetGroupCode, this.assetTypeCode, this.priceListId, this.price, this.downPayment);

  @override
  // TODO: implement props
  List<Object> get props => [branchCode, assetKindCode, insuranceAssetCode, assetGroupCode, assetTypeCode, priceListId, price, downPayment];
}

class FetchSimulationPriceList extends FinanceEvent {
  final String branchCode;
  final String assetKindCode;
  final String insuranceAssetCode;
  final String assetGroupCode;
  final String assetTypeCode;
  final String priceListId;
  final String price;
  FetchSimulationPriceList(this.branchCode, this.assetKindCode, this.insuranceAssetCode, this.assetGroupCode, this.assetTypeCode, this.priceListId, this.price);

  @override
  // TODO: implement props
  List<Object> get props => [branchCode, assetKindCode, insuranceAssetCode, assetGroupCode, assetTypeCode, priceListId, price];
}