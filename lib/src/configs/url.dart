class UriApi {
  UriApi._();
   static const String baseApi = "http://tabeldata.ip-dynamic.com/hasjrat-sales-tools";

  // Azure IP
// static const String baseApi = "http://cvktoyota.southeastasia.cloudapp.azure.com:8090/hasjrat-sales-tools";

  static const String loginUri = "/sales-tools-auth-service/oauth/token";

  static const String checkEmployeeUri = "/sales-tools-employees-service/api/v2/employees";

  static const String checkLastSalesOfTheMonth = "/sales-tools-employees-service/api/v2/employee-of-the-month/lastEmployeeOfTheMonth";

  static const String activityReportListUri = "/sales-tools-employees-service/api/v2/activities/sales/datatables";

  static const String createActivityReportUri = "/sales-tools-employees-service/api/v2/activities/sales/new";

  static const String uploadMediaFileUri = "/sales-tools-employees-service/api/v2/media/upload/image";

  static const String registerUri = "/sales-tools-auth-service/api/v2/account/sales/register";

  static const String checkCustomerDMSUri = "/sales-tools-dealer-service/api/v2/dms/customer/list";

  static const String createLeadDMSUri = "/sales-tools-dealer-service/api/v2/dms/lead/add";

  static const String createProspectDMSUri = "/sales-tools-dealer-service/api/v2/dms/prospect/add";

  static const String checkProspectDMSUri = "/sales-tools-dealer-service/api/v2/dms/prospect/list";

  static const String genderDMSUri = "/sales-tools-dealer-service/api/v2/dms/customer/jenis-kelamin";

  static const String locationDMSUri = "/sales-tools-dealer-service/api/v2/dms/customer/lokasi";

  static const String priceListDMSUri = "/sales-tools-dealer-service/api/v2/dms/price-list/list";

  static const String class1ItemDMSUri = "/sales-tools-dealer-service/api/v2/dms/item/class1/list";

  static const String itemModelDMSUri = "/sales-tools-dealer-service/api/v2/dms/item/model/list";

  static const String itemListDMSUri = "/sales-tools-dealer-service/api/v2/dms/item/list";

  static const String jobDMSUri = "/sales-tools-dealer-service/api/v2/dms/customer/pekerjaan";

  static const String provinceUri = "/sales-tools-dealer-service/api/v2/dms/wilayah/provinsi";

  static const String districtUri = "/sales-tools-dealer-service/api/v2/dms/wilayah/kabupaten";

  static const String subDistrictUri = "/sales-tools-dealer-service/api/v2/dms/wilayah/kecamatan";

  static const String checkLeadDMSUri = "/sales-tools-dealer-service/api/v2/dms/lead/list";

  static const String branchCodeUri = "/sales-tools-finance-service/api/v2/branch/list";

  static const String outletCodeUri = "/sales-tools-finance-service/api/v2/outlet/list";

  static const String assetKindUri = "/sales-tools-finance-service/api/v2/asset/kind/list";

  static const String insuranceTypeUri = "/sales-tools-finance-service/api/v2/asset/insurance-type/list";

  static const String assetGroupUri = "/sales-tools-finance-service/api/v2/asset/group/list";

  static const String assetTypeUri = "/sales-tools-finance-service/api/v2/asset/type/list";

  static const String assetPriceUri = "/sales-tools-finance-service/api/v2/asset/price/list";

  static const String simulationDownPaymentUri = "/sales-tools-finance-service/api/v2/simulation/select-down-payment";

  static const String simulationPriceListUri = "/sales-tools-finance-service/api/v2/simulation/select-price-list";

  static const String registerBookingTestDriveUri = "/sales-tools-booking-service/api/v2/test-drive/booking/register";

  static const String testDriveCarUri = "/sales-tools-booking-service/api/v2/test-drive/cars/list";

  static const String listScheduleBookingDriveUri = "/sales-tools-booking-service/api/v2/test-drive/booking/listSchedule";

  static const String programPenjualanUri = "/sales-tools-dealer-service/api/v2/dms/program/penjualan/list";

  static const String bannerPromotionUri = "/sales-tools-catalog-service/api/v2/banner/datatables";

  static const String knowledgeBaseUri = "/sales-tools-qna-service/api/v2/qna/datatables";

  static const String catalogListUri = "/sales-tools-catalog-service/api/v2/catalog/list";
}