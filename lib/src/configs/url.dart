class UriApi {
  UriApi._();
//  static const String baseApi = "http://tabeldata.ip-dynamic.com/hasjrat-sales-tools";

  // Azure IP
  static const String baseApi = "http://cvktoyota.southeastasia.cloudapp.azure.com:8090/hasjrat-sales-tools";

  static const String loginUri = "/sales-tools-auth-service/oauth/token";

  static const String changePasswordUri = "/sales-tools-dealer-service/api/v2/dms/auth/update-password";

  static const String checkEmployeeUri = "/sales-tools-employees-service/api/v2/employees";

  static const String checkLastSalesOfTheMonth = "/sales-tools-employees-service/api/v2/employee-of-the-month/lastEmployeeOfTheMonth";

  static const String activityReportListUri = "/sales-tools-employees-service/api/v2/activities/sales/datatables/byCreatedDateBetween?length=100&order%5B0%5D%5Bdir%5D=desc&order%5B0%5D%5Bcolumn%5D=3";

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

  static const String testDriveCarUri = "/sales-tools-booking-service/api/v2/test-drive/cars/list/ByBranchCodeAndOutletOutlet";

  static const String listScheduleBookingDriveUri = "/sales-tools-booking-service/api/v2/test-drive/booking/listSchedule";

  static const String programPenjualanUri = "/sales-tools-dealer-service/api/v2/dms/program/penjualan/list";

  static const String bannerPromotionUri = "/sales-tools-catalog-service/api/v2/banner/datatables";

  static const String knowledgeBaseUri = "/sales-tools-qna-service/api/v2/qna/datatables?order%5B0%5D%5Bcolumn%5D=3&order%5B0%5D%5Bdir%5D=desc&length=66";

  static const String catalogListUri = "/sales-tools-catalog-service/api/v2/catalog/list";

  static const String catalogByCategoriUri = "/sales-tools-catalog-service/api/v2/catalog/";

  static const String detailCatalogUri = "/sales-tools-catalog-service/api/v2/catalog";

  static const String catalogBrosurUri = "/sales-tools-catalog-service/api/v2/brosur/datatables";

  static const String serviceStationListUri = "/hasjrat-resource-server/hcare-api/api/service-station/list";

  static const String bookingServiceUri = "/hasjrat-resource-server/hcare-api/api/emailBookingService/send";

  static const String bookingServiceSaveUri = "/hasjrat-resource-server/hcare-api/api/booking-service/save";

  static const String spkUri = "/sales-tools-dealer-service/api/v2/dms/spk/list";

  static const String spkNumberUri = "/sales-tools-dealer-service/api/v2/dms/spk/number";

  static const String customerCriteriaUri = "/sales-tools-dealer-service/api/v2/dms/customer/criteria";

  static const String leasingUri = "/sales-tools-dealer-service/api/v2/dms/leasing/list";

  static const String leasingTenorUri = "/sales-tools-dealer-service/api/v2/dms/leasing/tenor/list";

  static const String createSpkUri = "/sales-tools-dealer-service/api/v2/dms/spk/addCopySpkFromProspect";

  static const String classificationFollowUpUri = "/sales-tools-dealer-service/api/v2/dms/prospect/classification"; 

  static const String followUpMethodeUri = "/sales-tools-dealer-service/api/v2/dms/prospect/follow-up-method";

  static const String followUpReminderUri = "/sales-tools-dealer-service/api/v2/dms/prospect/follow-planning";

  static const String followUpTodayUri = "/sales-tools-dealer-service/api/v2/dms/prospect/follow-up-reminder";

  static const String updateFollowUpUri = "/sales-tools-dealer-service/api/v2/dms/prospect/follow-up";

  static const String dashboardUri = "/sales-tools-dealer-service/api/v2/dms/prospect/dashboard";

  static const String dashboardTargetUri = "/sales-tools-employees-service/api/v2/dashboard/sales/summary-target-sales/group-by/employeeIdAndBranchAndOutletAndCustomerGroupAndTahunBulan/by-tahunBulan";

  static const String summaryDashboardUri = "/sales-tools-employees-service/api/v2/dashboard/head-officer/prospect/findByBranchAndOutletCode";

  static const String historyLoginUri = "/sales-tools-employees-service/api/v2/history-login/new";

  static const String historyLogoutUri = "/sales-tools-employees-service/api/v2/history-login";

  static const String listExpiredStnkUri = "/hasjrat-resource-server/hcare-api/api/sales/vehicle-customer/list/expired";

  static const String listAllStnkUri = "/hasjrat-resource-server/hcare-api/api/sales/vehicle-customer/list/expired";

  static const String cekStoc_Ho_Uri = "/sales-tools-employees-service/api/v2/stock/datatables";

  // Github Json API
  static const String nationalHolidayUri = "https://cdn.jsdelivr.net/gh/niyoko/libur-nasional/data/2020.json";

  static const String branchCodeStock = "/sales-tools-auth-service/api/v2/public/branch/list";
}