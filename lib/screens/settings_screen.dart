import 'package:flutter/material.dart';
import 'package:weather_app/views/gradient_container.dart';


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      children: [
        SwitchListTile(
          title: const Text('Dark Theme'),
          value: isDarkTheme,
          onChanged: (val) => setState(() => isDarkTheme = val),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height - 150,
          width: double.infinity,
          child: const Center(
            child: Text(
              'Settings',
              style: TextStyle(
                fontSize: 50,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
