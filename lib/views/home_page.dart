// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controllers/theme_controller.dart';
import 'package:weather_app/controllers/weather_controller.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/services/helper_functions.dart';
import 'package:weather_app/services/theme.dart';

class HomePage extends GetView<WeatherController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(WeatherController());
    ThemeData thememode = HelperFunctions.getCurrentThemeData(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        drawer: Drawer(
            child: ListView(
          children: [
            SizedBox(
              width: context.width - 30,
              child: ListTile(
                leading: Text(
                  thememode == lightMode
                      ? 'Turn to dark Mode'
                      : 'Turn to light Mode',
                  style: const TextStyle(fontFamily: 'Anton', fontSize: 16),
                ),
                title: IconButton(
                  onPressed: () {
                    Provider.of<ThemeController>(context, listen: false)
                        .toggleTheme();
                  },
                  icon: Icon(thememode == lightMode
                      ? Icons.dark_mode
                      : Icons.light_mode),
                ),
              ),
            )
          ],
        )),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
                child: Obx(
              () => controller.wthr.value.cityName == ""
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          // height: MediaQuery.of(context).size.height - 24,
                          // width: MediaQuery.of(context).size.width,
                          // decoration: const BoxDecoration(color: Colors.red),
                          child: SizedBox(
                            height: context.height * 0.6,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller.wthr.value.cityName,
                                      style: const TextStyle(
                                          fontFamily: "Anton", fontSize: 42),
                                    ),
                                    Text(
                                      '${controller.wthr.value.temperature} °C',
                                      style: const TextStyle(
                                          fontFamily: 'Anton', fontSize: 22),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Min Temp: ${controller.wthr.value.mintemperature} °C',
                                          style: const TextStyle(
                                              fontFamily: 'Anton',
                                              fontSize: 18),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Max temp: ${controller.wthr.value.maxtemperature} °C',
                                          style: const TextStyle(
                                              fontFamily: 'Anton',
                                              fontSize: 18),
                                        )
                                      ],
                                    )
                                  ],
                                ),

                                // animations
                                SizedBox(
                                  height: context.height / 3,
                                  child: Column(
                                    children: [
                                      Lottie.asset(controller
                                          .getWeatherAnimation(controller
                                              .wthr.value.mainCondition)),
                                      Text(
                                        controller.wthr.value.mainCondition,
                                        style: const TextStyle(
                                            fontFamily: "Anton", fontSize: 22),
                                      ),
                                    ],
                                  ),
                                )
                                // Add other weather data here
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
            )),
          ),
        ),
      ),
    );
  }
}
