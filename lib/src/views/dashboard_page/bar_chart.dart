import 'package:flutter/material.dart';
import 'package:salles_tools/src/models/dashboard_model.dart';
import 'package:salles_tools/src/models/example_radial_chart_model.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarChartView extends StatefulWidget {
  final DashboardModel dataDashboard;

  const BarChartView({Key key, this.dataDashboard}) : super(key: key);
  @override
  _BarChartViewState createState() => _BarChartViewState(this.dataDashboard);
}

class _BarChartViewState extends State<BarChartView> {
  final DashboardModel dataDashboard;

  _BarChartViewState(this.dataDashboard);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.2,
      child: Padding(
        padding: const EdgeInsets.only(right: 20, left: 10),
        child: SfFunnelChart(
          title: ChartTitle(
            text: 'Prospek Pelanggan',
            alignment: ChartAlignment.near,
            textStyle: ChartTextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          legend: Legend(
            isVisible: true,
            overflowMode: LegendItemOverflowMode.wrap,
          ),
          tooltipBehavior: TooltipBehavior(
            enable: true,
            format: 'point.x : point.y',
          ),
          series: _getFunnelSeries(),
        ),
      ),
    );
  }

  FunnelSeries<ChartSampleData, String> _getFunnelSeries() {
    var value = dataDashboard.data.rekaps[0];
    final List<ChartSampleData> funnelData = <ChartSampleData>[
      ChartSampleData(
        x: 'Contact',
        y: value.contact,
        text: '${value.contact}',
      ),
      ChartSampleData(
        x: 'Prospect ',
        y: value.prospect,
        text: '${value.prospect}',
      ),
      ChartSampleData(
        x: 'Hot Prospect ',
        y: value.hotprospect,
        text: '${value.hotprospect}',
      ),
      ChartSampleData(
        x: 'SPK',
        y: value.spk,
        text: '${value.spk}',
      ),
      ChartSampleData(
        x: 'DO',
        y: value.deliveryOrder,
        text: '${value.deliveryOrder}',
      ),
      ChartSampleData(
        x: 'DEC',
        y: value.dec,
        text: '${value.dec}',
      ),
    ];
    return FunnelSeries<ChartSampleData, String>(
      emptyPointSettings: EmptyPointSettings(
        borderColor: Colors.grey,
        borderWidth: 50,
        color: Colors.black,
      ),
      dataSource: funnelData,
      textFieldMapper: (ChartSampleData data, _) => data.text,
      xValueMapper: (ChartSampleData data, _) => data.x,
      yValueMapper: (ChartSampleData data, _) => data.y,
      dataLabelSettings: DataLabelSettings(
        isVisible: true,
        labelPosition: ChartDataLabelPosition.inside,
      ),
      width: '70%',
      neckWidth: '40%',
    );
  }
}
