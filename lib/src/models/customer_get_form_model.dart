class CustomerGroupModel {
  final String customerGroupId;
  final String customerGroupName;

  CustomerGroupModel({this.customerGroupId, this.customerGroupName});
}

List<CustomerGroupModel> customerGroupList = [
  CustomerGroupModel(customerGroupId: "1", customerGroupName: "Retail"),
  CustomerGroupModel(customerGroupId: "2", customerGroupName: "Corporate"),
  CustomerGroupModel(customerGroupId: "3", customerGroupName: "Instansi"),
  CustomerGroupModel(customerGroupId: "4", customerGroupName: "BUMN"),
  CustomerGroupModel(customerGroupId: "5", customerGroupName: "Toko / SubDealer"),
];
