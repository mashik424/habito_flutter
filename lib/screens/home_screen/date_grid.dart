import 'package:flutter/material.dart';
import 'package:habito_flutter/utils/date_extension.dart';

class DatesGrid extends StatelessWidget {
  const DatesGrid({required this.color, required this.dates, super.key});

  final Color color;
  final List<int> dates;

  @override
  Widget build(BuildContext context) {
    final currentMonday = DateTime.now().normalizedDate.getStartOfWeek();

    return SizedBox(
      width: double.infinity,
      height: 72.8,
      child: Directionality(
         textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(52, (weekIndex) {
              final weekStart = currentMonday.getStartOfWeek(
                offsetWeeks: -weekIndex,
              );
              return Column(
                children: List.generate(7, (dayIndex) {
                  final date =
                      weekStart.getDateForWeekAndDay(dayIndex).normalizedDate;
        
                  final finalColor =
                      dates.contains(date.millisecondsSinceEpoch)
                          ? color
                          : color.withAlpha((0.1 * 255).round());
        
                  return Container(
                    height: 8,
                    width: 8,
                    margin: const EdgeInsets.all(1.2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1),
                      color: finalColor,
                    ),
                  );
                }),
              );
            }),
          ),
        ),
      ),
    );
  }
}
