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
      height: 250,
      child: SfCartesianChart(
        plotAreaBorderWidth: 0,
        legend: Legend(
          isVisible: true,
          iconHeight: 15,
          iconWidth: 15,
          textStyle: ChartTextStyle(
            color: Colors.black,
          ),
          isResponsive: true,
          position: LegendPosition.top,
          alignment: ChartAlignment.near,
          overflowMode: LegendItemOverflowMode.wrap,
        ),
        title: ChartTitle(
          text: 'Prospect Customer',
          alignment: ChartAlignment.near,
          textStyle: ChartTextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        primaryXAxis: CategoryAxis(
          labelStyle: ChartTextStyle(color: Colors.black),
          axisLine: AxisLine(width: 0),
          labelPosition: ChartDataLabelPosition.outside,
          majorTickLines: MajorTickLines(width: 0),
          majorGridLines: MajorGridLines(width: 0),
        ),
        primaryYAxis: NumericAxis(isVisible: false, minimum: 0, maximum: 20),
        series: getData(dataDashboard),
        tooltipBehavior: TooltipBehavior(
          enable: true,
          canShowMarker: false,
          format:
              'point.x : point.y',
          header: '',
        ),
      ),
    );
  }

  List<ColumnSeries<ChartSampleData, String>> getData(data) {
    var value = dataDashboard.data;
    final List<ChartSampleData> chartData = <ChartSampleData>[
      ChartSampleData(
        x: 'Jan',
        y: value.contacts[0].total,
        yValue2: value.prospects[0].total,
        yValue3: value.hotprospects[0].total,
        yValue4: value.spks[0].total,
        yValue5: value.deliveries[0].total,
      ),
      ChartSampleData(
        x: 'Feb',
        y: value.contacts[1].total,
        yValue2: value.prospects[1].total,
        yValue3: value.hotprospects[1].total,
        yValue4: value.spks[1].total,
        yValue5: value.deliveries[1].total,
      ),
      ChartSampleData(
        x: 'Mar',
        y: value.contacts[2].total,
        yValue2: value.prospects[2].total,
        yValue3: value.hotprospects[2].total,
        yValue4: value.spks[2].total,
        yValue5: value.deliveries[2].total,
      ),
      ChartSampleData(
        x: 'Apr',
        y: value.contacts[3].total,
        yValue2: value.prospects[3].total,
        yValue3: value.hotprospects[3].total,
        yValue4: value.spks[3].total,
        yValue5: value.deliveries[3].total,
      ),
      ChartSampleData(
        x: 'Mei',
        y: value.contacts[4].total,
        yValue2: value.prospects[4].total,
        yValue3: value.hotprospects[4].total,
        yValue4: value.spks[4].total,
        yValue5: value.deliveries[4].total,
      ),
      ChartSampleData(
        x: 'Jun',
        y: value.contacts[5].total,
        yValue2: value.prospects[5].total,
        yValue3: value.hotprospects[5].total,
        yValue4: value.spks[5].total,
        yValue5: value.deliveries[5].total,
      ),
      ChartSampleData(
        x: 'Jul',
        y: value.contacts[6].total,
        yValue2: value.prospects[6].total,
        yValue3: value.hotprospects[6].total,
        yValue4: value.spks[6].total,
        yValue5: value.deliveries[6].total,
      ),
      ChartSampleData(
        x: 'Aug',
        y: value.contacts[7].total,
        yValue2: value.prospects[7].total,
        yValue3: value.hotprospects[7].total,
        yValue4: value.spks[7].total,
        yValue5: value.deliveries[7].total,
      ),
      ChartSampleData(
        x: 'Sep',
        y: value.contacts[8].total,
        yValue2: value.prospects[8].total,
        yValue3: value.hotprospects[8].total,
        yValue4: value.spks[8].total,
        yValue5: value.deliveries[8].total,
      ),
      ChartSampleData(
        x: 'Okt',
        y: value.contacts[9].total,
        yValue2: value.prospects[9].total,
        yValue3: value.hotprospects[9].total,
        yValue4: value.spks[9].total,
        yValue5: value.deliveries[9].total,
      ),
      ChartSampleData(
        x: 'Nov',
        y: value.contacts[10].total,
        yValue2: value.prospects[10].total,
        yValue3: value.hotprospects[10].total,
        yValue4: value.spks[10].total,
        yValue5: value.deliveries[10].total,
      ),
      ChartSampleData(
        x: 'Des',
        y: value.contacts[11].total,
        yValue2: value.prospects[11].total,
        yValue3: value.hotprospects[11].total,
        yValue4: value.spks[11].total,
        yValue5: value.deliveries[11].total,
      ),
    ];

    return <ColumnSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(
        enableTooltip: true,
        width: 0.7,
        animationDuration: 0,
        spacing: 0.1,
        legendIconType: LegendIconType.rectangle,
        legendItemText: 'Contact',
        dataLabelSettings: DataLabelSettings(
            isVisible: false, labelAlignment: ChartDataLabelAlignment.top),
        dataSource: chartData,
        color: HexColor('#C61818'),
        borderRadius: BorderRadius.circular(5),
        xValueMapper: (ChartSampleData sales, _) => sales.x,
        yValueMapper: (ChartSampleData sales, _) => sales.y,
      ),
      ColumnSeries<ChartSampleData, String>(
        enableTooltip: true,
        width: 0.7,
        spacing: 0.1,
        animationDuration: 0,
        legendIconType: LegendIconType.rectangle,
        legendItemText: 'Prospect',
        dataLabelSettings: DataLabelSettings(
            isVisible: false, labelAlignment: ChartDataLabelAlignment.top),
        dataSource: chartData,
        color: Colors.pinkAccent,
        borderRadius: BorderRadius.circular(5),
        xValueMapper: (ChartSampleData sales, _) => sales.x,
        yValueMapper: (ChartSampleData sales, _) => sales.yValue2,
      ),
      ColumnSeries<ChartSampleData, String>(
        enableTooltip: true,
        width: 0.7,
        spacing: 0.1,
        animationDuration: 0,
        legendIconType: LegendIconType.rectangle,
        legendItemText: 'Hot Prospect',
        dataLabelSettings: DataLabelSettings(
            isVisible: false, labelAlignment: ChartDataLabelAlignment.top),
        dataSource: chartData,
        color: Colors.red,
        borderRadius: BorderRadius.circular(5),
        xValueMapper: (ChartSampleData sales, _) => sales.x,
        yValueMapper: (ChartSampleData sales, _) => sales.yValue3,
      ),
      ColumnSeries<ChartSampleData, String>(
        enableTooltip: true,
        width: 0.7,
        spacing: 0.1,
        animationDuration: 0,
        legendIconType: LegendIconType.rectangle,
        legendItemText: 'SPKS',
        dataLabelSettings: DataLabelSettings(
            isVisible: false, labelAlignment: ChartDataLabelAlignment.top),
        dataSource: chartData,
        color: Colors.greenAccent,
        borderRadius: BorderRadius.circular(5),
        xValueMapper: (ChartSampleData sales, _) => sales.x,
        yValueMapper: (ChartSampleData sales, _) => sales.yValue4,
      ),
      ColumnSeries<ChartSampleData, String>(
        enableTooltip: true,
        width: 0.7,
        spacing: 0.1,
        animationDuration: 0,
        legendIconType: LegendIconType.rectangle,
        legendItemText: 'Deliveries',
        dataLabelSettings: DataLabelSettings(
            isVisible: false, labelAlignment: ChartDataLabelAlignment.top),
        dataSource: chartData,
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(5),
        xValueMapper: (ChartSampleData sales, _) => sales.x,
        yValueMapper: (ChartSampleData sales, _) => sales.yValue5,
      ),
    ];
  }
}
