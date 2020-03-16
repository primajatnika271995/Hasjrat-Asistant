class CustomerGroupModel {
  final String customerGroupId;
  final String customerGroupName;

  CustomerGroupModel({this.customerGroupId, this.customerGroupName});
}

class ProspectSourceModel {
  final int prospectSourceId;
  final String prospectSourceName;

  ProspectSourceModel({this.prospectSourceId, this.prospectSourceName});
}

List<CustomerGroupModel> customerGroupList = [
  CustomerGroupModel(customerGroupId: "1", customerGroupName: "Retail"),
  CustomerGroupModel(customerGroupId: "2", customerGroupName: "Corporate"),
  CustomerGroupModel(customerGroupId: "3", customerGroupName: "Instansi"),
  CustomerGroupModel(customerGroupId: "4", customerGroupName: "BUMN"),
  CustomerGroupModel(customerGroupId: "5", customerGroupName: "Toko / SubDealer"),
];

List<ProspectSourceModel> prospectSourceList = [
  ProspectSourceModel(prospectSourceId: 1, prospectSourceName: "Walk-In"),
  ProspectSourceModel(prospectSourceId: 2, prospectSourceName: "Phone-In"),
  ProspectSourceModel(prospectSourceId: 3, prospectSourceName: "Canvassing"),
  ProspectSourceModel(prospectSourceId: 4, prospectSourceName: "Movex / Pameran"),
  ProspectSourceModel(prospectSourceId: 5, prospectSourceName: "Mobex / Test Drive"),
  ProspectSourceModel(prospectSourceId: 6, prospectSourceName: "Showroom Event"),
  ProspectSourceModel(prospectSourceId: 7, prospectSourceName: "Customer Gathering"),
  ProspectSourceModel(prospectSourceId: 8, prospectSourceName: "Big Day Event"),
  ProspectSourceModel(prospectSourceId: 10, prospectSourceName: "Reference"),
  ProspectSourceModel(prospectSourceId: 11, prospectSourceName: "Media Online"),
  ProspectSourceModel(prospectSourceId: 12, prospectSourceName: "Community Event"),
];
