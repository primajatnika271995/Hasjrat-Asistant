class UriApi {
  UriApi._();
//  static const String baseApi = "http://tabeldata.ip-dynamic.com/hasjrat-sales-tools";

  // Azure IP
  static const String baseApi = "http://cvktoyota.southeastasia.cloudapp.azure.com:8090/hasjrat-sales-tools";

  static const String loginUri = "/sales-tools-auth-service/oauth/token";

  static const String checkEmployeeUri = "/sales-tools-employees-service/api/v2/employees";

  static const String registerUri = "/sales-tools-auth-service/api/v2/account/sales/register";

  static const String checkCustomerDMSUri = "/sales-tools-dealer-service/api/v2/dms/customer/list";

  static const String branchCodeUri = "/sales-tools-finance-service/api/v2/branch/list";

  static const String assetKindUri = "/sales-tools-finance-service/api/v2/asset/kind/list";

  static const String insuranceTypeUri = "/sales-tools-finance-service/api/v2/asset/insurance-type/list";

  static const String assetGroupUri = "/sales-tools-finance-service/api/v2/asset/group/list";

  static const String assetTypeUri = "/sales-tools-finance-service/api/v2/asset/type/list";

  static const String assetPriceUri = "/sales-tools-finance-service/api/v2/asset/price/list";
}