import 'package:flutter/material.dart';
import 'package:weather_app/views/famous_cities_weather.dart';
import 'package:weather_app/views/gradient_container.dart';
import 'package:weather_app/widgets/round_text_field.dart';
import 'package:weather_app/screens/weather_detail_screen.dart'; // Import the WeatherDetailScreen

import '/constants/app_colors.dart';
import '/constants/text_styles.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchCity() {
    final cityName = _searchController.text.trim();
    if (cityName.isNotEmpty) {
      // Navigate to the WeatherDetailScreen with the searched city name
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => WeatherDetailScreen(cityName: cityName),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      children: [
        // Page title
        const Align(
          alignment: Alignment.center,
          child: Text(
            'Pick Location',
            style: TextStyles.h1,
          ),
        ),

        const SizedBox(height: 20),

        // Page subtitle
        const Text(
          'Find the area or city that you want to know the detailed weather info at this time',
          style: TextStyles.subtitleText,
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 40),

        // Pick location row
        Row(
          children: [
            // Choose city text field
            Expanded(
              child: RoundTextField(
                controller: _searchController,
                onSubmitted: (_) => _searchCity(), // Trigger search on submit
              ),
            ),
            const SizedBox(width: 15),

            // Location icon
            GestureDetector(
              onTap: _searchCity, // Trigger search when the icon is tapped
              child: const LocationIcon(),
            ),
          ],
        ),

        const SizedBox(height: 30),

        const FamousCitiesWeather(),
      ],
    );
  }
}

class LocationIcon extends StatelessWidget {
  const LocationIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 55,
      decoration: BoxDecoration(
        color: AppColors.accentBlue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Icon(
        Icons.location_on_outlined,
        color: AppColors.grey,
      ),
    );
  }
}