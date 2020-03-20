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

class SelectorGenderModel {
  String fieldValue;
  String description;

  SelectorGenderModel({this.fieldValue, this.description});

  @override
  String toString() => description;

  @override
  // ignore: hash_and_equals
  bool operator ==(other) => other is SelectorGenderModel && other.description == description;

  @override
  // TODO: implement hashCode
  int get hashCode => fieldValue.hashCode^description.hashCode;
}

class SelectorGroupModel {
  String groupId;
  String groupName;

  SelectorGroupModel({this.groupId, this.groupName});

  @override
  String toString() => groupName;

  @override
  // ignore: hash_and_equals
  bool operator ==(other) => other is SelectorGroupModel && other.groupId == groupId;

  @override
  // TODO: implement hashCode
  int get hashCode => groupId.hashCode^groupName.hashCode;
}

class SelectorProspectSourceModel {
  int sourceId;
  String sourceName;

  SelectorProspectSourceModel({this.sourceId, this.sourceName});

  @override
  String toString() => sourceName;

  @override
  // ignore: hash_and_equals
  bool operator ==(other) => other is SelectorProspectSourceModel && other.sourceId == sourceId;

  @override
  // TODO: implement hashCode
  int get hashCode => sourceId.hashCode^sourceName.hashCode;
}

class SelectorLocationModel {
  String locationField;
  String locationName;

  SelectorLocationModel({this.locationField, this.locationName});

  @override
  String toString() => locationName;

  @override
  // ignore: hash_and_equals
  bool operator ==(other) => other is SelectorLocationModel && other.locationField == locationField;

  @override
  // TODO: implement hashCode
  int get hashCode => locationField.hashCode^locationName.hashCode;
}

class SelectorJobModel {
  String jobField;
  String jobName;

  SelectorJobModel({this.jobField, this.jobName});

  @override
  String toString() => jobName;

  @override
  // ignore: hash_and_equals
  bool operator ==(other) => other is SelectorJobModel && other.jobField == jobField;

  @override
  // TODO: implement hashCode
  int get hashCode => jobField.hashCode^jobName.hashCode;
}

class SelectorProvinceModel {
  String provinceCode;
  String provinceName;

  SelectorProvinceModel({this.provinceCode, this.provinceName});

  @override
  String toString() => provinceName;

  @override
  // ignore: hash_and_equals
  bool operator ==(other) => other is SelectorProvinceModel && other.provinceCode == provinceCode;

  @override
  // TODO: implement hashCode
  int get hashCode => provinceCode.hashCode^provinceName.hashCode;
}

class SelectorDistrictModel {
  String districtCode;
  String districtName;

  SelectorDistrictModel({this.districtCode, this.districtName});

  @override
  String toString() => districtName;

  @override
  // ignore: hash_and_equals
  bool operator ==(other) => other is SelectorDistrictModel && other.districtCode == districtCode;

  @override
  // TODO: implement hashCode
  int get hashCode => districtCode.hashCode^districtName.hashCode;
}

class SelectorSubDistrictModel {
  String districtSubCode;
  String districtSubName;

  SelectorSubDistrictModel({this.districtSubCode, this.districtSubName});

  @override
  String toString() => districtSubName;

  @override
  // ignore: hash_and_equals
  bool operator ==(other) => other is SelectorSubDistrictModel && other.districtSubCode == districtSubCode;

  @override
  // TODO: implement hashCode
  int get hashCode => districtSubCode.hashCode^districtSubName.hashCode;
}

class SelectorLeadModel {
  String leadName;
  String leadContact;

  SelectorLeadModel({this.leadName, this.leadContact});

  @override
  String toString() => leadName;

  @override
  // ignore: hash_and_equals
  bool operator ==(other) => other is SelectorLeadModel && other.leadName == leadName;

  @override
  // TODO: implement hashCode
  int get hashCode => leadName.hashCode^leadContact.hashCode;
}

class SelectorPriceListModel {
  String itemModel;
  String itemType;
  String itemCode;

  SelectorPriceListModel({this.itemModel, this.itemType, this.itemCode});

  @override
  String toString() => itemModel;

  @override
  // ignore: hash_and_equals
  bool operator ==(other) => other is SelectorPriceListModel && other.itemModel == itemModel;

  @override
  // TODO: implement hashCode
  int get hashCode => itemModel.hashCode^itemType.hashCode^itemCode.hashCode;
}