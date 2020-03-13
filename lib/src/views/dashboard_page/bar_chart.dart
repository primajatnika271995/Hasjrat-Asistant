import 'package:flutter/material.dart';
import 'package:salles_tools/src/models/example_radial_chart_model.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarChartView extends StatefulWidget {
  @override
  _BarChartViewState createState() => _BarChartViewState();
}

class _BarChartViewState extends State<BarChartView> {
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
        primaryYAxis: NumericAxis(isVisible: false, minimum: 0, maximum: 200),
        series: getData(),
        tooltipBehavior: TooltipBehavior(
          enable: true,
          canShowMarker: false,
          format: 'point.x : point.y',
          header: '',
        ),
      ),
    );
  }

  List<ColumnSeries<ChartSampleData, String>> getData() {
    final List<ChartSampleData> chartData = <ChartSampleData>[
      ChartSampleData(x: 'Jan', y: 120, yValue2: 70, yValue3: 91),
      ChartSampleData(x: 'Feb', y: 111, yValue2: 90, yValue3: 91),
      ChartSampleData(x: 'Mar', y: 99, yValue2: 110, yValue3: 91),
      ChartSampleData(x: 'Apr', y: 123, yValue2: 150, yValue3: 91),
      ChartSampleData(x: 'Mei', y: 110, yValue2: 90, yValue3: 91),
      ChartSampleData(x: 'Jun', y: 200, yValue2: 10, yValue3: 91),
      ChartSampleData(x: 'Jul', y: 122, yValue2: 30, yValue3: 91),
      ChartSampleData(x: 'Aug', y: 101, yValue2: 110, yValue3: 91),
      ChartSampleData(x: 'Sep', y: 122, yValue2: 80, yValue3: 91),
      ChartSampleData(x: 'Okt', y: 190, yValue2: 13, yValue3: 91),
      ChartSampleData(x: 'Nov', y: 121, yValue2: 141, yValue3: 91),
      ChartSampleData(x: 'Des', y: 123, yValue2: 91, yValue3: 91),
    ];

    return <ColumnSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(
        enableTooltip: true,
        width: 0.8,
        animationDuration: 0,
        spacing: 0.3,
        legendIconType: LegendIconType.rectangle,
        legendItemText: 'Context',
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
        width: 0.8,
        spacing: 0.3,
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
        width: 0.8,
        spacing: 0.3,
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
    ];
  }
}
