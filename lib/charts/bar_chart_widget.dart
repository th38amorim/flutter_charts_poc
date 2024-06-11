import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AnimatedBarChartWidget extends StatefulWidget {
  const AnimatedBarChartWidget({super.key});

  @override
  State<StatefulWidget> createState() => _AnimatedBarChartWidgetState();
}

class _AnimatedBarChartWidgetState extends State<AnimatedBarChartWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
        setState(() {});
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _restartAnimation() {
    _controller.reset();
    _controller.forward();
  }

  List<BarChartGroupData> _getAnimatedBarGroups() {
    return [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
            toY: 8 * _animation.value,
            color: Colors.white,
            width: 22,
            borderSide: BorderSide.none,
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 20,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
            toY: 10 * _animation.value,
            color: Colors.white,
            width: 22,
            borderSide: BorderSide.none,
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 20,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(
            toY: 14 * _animation.value,
            color: Colors.white,
            width: 22,
            borderSide: BorderSide.none,
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 20,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barRods: [
          BarChartRodData(
            toY: 15 * _animation.value,
            color: Colors.white,
            width: 22,
            borderSide: BorderSide.none,
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 20,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
      BarChartGroupData(
        x: 4,
        barRods: [
          BarChartRodData(
            toY: 13 * _animation.value,
            color: Colors.white,
            width: 22,
            borderSide: BorderSide.none,
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 20,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
      BarChartGroupData(
        x: 5,
        barRods: [
          BarChartRodData(
            toY: 10 * _animation.value,
            color: Colors.white,
            width: 22,
            borderSide: BorderSide.none,
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 20,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
      BarChartGroupData(
        x: 6,
        barRods: [
          BarChartRodData(
            toY: 9 * _animation.value,
            color: Colors.white,
            width: 22,
            borderSide: BorderSide.none,
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 20,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: _restartAnimation,
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 300,
          width: 350,
          child: Align(
            alignment: Alignment.center,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 20,
                gridData: const FlGridData(
                  show: false,
                ),
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        rod.toY.toString(),
                        const TextStyle(color: Colors.white),
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        const style = TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        );
                        Widget text;
                        switch (value.toInt()) {
                          case 0:
                            text = const Text('S', style: style);
                            break;
                          case 1:
                            text = const Text('M', style: style);
                            break;
                          case 2:
                            text = const Text('T', style: style);
                            break;
                          case 3:
                            text = const Text('W', style: style);
                            break;
                          case 4:
                            text = const Text('T', style: style);
                            break;
                          case 5:
                            text = const Text('F', style: style);
                            break;
                          case 6:
                            text = const Text('S', style: style);
                            break;
                          default:
                            text = const Text('', style: style);
                            break;
                        }
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          space: 4, // Ajuste este valor conforme necessÃ¡rio
                          child: text,
                        );
                      },
                    ),
                  ),
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: _getAnimatedBarGroups(),
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
