import 'dart:async';
import 'package:flutter/material.dart';
import 'package:light_sensor/light_sensor.dart';
import 'package:screen_brightness/screen_brightness.dart';

class AutoBrightnessViewModel extends ChangeNotifier {
  double _brightness = 0.5;
  bool _isAutoBrightnessEnabled = false;
  StreamSubscription<int>? _lightSubscription;
  StreamSubscription<double>? _systemBrightnessSubscription;

  double get brightness => _brightness;
  bool get isAutoBrightnessEnabled => _isAutoBrightnessEnabled;

  AutoBrightnessViewModel() {
    _observeSystemBrightness();
  }

  @override
  void dispose() {
    _lightSubscription?.cancel();
    _systemBrightnessSubscription?.cancel();
    super.dispose();
  }

  Future<void> toggleAutoBrightness(bool isEnabled) async {
    _isAutoBrightnessEnabled = isEnabled;
    if (isEnabled) {
      _enableAutoBrightness();
    } else {
      _disableAutoBrightness();
    }
  }

  void _enableAutoBrightness() {
    _lightSubscription = LightSensor.luxStream().listen((lux) {
      double calculatedBrightness = (lux / 1000).clamp(0.1, 1.0);

      if (calculatedBrightness != _brightness) {
        _brightness = calculatedBrightness;
        ScreenBrightness.instance.setApplicationScreenBrightness(_brightness);
        notifyListeners();
      }
    });
  }

  Future<void> _disableAutoBrightness() async {
    _lightSubscription?.cancel();
    _lightSubscription = null;
    ScreenBrightness.instance
        .setApplicationScreenBrightness(await ScreenBrightness.instance.system);

    notifyListeners();
  }

  void _observeSystemBrightness() {
    _systemBrightnessSubscription = ScreenBrightness
        .instance.onSystemScreenBrightnessChanged
        .listen((systemBrightness) {
      if (!_isAutoBrightnessEnabled) {
        _brightness = systemBrightness;
        ScreenBrightness.instance.setApplicationScreenBrightness(_brightness);
        notifyListeners();
      }
    });
  }
}
