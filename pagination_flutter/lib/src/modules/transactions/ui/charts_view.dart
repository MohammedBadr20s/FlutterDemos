import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart' as charts;
import 'package:pagination_flutter/src/modules/transactions/model/chartModel.dart';
import 'package:intl/intl.dart';
import 'package:pagination_flutter/src/components/Strings+Extension.dart';

class ChartsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الرسومات'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Container(
        child: Column(
          children: [
            Container(height: 10),
            Container(
                height: 300,
                width: MediaQuery.of(context).size.width * 0.95,
                child: LineChart.withSampleData()),
            Container(height: 20),
            Container(
                height: 300,
                width: MediaQuery.of(context).size.width * 0.95,
                child: PieChartView.withSampleData()
            )
          ],
        ),
      ),
    );
  }
}

class LineChart extends StatelessWidget {
  final List<LinearSales> seriesList;
  final bool animate;
  charts.TooltipBehavior tooltipBehavior;

  LineChart({this.seriesList, this.animate, this.tooltipBehavior});

  factory LineChart.withSampleData() {
    return new LineChart(
      seriesList: getChartData(),
      // Disable animations for image tests.
      animate: true,
      tooltipBehavior: charts.TooltipBehavior(
          enable: true,
          builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
              int seriesIndex) {
            return Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(5))
                ),
                child: Text(" ${enToArDigits('${(data as LinearSales).sales}')} ", style: TextStyle(color: Colors.white))
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.SfCartesianChart(
      title: charts.ChartTitle(text: 'LineChart'),
      legend: charts.Legend(isVisible: false),
      tooltipBehavior: tooltipBehavior,
      onAxisLabelRender: (charts.AxisLabelRenderArgs args) {
        if (args.axisName == "primaryYAxis") {
          args.text = "${enToArDigits(args.text)} ريال";
        } else {
          args.text = "${enToArDigits(args.text)} عمر ";
        }

        TextStyle textStyle = args.textStyle;
        args.textStyle = textStyle.copyWith(fontSize: 17);
      },

      series: <charts.ChartSeries>[
        charts.LineSeries<LinearSales, int>(
            name: 'Sales',
            dataSource: getChartData(),
            xValueMapper: (LinearSales sales, _) => sales.year,
            yValueMapper: (LinearSales sales, _) => sales.sales,

            dataLabelMapper: (LinearSales data, index) => enToArDigits("${data.sales}"),
            dataLabelSettings: charts.DataLabelSettings(
                isVisible: true, alignment: charts.ChartAlignment.center),
            enableTooltip: true)
      ],
      primaryXAxis: charts.NumericAxis(
          edgeLabelPlacement: charts.EdgeLabelPlacement.shift,
          isInversed: true),
      primaryYAxis: charts.NumericAxis(
          numberFormat: NumberFormat.compact(locale: 'ar'),
          opposedPosition: true),
    );
  }

  /// Create one series with sample hard coded data.
  static List<LinearSales> getChartData() {
    final List<LinearSales> chartData = [
      new LinearSales(0, 100),
      new LinearSales(1, 75),
      new LinearSales(2, 25),
      new LinearSales(3, 5),
    ];

    return chartData;
  }
}


class PieChartView extends StatelessWidget {
  final List<LinearSales> seriesList;
  final bool animate;
  charts.TooltipBehavior tooltipBehavior;
   PieChartView({this.seriesList, this.animate, this.tooltipBehavior});
  /// Creates a [PieChart] with sample data and no transition.
  factory PieChartView.withSampleData() {
    return new PieChartView(
      seriesList: getChartData(),
      // Disable animations for image tests.
      animate: true,
      tooltipBehavior: charts.TooltipBehavior(
          enable: true,
          builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
              int seriesIndex) {
            return Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(5))
                ),
                child: Text(" ${enToArDigits('${(data as LinearSales).sales}')} ", style: TextStyle(color: Colors.white))
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.SfCircularChart(
      title: charts.ChartTitle(text: 'Pie Chart'),
      legend: charts.Legend(isVisible: false),
      tooltipBehavior: tooltipBehavior,
      series: <charts.CircularSeries>[
        charts.DoughnutSeries<LinearSales, int>(
          dataSource: getChartData(),
          xValueMapper: (LinearSales data, _) => data.sales,
          yValueMapper: (LinearSales data, _) => data.year,
          dataLabelMapper: (LinearSales data, index) => enToArDigits("${data.sales}"),
          dataLabelSettings: charts.DataLabelSettings(
              isVisible: true, alignment: charts.ChartAlignment.center),

        )
      ],
    );
  }

  /// Create one series with sample hard coded data.
  static List<LinearSales> getChartData() {
    final List<LinearSales> chartData = [
      new LinearSales(1, 100),
      new LinearSales(2, 75),
      new LinearSales(3, 25),
      new LinearSales(4, 5),
    ];

    return chartData;
  }
}
