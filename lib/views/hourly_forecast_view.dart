import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/constants/app_colors.dart';
import '/constants/text_styles.dart';
import '/extensions/int.dart';
import '/providers/get_hourly_forecast_provider.dart';
import '/utils/get_weather_icons.dart';

class HourlyForecastView extends ConsumerWidget {
  const HourlyForecastView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hourlyWeather = ref.watch(hourlyForecastProvider);

    return hourlyWeather.when(
      data: (hourlyForecast) {
        return SizedBox(
          height: 100,
          child: ListView.builder(
            itemCount: 12,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final forecast = hourlyForecast.list[index];
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: HourlyForcastTile(
                  id: forecast.weather[0].id,
                  hour: forecast.dt.time,
                  temp: forecast.main.temp.round(),
                  isActive: index == 0,
                ),
              );
            },
          ),
        );
      },
      error: (error, stackTrace) {
        return Center(
          child: Text(error.toString()),
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class HourlyForcastTile extends StatefulWidget {
  const HourlyForcastTile({
    super.key,
    required this.id,
    required this.hour,
    required this.temp,
    required this.isActive,
  });

  final int id;
  final String hour;
  final int temp;
  final bool isActive;

  @override
  State<HourlyForcastTile> createState() => _HourlyForcastTileState();
}

class _HourlyForcastTileState extends State<HourlyForcastTile> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Material(
        color: widget.isActive || isHovered
            ? const Color.fromARGB(255, 29, 182, 228)
            : AppColors.accentBlue,
        borderRadius: BorderRadius.circular(15.0),
        elevation: widget.isActive || isHovered ? 8 : 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                getWeatherIcon(weatherCode: widget.id),
                width: 50,
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.hour,
                    style: const TextStyle(
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${widget.temp}°',
                    style: TextStyles.h3,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
