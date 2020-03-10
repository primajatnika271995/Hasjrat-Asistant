class SelectorBranchModel {
  String id;
  String branchName;

  SelectorBranchModel({this.id, this.branchName});

  @override
  String toString() => branchName;

  @override
  // ignore: hash_and_equals
  bool operator ==(other) => other is SelectorBranchModel && other.id == id;

  @override
  // TODO: implement hashCode
  int get hashCode => id.hashCode^branchName.hashCode;
}

class SelectorOutletModel {
  String id;
  String outletName;

  SelectorOutletModel({this.id, this.outletName});

  @override
  String toString() => outletName;

  @override
  // ignore: hash_and_equals
  bool operator ==(other) => other is SelectorOutletModel && other.id == id;

  @override
  // TODO: implement hashCode
  int get hashCode => id.hashCode^outletName.hashCode;
}

class SelectorAssetKindModel {
  String id;
  String assetKindName;

  SelectorAssetKindModel({this.id, this.assetKindName});

  @override
  String toString() => assetKindName;

  @override
  // ignore: hash_and_equals
  bool operator ==(other) => other is SelectorAssetKindModel && other.id == id;

  @override
  // TODO: implement hashCode
  int get hashCode => id.hashCode^assetKindName.hashCode;
}

class SelectorInsuranceTypeModel {
  String id;
  String insuranceTypeName;

  SelectorInsuranceTypeModel({this.id, this.insuranceTypeName});

  @override
  String toString() => insuranceTypeName;

  @override
  // ignore: hash_and_equals
  bool operator ==(other) => other is SelectorInsuranceTypeModel && other.id == id;

  @override
  // TODO: implement hashCode
  int get hashCode => id.hashCode^insuranceTypeName.hashCode;
}

class SelectorAssetGroupModel {
  String assetGroupCode;
  String assetGroupName;

  SelectorAssetGroupModel({this.assetGroupCode, this.assetGroupName});

  @override
  String toString() => assetGroupName;

  @override
  // ignore: hash_and_equals
  bool operator ==(other) => other is SelectorAssetGroupModel && other.assetGroupCode == assetGroupCode;

  @override
  // TODO: implement hashCode
  int get hashCode => assetGroupCode.hashCode^assetGroupName.hashCode;
}

class SelectorAssetTypeModel {
  String assetTypeCode;
  String assetTypeName;

  SelectorAssetTypeModel({this.assetTypeCode, this.assetTypeName});

  @override
  String toString() => assetTypeName;

  @override
  // ignore: hash_and_equals
  bool operator ==(other) => other is SelectorAssetTypeModel && other.assetTypeCode == assetTypeCode;

  @override
  // TODO: implement hashCode
  int get hashCode => assetTypeCode.hashCode^assetTypeName.hashCode;
}
