import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/providers/get_city_forecast_provider.dart';
import 'package:weather_app/views/gradient_container.dart';
import '/extensions/strings.dart'; // Import the file where the extension is defined
import '/constants/text_styles.dart';
import '/extensions/datetime.dart';
import '/screens/weather_screen/weather_info.dart';

class WeatherDetailScreen extends ConsumerWidget {
  const WeatherDetailScreen({
    super.key,
    required this.cityName,
  });

  final String cityName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherData = ref.watch(cityForecastProvider(cityName));

    return Scaffold(
      body: weatherData.when(
        data: (weather) {
          return GradientContainer(
            children: [
              // Custom Back Button
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white, // Set the back button color to white
                  ),
                  onPressed: () {
                    // Navigate back to the HomeScreen
                    Navigator.of(context).pop();
                  },
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  // City name
                  Text(
                    weather.name,
                    style: TextStyles.h1,
                  ),
                  const SizedBox(height: 20),
                  // Today's date
                  Text(
                    DateTime.now().dateTime,
                    style: TextStyles.subtitleText,
                  ),
                  const SizedBox(height: 50),
                  // Weather icon
                  SizedBox(
                    height: 300,
                    child: Image.asset(
                      'assets/icons/${weather.weather[0].icon.replaceAll('n', 'd')}.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 50),
                  // Weather description
                  Text(
                    weather.weather[0].description.capitalize,
                    style: TextStyles.h2,
                  ),
                ],
              ),
              const SizedBox(height: 40),
              // Weather info in a row
              WeatherInfo(weather: weather),
              const SizedBox(height: 15),
            ],
          );
        },
        error: (error, stackTrace) {
          return const Center(
            child: Text(
              'An error has occurred',
            ),
          );
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}