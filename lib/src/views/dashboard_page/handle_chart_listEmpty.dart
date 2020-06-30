import 'package:flutter/material.dart';
import 'package:salles_tools/src/models/dashboard_target_model.dart';
import 'package:salles_tools/src/models/example_radial_chart_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HandleChartEmptyValue extends StatefulWidget {
  const HandleChartEmptyValue({Key key}) : super(key: key);
  @override
  _HandleChartEmptyValueState createState() => _HandleChartEmptyValueState();
}

class _HandleChartEmptyValueState extends State<HandleChartEmptyValue> {
  List<RadialBarSeries<ChartSampleData, String>> getData() {
    final List<ChartSampleData> chartData = <ChartSampleData>[
      ChartSampleData(
        x: 'Terjual 0 Unit',
        y: 0,
        text: 'Terjual',
        xValue: null,
        pointColor: Colors.yellowAccent,
      ),
      ChartSampleData(
        x: 'Target Penjualan 0 Unit',
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
              "0 %",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.w700),
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
