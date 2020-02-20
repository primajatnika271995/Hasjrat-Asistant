import 'package:flutter/material.dart';
import 'package:salles_tools/src/models/example_radial_chart_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RadialChartView extends StatefulWidget {
  @override
  _RadialChartViewState createState() => _RadialChartViewState();
}

class _RadialChartViewState extends State<RadialChartView> {
  List<RadialBarSeries<ChartSampleData, String>> getData() {
    final List<ChartSampleData> chartData = <ChartSampleData>[
      ChartSampleData(
        x: 'On Track \n Rp 7.850.000',
        y: 58,
        text: 'On Track',
        xValue: null,
        pointColor: Colors.yellowAccent,
      ),
      ChartSampleData(
        x: 'Target \n Rp 10.000.000',
        y: 100,
        text: 'Target',
        xValue: null,
        pointColor: Colors.white,
      ),
    ];

    final List<RadialBarSeries<ChartSampleData, String>> list =
        <RadialBarSeries<ChartSampleData, String>>[
      RadialBarSeries<ChartSampleData, String>(
          pointRadiusMapper: (ChartSampleData data, _) => data.xValue,
          maximumValue: 100,
          animationDuration: 0,
          legendIconType: LegendIconType.rectangle,
          radius: '100%',
          trackColor: Colors.transparent,
          innerRadius: '75%',
          gap: '2%',
          dataSource: chartData,
          cornerStyle: CornerStyle.bothFlat,
          xValueMapper: (ChartSampleData data, _) => data.x,
          yValueMapper: (ChartSampleData data, _) => data.y,
          pointColorMapper: (ChartSampleData data, _) => data.pointColor,
          dataLabelMapper: (ChartSampleData data, _) => data.text,
          dataLabelSettings: DataLabelSettings(isVisible: false))
    ];
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      child: SfCircularChart(
        annotations: <CircularChartAnnotation>[
          CircularChartAnnotation(
            angle: 0,
            radius: '0%',
            widget: Text(
              "58%",
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.w700
              ),
            ),
          ),
        ],
        legend: Legend(
          isVisible: true,
          iconHeight: 15,
          iconWidth: 15,
          textStyle: ChartTextStyle(
            color: Colors.white,
          ),
          isResponsive: true,
          overflowMode: LegendItemOverflowMode.wrap,
        ),
        tooltipBehavior: TooltipBehavior(enable: true, format: 'point.x'),
        series: getData(),
      ),
    );
  }
}
