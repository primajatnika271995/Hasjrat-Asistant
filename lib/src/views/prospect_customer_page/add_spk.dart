import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:salles_tools/src/bloc/spk_bloc/spk_bloc.dart';
import 'package:salles_tools/src/bloc/spk_bloc/spk_event.dart';
import 'package:salles_tools/src/bloc/spk_bloc/spk_state.dart';
import 'package:salles_tools/src/models/prospect_model.dart';
import 'package:salles_tools/src/models/selector_model.dart';
import 'package:salles_tools/src/services/spk_service.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/utils/screen_size.dart';
import 'package:salles_tools/src/views/components/loading_content.dart';
import 'package:salles_tools/src/views/components/log.dart';
import 'package:select_dialog/select_dialog.dart';

enum TypePrice { otr, offTheRoad }
enum Insurance { tlo, allRisk, kombinasi }

class SpkAddView extends StatefulWidget {
  final Datum value;
  SpkAddView(this.value);

  @override
  _SpkAddViewState createState() => _SpkAddViewState();
}

class _SpkAddViewState extends State<SpkAddView> {
  int _currentStep = 0;
  VoidCallback _onStepContinue;
  VoidCallback _onStepCancel;

  final dateFormat = DateFormat("yyyy-MM-dd");
  DateTime _dateTime = DateTime.now();

  bool isSameWithData = false;

  TypePrice _typePrice = TypePrice.otr;
  var currentSelectTypePrice = 'OTR';

  Insurance _typeInsurance = Insurance.tlo;
  var currentSelectInsurance = 'TLO';

  var prospectIdCtrl = new TextEditingController();
  var customerNameCtrl = new TextEditingController();
  var dateNowCtrl = new TextEditingController();
  var salesNameCtrl = new TextEditingController();
  var dateDecCtrl = new TextEditingController();
  var noKtpCtrl = new TextEditingController();
  var atasNamaCtrl = new TextEditingController();
  var alamatFirstCtrl = new TextEditingController();
  var alamatSecondCtrl = new TextEditingController();
  var alamatThirdCtrl = new TextEditingController();
  var kecamatanCtrl = new TextEditingController();
  var kabupatenCtrl = new TextEditingController();
  var namaAsuransi = new TextEditingController();
  var spkPriceCtrl = MoneyMaskedTextController(leftSymbol: 'Rp ', precision: 0, decimalSeparator: '');
  var jumlahAngsuranCtrl = MoneyMaskedTextController(leftSymbol: 'Rp ', precision: 0, decimalSeparator: '');
  var dpConfirmationCtrl = MoneyMaskedTextController(leftSymbol: 'Rp ', precision: 0, decimalSeparator: '');

  var spkNumberCtrl = new TextEditingController();
  var currentSelectSpkNumber;
  var spkBlanko;
  var spkBlankoCtrl = new TextEditingController();
  List<SelectorSpkNumber> spkNumberList = [];

  var customerCriteriaCtrl = new TextEditingController();
  var currentSelectCustomerCriteria;
  var customerCriteriaId;
  var itemGroup;
  List<SelectorCustomerCriteria> customerCriteriaList = [];

  var leasingNameCtrl = new TextEditingController();
  var currentSelectLeasing;
  var leasingId;
  List<SelectorLeasing> leasingList = [];

  var leasingTenorNameCtrl = new TextEditingController();
  var currentSelectLeasingTenor;
  var tenorId;
  List<SelectorLeasingTenor> leasingTenorList = [];

  var provinsiCtrl = new TextEditingController();
  var currentSelectProvinsi;
  var provinsiId;
  List<SelectorProvinceModel> listProvinsi = [];

  void _showListSpkNumber() {
    SelectDialog.showModal<SelectorSpkNumber>(
      context,
      label: "Nomor SPK",
      selectedValue: currentSelectSpkNumber,
      items: spkNumberList,
      onChange: (SelectorSpkNumber selected) {
        setState(() {
          currentSelectSpkNumber = selected;
          spkNumberCtrl.text = selected.spkNumber;
          spkBlanko = selected.spkBlanko;
          spkBlankoCtrl.text = selected.spkBlanko;
        });
      },
    );
  }

  void _showListCustomerCriteria() {
    SelectDialog.showModal<SelectorCustomerCriteria>(
      context,
      label: "Kriteria Pelanggan",
      selectedValue: currentSelectCustomerCriteria,
      items: customerCriteriaList,
      onChange: (SelectorCustomerCriteria selected) {
        setState(() {
          currentSelectCustomerCriteria = selected;
          customerCriteriaCtrl.text = selected.criteriaName;
          customerCriteriaId = selected.criteriaId;
          itemGroup = selected.itemGroup;
        });
      },
    );
  }

  void _showListLeasing() {
    SelectDialog.showModal<SelectorLeasing>(
      context,
      label: "Leasing",
      selectedValue: currentSelectLeasing,
      items: leasingList,
      onChange: (SelectorLeasing selected) {
        setState(() {
          currentSelectLeasing = selected;
          leasingNameCtrl.text = selected.leasingName;
          leasingId = selected.leasingId;
        });
      },
    );
  }

  void _showListLeasingTenor() {
    SelectDialog.showModal<SelectorLeasingTenor>(
      context,
      label: "Leasing Tenor",
      selectedValue: currentSelectLeasingTenor,
      items: leasingTenorList,
      onChange: (SelectorLeasingTenor selected) {
        setState(() {
          currentSelectLeasingTenor = selected;
          leasingTenorNameCtrl.text = selected.leasingTenorName;
          tenorId = selected.leasingTenorId;
        });
      },
    );
  }

  void _showListProvinsi() {
    SelectDialog.showModal<SelectorProvinceModel>(
      context,
      label: "Pilih Provinsi",
      selectedValue: currentSelectProvinsi,
      items: listProvinsi,
      onChange: (SelectorProvinceModel selected) {
        setState(() {
          currentSelectProvinsi = selected;
          provinsiCtrl.text = selected.provinceName;
          provinsiId = selected.provinceCode;
        });
      },
    );
  }

  void checkBox() {
    if (isSameWithData) {
      noKtpCtrl.value = TextEditingValue(text: widget.value.cardCode);
      atasNamaCtrl.value = TextEditingValue(text: widget.value.cardName);
      kabupatenCtrl.value = TextEditingValue(text: widget.value.address1);
      kecamatanCtrl.value = TextEditingValue(text: widget.value.address2);
      provinsiCtrl.value = TextEditingValue(text: widget.value.address3);
      setState(() {});
    } else {
      noKtpCtrl.value = TextEditingValue(text: '');
      atasNamaCtrl.value = TextEditingValue(text: '');
      kabupatenCtrl.value = TextEditingValue(text: '');
      kecamatanCtrl.value = TextEditingValue(text: '');
      provinsiCtrl.value = TextEditingValue(text: '');
    }
  }

  Future<Null> _selectedDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _dateTime,
      firstDate: DateTime(1900, 1),
      lastDate: DateTime(2100),
    );

    if (picked != null)
      setState(() {
        _dateTime = picked;
        dateDecCtrl.value =
            TextEditingValue(text: dateFormat.format(picked).toString());
      });
  }

  void onCreateSPK() {
    log.info("""
      spk_num : ${spkNumberCtrl.text},
      spk_blanko : ${spkBlankoCtrl.text},
      prospect_id : ${widget.value.prospectId},
      prospect_model_id : ${widget.value.models[0].prospectModelId},
      customer_criteria : $customerCriteriaId,
      item_group : ${widget.value.itemGroup},
      spk_date : ${dateNowCtrl.text},
      dec_date : ${dateDecCtrl.text},
      card_code : ${widget.value.cardCode},
      card_name : ${widget.value.cardName},
      card_type : "L",
      customer_group_id : ${widget.value.customerGroupId},
      sales_code : ${widget.value.salesCode},
      nama_user : ${widget.value.cardName},
      telp_user : ${widget.value.phone1},
      payment_type_id : 2,
      spk_price_type : $currentSelectTypePrice,
      spk_price : ${spkPriceCtrl.numberValue.toInt()},
      pl_price : ${spkPriceCtrl.numberValue.toInt()},
      extra_bbn_price : 0.00,
      disc_amount : 0.00,
      bonus_acc_amount : 0.00,
      bonus_acc_desc : ,
      discount_dp : 0,
      total_disc_amount : 300000,
      is_dalamKota : Y,
      doc_total : ${spkPriceCtrl.numberValue.toInt()},
      prospect_line_num : 0,
      item_code : ${widget.value.models[0].itemCode},
      item_model : ${widget.value.models[0].itemModel},
      item_year : ${widget.value.models[0].itemYear},
      item_type : ${widget.value.models[0].itemType},
      item_colour : ${widget.value.models[0].itemColour},
      quantity : ${widget.value.models[0].quantity},
      price : ${widget.value.models[0].price},
      pl_ontr : ${widget.value.models[0].price},
      pl_offtr : ${widget.value.models[0].price},
      pl_bbn : ${widget.value.models[0].price},
      pl_logistic : 0,
      leasing_id : $leasingId,
      tenor_id : $tenorId,
      insurance_type : TLO,
      insurance_amount_non_hmf : 0,
      dp_amount : 60000000,
      angsuran : 3000000,
      nama_asuransi : ASURANSI HMF,
      nomor_ktp : ${noKtpCtrl.text},
      nama1 : ${widget.value.cardName},
      address1 : ${widget.value.address1},
      address1 : ${alamatFirstCtrl.text},
      address2 : ${alamatSecondCtrl.text},
      address3 : ${alamatThirdCtrl.text},
      provinsi_name : ${provinsiCtrl.text},
      province_code : $provinsiId,
      kabupaten_name : ${kabupatenCtrl.text},
      kecamatan_name : ${kecamatanCtrl.text},
      zipcode : 40287,
      plat_id : 1,
    """);

    // ignore: close_sinks
    final spkBloc = BlocProvider.of<SpkBloc>(context);
    spkBloc.add(CreateSpk(SpkParams(
      leasingId: leasingId,
      itemGroup: widget.value.itemGroup,
      cardCode: widget.value.leadCode,
      cardName: widget.value.cardName,
      cardType: "L",
      customerCriteria: customerCriteriaId,
      customerGroupId: widget.value.customerGroupId,
      decDate: dateDecCtrl.text,
      spkDate: dateNowCtrl.text,
      isDalamKota: widget.value.location == "DK" ? "Y" : "N",
      insuranceAmountNonHmf: 0,
      insuranceType: currentSelectInsurance,
      address1: alamatFirstCtrl.text,
      address2: alamatSecondCtrl.text,
      address3: alamatThirdCtrl.text,
      itemCode: widget.value.models[0].itemCode,
      itemColour: widget.value.models[0].itemColour,
      itemYear: widget.value.models[0].itemYear,
      itemType: widget.value.models[0].itemType,
      itemModel: widget.value.models[0].itemModel,
      angsuran: jumlahAngsuranCtrl.numberValue,
      dpAmount: dpConfirmationCtrl.numberValue,
      bonusAccAmount: 0.00,
      discAmount: 0.00,
      bonusAccDesc: "",
      docTotal: spkPriceCtrl.numberValue.toInt(),
      extraBbnPrice: 0.00,
      paymentTypeId: 2,
      kabupatenName: kabupatenCtrl.text,
      kecamatanName: kecamatanCtrl.text,
      nama1: widget.value.cardName,
      nama2: "",
      nama3: "",
      namaAsuransi: namaAsuransi.text,
      namaUser: widget.value.cardName,
      nomorKtp: noKtpCtrl.text,
      platId: 1,
      plBbn: widget.value.models[0].price,
      plOfftr: widget.value.models[0].price,
      plOntr: widget.value.models[0].price,
      plPrice: widget.value.models[0].price,
      plLogistic: 0,
      price: widget.value.models[0].price,
      prospectId: widget.value.prospectId,
      prospectLineNum: 0,
      prospectModelId: widget.value.models[0].prospectModelId,
      provinsiCode: widget.value.provinsiCode,
      provinsiName: provinsiCtrl.text,
      quantity: widget.value.models[0].quantity,
      salesCode: widget.value.salesCode,
      spkBlanko: spkBlankoCtrl.text,
      spkNum: spkNumberCtrl.text,
      spkPrice: spkPriceCtrl.numberValue.toInt(),
      spkPriceType: currentSelectTypePrice,
      telpUser: widget.value.phone1,
      tenor: tenorId,
      totalDiscAmount: 300000,
      zipCode: "40287"
    )));
  }

  @override
  void initState() {
    // TODO: implement initState

    prospectIdCtrl.value = TextEditingValue(text: widget.value.leadCode);
    customerNameCtrl.value = TextEditingValue(text: widget.value.cardName);
    salesNameCtrl.value = TextEditingValue(text: widget.value.salesName);
    dateNowCtrl.value =
        TextEditingValue(text: dateFormat.format(DateTime.now()));

    // ignore: close_sinks
    final spkBloc = BlocProvider.of<SpkBloc>(context);
    spkBloc.add(FetchSpkNumber());
    spkBloc.add(FetchCustomerCriteria());
    spkBloc.add(FetchLeasing());
    spkBloc.add(FetchLeasingTenor());
    spkBloc.add(FetchProvince());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: HexColor("#C61818"),
        elevation: 0,
        titleSpacing: 0,
        title: Text(
          "Copy to SPK",
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: BlocListener<SpkBloc, SpkState>(
        listener: (context, state) {
          if (state is SpkLoading) {
            onLoading(context);
          }

          if (state is SpkDisposeLoading) {
            Navigator.of(context, rootNavigator: false).pop();
          }

          if (state is SpkError) {
            Navigator.of(context, rootNavigator: false).pop();
          }

          if (state is SpkNumberSuccess) {
            state.value.data.forEach((f) {
              spkNumberList.add(SelectorSpkNumber(
                spkBlanko: f.spkBlanko,
                spkNumber: f.spkNum,
              ));
            });
          }

          if (state is CustomerCriteriaSuccess) {
            state.value.data.forEach((f) {
              customerCriteriaList.add(SelectorCustomerCriteria(
                  criteriaId: f.customerCriteriaId,
                  criteriaName: f.customerCriteriaName,
                  itemGroup: f.itemGroup,
              ));
            });
          }

          if (state is LeasingSuccess) {
            state.value.data.forEach((f) {
              leasingList.add(SelectorLeasing(
                leasingId: f.leasingId,
                leasingName: f.leasingName,
              ));
            });
          }

          if (state is LeasingTenorSuccess) {
            state.value.data.forEach((f) {
              leasingTenorList.add(SelectorLeasingTenor(
                leasingTenorId: f.tenorCreditId,
                leasingTenorName: f.tenorDesc,
              ));
            });
          }

          if (state is ProvinceSuccess) {
            state.value.data.forEach((f) {
              listProvinsi.add(SelectorProvinceModel(
                provinceCode: f.provinsiCode,
                provinceName: f.provinsiName,
              ));
            });
          }

          if (state is CreateSpkSuccess) {
            log.info("Success Create SPK");
            Alert(
                context: context,
                type: AlertType.success,
                title: 'Success',
                desc: "Created SPK!",
                style: AlertStyle(
                  animationDuration: Duration(milliseconds: 500),
                  overlayColor: Colors.black54,
                  animationType: AnimationType.grow,
                ),
                buttons: [
                  DialogButton(
                    child: Text(
                      "OK",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.pop(context, false);
                      Navigator.pop(context, false);
                    },
                    color: HexColor("#C61818"),
                  ),
                ]
            ).show();
          }

          if (state is CreateSpkError) {
            log.warning("Fail Create SPK");
            Alert(
                context: context,
                type: AlertType.error,
                title: 'Error',
                desc: "Failed to Create SPK!",
                style: AlertStyle(
                  animationDuration: Duration(milliseconds: 500),
                  overlayColor: Colors.black54,
                  animationType: AnimationType.grow,
                ),
                buttons: [
                  DialogButton(
                    child: Text(
                      "OK",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () => Navigator.pop(context),
                    color: HexColor("#C61818"),
                  ),
                ]
            ).show();
          }
        },
        child: Stack(
          children: <Widget>[
            Theme(
              data: ThemeData(
                canvasColor: HexColor("#C61818"),
              ),
              child: Stepper(
                type: StepperType.horizontal,
                currentStep: _currentStep,
                onStepContinue: () {
                  if (_currentStep >= 2) return;
                  setState(() {
                    _currentStep += 1;
                  });
                },
                onStepCancel: () {
                  if (_currentStep <= 0) return;
                  setState(() {
                    _currentStep -= 1;
                  });
                },
                onStepTapped: (int index) {
                  setState(() {
                    _currentStep = index;
                  });
                },
                controlsBuilder: _createEventControlBuilder,
                steps: [
                  Step(
                    title: Text(
                      "SPK Baru",
                      style: TextStyle(color: Colors.white),
                    ),
                    isActive: _currentStep == 0 ? true : false,
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Kode Pelanggan",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                          ),
                        ),
                        formProspectId(),
                        Text(
                          "Nama Pelanggan",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                          ),
                        ),
                        formCustomerName(),
                        Text(
                          "Kriteria Customer",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                          ),
                        ),
                        formSelectCustomerCriteria(),
                        Divider(
                          thickness: 2,
                        ),
                        Text(
                          "No. SPK",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                          ),
                        ),
                        formSelectSpkNumber(),
                        spkBlanko != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "SPK Blanko",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                  formSpkBlanko(),
                                ],
                              )
                            : SizedBox(),
                        Divider(
                          thickness: 2,
                        ),
                        Text(
                          "Tanggal",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                          ),
                        ),
                        formDateNow(),
                        Text(
                          "Nama Sales",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                          ),
                        ),
                        formSalesName(),
                        Text(
                          "Rencana Penyerahan (DEC)",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                          ),
                        ),
                        formDatePicker(),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                  Step(
                    title: Text(
                      "Data & Surat",
                      style: TextStyle(color: Colors.white),
                    ),
                    isActive: _currentStep == 1 ? true : false,
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListTileTheme(
                          contentPadding: EdgeInsets.symmetric(horizontal: 15),
                          dense: true,
                          child: Card(
                            elevation: 10,
                            child: ExpansionTile(
                              title: Text(
                                "Identitas STNK",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.0,
                                ),
                              ),
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Checkbox(
                                      onChanged: (bool value) {
                                        setState(() {
                                          isSameWithData = value;
                                        });
                                        checkBox();
                                      },
                                      value: isSameWithData,
                                      activeColor: Colors.black,
                                      checkColor: Colors.white,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Identitas STNK Sama dengan Identitas Pemesan",
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Text(
                                        "No. KTP",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13,
                                          letterSpacing: 1.0,
                                        ),
                                      ),
                                    ),
                                    formNoKtp(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Text(
                                        "Atas Nama",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13,
                                          letterSpacing: 1.0,
                                        ),
                                      ),
                                    ),
                                    formAtasNama(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Text(
                                        "Alamat",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13,
                                          letterSpacing: 1.0,
                                        ),
                                      ),
                                    ),
                                    formAlamatFirst(),
                                    formAlamatSecond(),
                                    formAlamatThird(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Text(
                                        "Kecamatan",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13,
                                          letterSpacing: 1.0,
                                        ),
                                      ),
                                    ),
                                    formKecamatan(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Text(
                                        "Kabupaten",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13,
                                          letterSpacing: 1.0,
                                        ),
                                      ),
                                    ),
                                    formKabupaten(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Text(
                                        "Provinsi",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13,
                                          letterSpacing: 1.0,
                                        ),
                                      ),
                                    ),
                                    formSelectProvinsi(),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                        ListTileTheme(
                          contentPadding: EdgeInsets.symmetric(horizontal: 15),
                          dense: true,
                          child: Card(
                            elevation: 10,
                            child: ExpansionTile(
                              title: Text(
                                "Info Diskon & Program",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.0,
                                ),
                              ),
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 15),
                                      child: Text(
                                        "Tipe Harga",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13,
                                          letterSpacing: 1.0,
                                        ),
                                      ),
                                    ),
                                    radioButtonCategory(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 15),
                                      child: Text(
                                        "Harga SPK",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13,
                                          letterSpacing: 1.0,
                                        ),
                                      ),
                                    ),
                                    formSpkPrice(),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                        ListTileTheme(
                          contentPadding: EdgeInsets.symmetric(horizontal: 15),
                          dense: true,
                          child: Card(
                            elevation: 10,
                            child: ExpansionTile(
                              title: Text(
                                "Info Kredit",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.0,
                                ),
                              ),
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 15),
                                      child: Text(
                                        "Nama Leasing",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13,
                                          letterSpacing: 1.0,
                                        ),
                                      ),
                                    ),
                                    formSelectLeasing(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 15),
                                      child: Text(
                                        "Lama Tenor",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13,
                                          letterSpacing: 1.0,
                                        ),
                                      ),
                                    ),
                                    formSelectLeasingTenor(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 15),
                                      child: Text(
                                        "Asuransi",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13,
                                          letterSpacing: 1.0,
                                        ),
                                      ),
                                    ),
                                    radioButtonInsurance(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 15),
                                      child: Text(
                                        "Nama Asuransi",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13,
                                          letterSpacing: 1.0,
                                        ),
                                      ),
                                    ),
                                    formInsurance(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 15),
                                      child: Text(
                                        "Jumlah Angsuran",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13,
                                          letterSpacing: 1.0,
                                        ),
                                      ),
                                    ),
                                    formJumlahAngsuran(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 15),
                                      child: Text(
                                        "DP yang disetujui",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13,
                                          letterSpacing: 1.0,
                                        ),
                                      ),
                                    ),
                                    formDpConfirmation(),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 10),
                          child: Container(
                            width: screenWidth(context),
                            child: RaisedButton(
                              onPressed: () {
                                onCreateSPK();
                              },
                              child: Text(
                                "Create",
                                style: TextStyle(color: Colors.white),
                              ),
                              color: HexColor('#C61818'),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: BottomAppBar(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _currentStep == 0
                        ? SizedBox()
                        : FlatButton(
                            onPressed: () => _onStepCancel(),
                            child: Text(
                              'Kembali',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ),
                    _currentStep == 1
                        ? SizedBox()
                        : FlatButton(
                            onPressed: () => _onStepContinue(),
                            child: Text(
                              'Selanjutnya',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createEventControlBuilder(BuildContext context,
      {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
    _onStepContinue = onStepContinue;
    _onStepCancel = onStepCancel;
    return SizedBox.shrink();
  }

  Widget formProspectId() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Container(
        height: 30.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15.0,
              spreadRadius: 0.0,
            )
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 2.0),
            child: Theme(
              data: ThemeData(hintColor: Colors.transparent),
              child: TextFormField(
                style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 0.7,
                ),
                readOnly: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabled: false,
                  contentPadding: EdgeInsets.only(bottom: 16),
                  hintText: "Prospect Id",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                controller: prospectIdCtrl,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formCustomerName() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Container(
        height: 30.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15.0,
              spreadRadius: 0.0,
            )
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 2.0),
            child: Theme(
              data: ThemeData(hintColor: Colors.transparent),
              child: TextFormField(
                style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 0.7,
                ),
                readOnly: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabled: false,
                  contentPadding: EdgeInsets.only(bottom: 16),
                  hintText: "Nama Customer",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                controller: customerNameCtrl,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formSelectSpkNumber() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Container(
        height: 30.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15.0,
              spreadRadius: 0.0,
            )
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 2.0),
            child: Theme(
              data: ThemeData(hintColor: Colors.transparent),
              child: GestureDetector(
                onTap: () {
                  _showListSpkNumber();
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    style: TextStyle(
                      fontSize: 13,
                      letterSpacing: 0.7,
                    ),
                    readOnly: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabled: false,
                      contentPadding: EdgeInsets.only(bottom: 17),
                      suffixIcon: Icon(
                        Icons.arrow_drop_down,
                        color: Color(0xFF6991C7),
                        size: 24.0,
                      ),
                      hintText: "Pilih Nomor SPK",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    controller: spkNumberCtrl,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formSpkBlanko() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Container(
        height: 30.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15.0,
              spreadRadius: 0.0,
            )
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 2.0),
            child: Theme(
              data: ThemeData(hintColor: Colors.transparent),
              child: TextFormField(
                style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 0.7,
                ),
                readOnly: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabled: false,
                  contentPadding: EdgeInsets.only(bottom: 16),
                  hintText: "Spk Blanko",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                controller: spkBlankoCtrl,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formSelectCustomerCriteria() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Container(
        height: 30.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15.0,
              spreadRadius: 0.0,
            )
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 2.0),
            child: Theme(
              data: ThemeData(hintColor: Colors.transparent),
              child: GestureDetector(
                onTap: () {
                  _showListCustomerCriteria();
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    style: TextStyle(
                      fontSize: 13,
                      letterSpacing: 0.7,
                    ),
                    readOnly: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabled: false,
                      contentPadding: EdgeInsets.only(bottom: 17),
                      suffixIcon: Icon(
                        Icons.arrow_drop_down,
                        color: Color(0xFF6991C7),
                        size: 24.0,
                      ),
                      hintText: "Pilih Kriteria Pelanggan",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    controller: customerCriteriaCtrl,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formDateNow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Container(
        height: 30.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15.0,
              spreadRadius: 0.0,
            )
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 2.0),
            child: Theme(
              data: ThemeData(hintColor: Colors.transparent),
              child: TextFormField(
                style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 0.7,
                ),
                readOnly: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabled: false,
                  contentPadding: EdgeInsets.only(bottom: 16),
                  hintText: "Tanggal",
                  prefixIcon: Icon(
                    Icons.date_range,
                    color: Color(0xFF6991C7),
                    size: 24.0,
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                controller: dateNowCtrl,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formSalesName() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Container(
        height: 30.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15.0,
              spreadRadius: 0.0,
            )
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 2.0),
            child: Theme(
              data: ThemeData(hintColor: Colors.transparent),
              child: TextFormField(
                style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 0.7,
                ),
                readOnly: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabled: false,
                  contentPadding: EdgeInsets.only(bottom: 16),
                  hintText: "Nama Sales",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                controller: salesNameCtrl,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formDatePicker() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Container(
        height: 30,
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 15,
            ),
          ],
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(left: 5, right: 2),
            child: Theme(
              data: ThemeData(hintColor: Colors.transparent),
              child: GestureDetector(
                onTap: () {
                  _selectedDate(context);
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    style: TextStyle(
                      fontSize: 13,
                      letterSpacing: 0.7,
                    ),
                    readOnly: true,
                    decoration: new InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 16),
                      border: InputBorder.none,
                      enabled: false,
                      prefixIcon: Icon(
                        Icons.date_range,
                        color: Color(0xFF6991C7),
                        size: 24.0,
                      ),
                      hintText: "Pilih Tanggal Rencana Penyerahan",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    controller: dateDecCtrl,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formNoKtp() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      child: Container(
        height: 30.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15.0,
              spreadRadius: 0.0,
            )
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 2.0),
            child: Theme(
              data: ThemeData(hintColor: Colors.transparent),
              child: TextFormField(
                style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 0.7,
                ),
                readOnly: false,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabled: true,
                  contentPadding: EdgeInsets.only(bottom: 16),
                  hintText: "Silahkan isi No. KTP",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                controller: noKtpCtrl,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formAtasNama() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      child: Container(
        height: 30.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15.0,
              spreadRadius: 0.0,
            )
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 2.0),
            child: Theme(
              data: ThemeData(hintColor: Colors.transparent),
              child: TextFormField(
                style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 0.7,
                ),
                readOnly: false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabled: true,
                  contentPadding: EdgeInsets.only(bottom: 16),
                  hintText: "Isi Atas Nama untuk STNK",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                controller: atasNamaCtrl,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formAlamatFirst() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      child: Container(
        height: 30.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15.0,
              spreadRadius: 0.0,
            )
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 2.0),
            child: Theme(
              data: ThemeData(hintColor: Colors.transparent),
              child: TextFormField(
                style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 0.7,
                ),
                readOnly: false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabled: true,
                  contentPadding: EdgeInsets.only(bottom: 16),
                  hintText: "Masukan Alamat 1",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                controller: alamatFirstCtrl,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formAlamatSecond() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      child: Container(
        height: 30.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15.0,
              spreadRadius: 0.0,
            )
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 2.0),
            child: Theme(
              data: ThemeData(hintColor: Colors.transparent),
              child: TextFormField(
                style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 0.7,
                ),
                readOnly: false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabled: true,
                  contentPadding: EdgeInsets.only(bottom: 16),
                  hintText: "Masukan Alamat 2",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                controller: alamatSecondCtrl,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formAlamatThird() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      child: Container(
        height: 30.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15.0,
              spreadRadius: 0.0,
            )
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 2.0),
            child: Theme(
              data: ThemeData(hintColor: Colors.transparent),
              child: TextFormField(
                style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 0.7,
                ),
                readOnly: false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabled: true,
                  contentPadding: EdgeInsets.only(bottom: 16),
                  hintText: "Masukan Alamat 3",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                controller: alamatThirdCtrl,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formKecamatan() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      child: Container(
        height: 30.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15.0,
              spreadRadius: 0.0,
            )
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 2.0),
            child: Theme(
              data: ThemeData(hintColor: Colors.transparent),
              child: TextFormField(
                style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 0.7,
                ),
                readOnly: false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabled: true,
                  contentPadding: EdgeInsets.only(bottom: 16),
                  hintText: "Masukan Kecamatan",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                controller: kecamatanCtrl,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formKabupaten() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      child: Container(
        height: 30.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15.0,
              spreadRadius: 0.0,
            )
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 2.0),
            child: Theme(
              data: ThemeData(hintColor: Colors.transparent),
              child: TextFormField(
                style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 0.7,
                ),
                readOnly: false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabled: true,
                  contentPadding: EdgeInsets.only(bottom: 16),
                  hintText: "Masukan Kabupaten / Kota",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                controller: kabupatenCtrl,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formInsurance() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      child: Container(
        height: 30.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15.0,
              spreadRadius: 0.0,
            )
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 2.0),
            child: Theme(
              data: ThemeData(hintColor: Colors.transparent),
              child: TextFormField(
                style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 0.7,
                ),
                readOnly: false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabled: true,
                  contentPadding: EdgeInsets.only(bottom: 16),
                  hintText: "Masukan Nama Asuransi",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                controller: namaAsuransi,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget radioButtonCategory() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      child: Row(
        children: <Widget>[
          Expanded(
            child: RadioListTile<TypePrice>(
              value: TypePrice.otr,
              onChanged: (TypePrice val) {
                setState(() {
                  _typePrice = val;
                  currentSelectTypePrice = "OTR";
                });
              },
              groupValue: _typePrice,
              title: Text(
                "OTR",
                style: TextStyle(
                  letterSpacing: 0.8,
                  fontSize: 13,
                ),
              ),
              activeColor: HexColor('#C61818'),
            ),
          ),
          Expanded(
            child: RadioListTile<TypePrice>(
              value: TypePrice.offTheRoad,
              onChanged: (TypePrice val) {
                setState(() {
                  _typePrice = val;
                  currentSelectTypePrice = "Off The Road";
                });
              },
              groupValue: _typePrice,
              title: Text(
                "Off The Road",
                style: TextStyle(
                  letterSpacing: 0.8,
                  fontSize: 13,
                ),
              ),
              activeColor: HexColor('#C61818'),
            ),
          ),
        ],
      ),
    );
  }

  Widget radioButtonInsurance() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      child: Column(
        children: <Widget>[
          RadioListTile<Insurance>(
            value: Insurance.tlo,
            onChanged: (Insurance val) {
              setState(() {
                _typeInsurance = val;
                currentSelectInsurance = "TLO";
              });
            },
            groupValue: _typeInsurance,
            title: Text(
              "TLO",
              style: TextStyle(
                letterSpacing: 0.8,
                fontSize: 13,
              ),
            ),
            activeColor: HexColor('#C61818'),
          ),
          RadioListTile<Insurance>(
            value: Insurance.allRisk,
            onChanged: (Insurance val) {
              setState(() {
                _typeInsurance = val;
                currentSelectInsurance = "All Risk";
              });
            },
            groupValue: _typeInsurance,
            title: Text(
              "All Risk",
              style: TextStyle(
                letterSpacing: 0.8,
                fontSize: 13,
              ),
            ),
            activeColor: HexColor('#C61818'),
          ),
          RadioListTile<Insurance>(
            value: Insurance.kombinasi,
            onChanged: (Insurance val) {
              setState(() {
                _typeInsurance = val;
                currentSelectInsurance = "Kombinasi";
              });
            },
            groupValue: _typeInsurance,
            title: Text(
              "Kombinasi",
              style: TextStyle(
                letterSpacing: 0.8,
                fontSize: 13,
              ),
            ),
            activeColor: HexColor('#C61818'),
          ),
        ],
      ),
    );
  }

  Widget formSpkPrice() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      child: Container(
        height: 30.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15.0,
              spreadRadius: 0.0,
            )
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 2.0),
            child: Theme(
              data: ThemeData(hintColor: Colors.transparent),
              child: TextFormField(
                style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 0.7,
                ),
                readOnly: false,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabled: true,
                  contentPadding: EdgeInsets.only(bottom: 16),
                  hintText: "Masukan SPK Price",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                controller: spkPriceCtrl,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formSelectLeasing() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      child: Container(
        height: 30.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15.0,
              spreadRadius: 0.0,
            )
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 2.0),
            child: Theme(
              data: ThemeData(hintColor: Colors.transparent),
              child: GestureDetector(
                onTap: () {
                  _showListLeasing();
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    style: TextStyle(
                      fontSize: 13,
                      letterSpacing: 0.7,
                    ),
                    readOnly: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabled: false,
                      contentPadding: EdgeInsets.only(bottom: 17),
                      suffixIcon: Icon(
                        Icons.arrow_drop_down,
                        color: Color(0xFF6991C7),
                        size: 24.0,
                      ),
                      hintText: "Pilih Nama Leasing",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    controller: leasingNameCtrl,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formSelectLeasingTenor() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      child: Container(
        height: 30.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15.0,
              spreadRadius: 0.0,
            )
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 2.0),
            child: Theme(
              data: ThemeData(hintColor: Colors.transparent),
              child: GestureDetector(
                onTap: () {
                  _showListLeasingTenor();
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    style: TextStyle(
                      fontSize: 13,
                      letterSpacing: 0.7,
                    ),
                    readOnly: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabled: false,
                      contentPadding: EdgeInsets.only(bottom: 17),
                      suffixIcon: Icon(
                        Icons.arrow_drop_down,
                        color: Color(0xFF6991C7),
                        size: 24.0,
                      ),
                      hintText: "Pilih Tenor",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    controller: leasingTenorNameCtrl,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formSelectProvinsi() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      child: Container(
        height: 30.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15.0,
              spreadRadius: 0.0,
            )
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 2.0),
            child: Theme(
              data: ThemeData(hintColor: Colors.transparent),
              child: GestureDetector(
                onTap: () {
                  _showListProvinsi();
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    style: TextStyle(
                      fontSize: 13,
                      letterSpacing: 0.7,
                    ),
                    readOnly: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabled: false,
                      contentPadding: EdgeInsets.only(bottom: 17),
                      suffixIcon: Icon(
                        Icons.arrow_drop_down,
                        color: Color(0xFF6991C7),
                        size: 24.0,
                      ),
                      hintText: "Pilih Provinsi",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                    controller: provinsiCtrl,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formJumlahAngsuran() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      child: Container(
        height: 30.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15.0,
              spreadRadius: 0.0,
            )
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 2.0),
            child: Theme(
              data: ThemeData(hintColor: Colors.transparent),
              child: TextFormField(
                style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 0.7,
                ),
                readOnly: false,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabled: true,
                  contentPadding: EdgeInsets.only(bottom: 16),
                  hintText: "Masukan Jumlah Angsuran",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                controller: jumlahAngsuranCtrl,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formDpConfirmation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      child: Container(
        height: 30.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15.0,
              spreadRadius: 0.0,
            )
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 2.0),
            child: Theme(
              data: ThemeData(hintColor: Colors.transparent),
              child: TextFormField(
                style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 0.7,
                ),
                readOnly: false,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabled: true,
                  contentPadding: EdgeInsets.only(bottom: 16),
                  hintText: "Masukan DP yang disetujui",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                controller: dpConfirmationCtrl,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
