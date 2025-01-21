import 'package:flutter/material.dart';

class Aystent extends StatefulWidget {
  const Aystent({super.key});

  @override
  _AystentState createState() => _AystentState();
}

class _AystentState extends State<Aystent> {
  final _bmiFormKey = GlobalKey<FormState>();
  final _calorieFormKey = GlobalKey<FormState>();
  double _bmiResult = 0.0;
  double _calorieResult = 0.0;

  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _activityLevelController =
      TextEditingController();

  void _calculateBMI() {
    if (_bmiFormKey.currentState!.validate()) {
      try {
        double height = double.parse(_heightController.text) / 100;
        double weight = double.parse(_weightController.text);
        setState(() {
          _bmiResult = weight / (height * height);
        });
      } catch (e) {
        debugPrint('Błąd podczas obliczania BMI: $e');
      }
    }
  }

  String _bmiCategory(double bmi) {
    if (bmi < 18.5) {
      return 'Niedowaga';
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      return 'Prawidłowa waga';
    } else if (bmi >= 25.0 && bmi <= 29.9) {
      return 'Nadwaga';
    } else {
      return 'Otyłość';
    }
  }

  void _calculateCalories() {
    if (_calorieFormKey.currentState!.validate()) {
      try {
        double weight = double.parse(_weightController.text);
        int age = int.parse(_ageController.text);
        double height = double.parse(_heightController.text) / 100;
        double activityLevel = double.parse(_activityLevelController.text);
        setState(() {
          _calorieResult = (10 * weight + 6.25 * (height * 100) - 5 * age + 5) *
              activityLevel;
        });
      } catch (e) {
        debugPrint('Błąd podczas obliczania zapotrzebowania kalorycznego: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(
            gradient: const SweepGradient(
              colors: [Color(0xffffde59), Color(0xfffc466b)],
              stops: [0.2, 0.7],
              center: Alignment.topRight,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: const Text(
            'Asystent Treningowy',
            style: TextStyle(
              color: Colors.black, // Czarny kolor tekstu
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Kalkulator BMI
            Form(
              key: _bmiFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Kalkulator BMI',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    controller: _heightController,
                    decoration: const InputDecoration(labelText: 'Wzrost (cm)'),
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                        color: Color(0xFF8B4513)), // Dodano kolor jasnobrązowy
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Proszę wprowadzić wzrost';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _weightController,
                    decoration: const InputDecoration(labelText: 'Waga (kg)'),
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                        color: Color(0xFF8B4513)), // Dodano kolor jasnobrązowy
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Proszę wprowadzić wagę';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: _calculateBMI,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: EdgeInsets.zero,
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: const SweepGradient(
                          colors: [Color(0xffffde59), Color(0xfffc466b)],
                          stops: [0.2, 0.7],
                          center: Alignment.topRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: const Text(
                          'Oblicz BMI',
                          style: TextStyle(
                            color: Colors.black, // Czarny kolor tekstu
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text('Twoje BMI: $_bmiResult'),
                  Text('Kategoria BMI: ${_bmiCategory(_bmiResult)}'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Kalkulator zapotrzebowania kalorycznego
            Form(
              key: _calorieFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Kalkulator zapotrzebowania kalorycznego',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    controller: _weightController,
                    decoration: const InputDecoration(labelText: 'Waga (kg)'),
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                        color: Color(0xFF8B4513)), // Dodano kolor jasnobrązowy
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Proszę wprowadzić wagę';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _heightController,
                    decoration: const InputDecoration(labelText: 'Wzrost (cm)'),
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                        color: Color(0xFF8B4513)), // Dodano kolor jasnobrązowy
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Proszę wprowadzić wzrost';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _ageController,
                    decoration: const InputDecoration(labelText: 'Wiek (lata)'),
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                        color: Color(0xFF8B4513)), // Dodano kolor jasnobrązowy
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Proszę wprowadzić wiek';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _activityLevelController,
                    decoration: const InputDecoration(
                        labelText: 'Poziom aktywności (1-3)'),
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                        color: Color(0xFF8B4513)), // Dodano kolor jasnobrązowy
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Proszę wprowadzić poziom aktywności';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: _calculateCalories,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: EdgeInsets.zero,
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: const SweepGradient(
                          colors: [Color(0xffffde59), Color(0xfffc466b)],
                          stops: [0.2, 0.7],
                          center: Alignment.topRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: const Text(
                          'Oblicz zapotrzebowanie kaloryczne',
                          style: TextStyle(
                            color: Colors.black, // Czarny kolor tekstu
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                      'Twoje zapotrzebowanie kaloryczne: $_calorieResult kcal'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Asystent snu
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Asystent snu',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Zmieniono kolor na biały
                  ),
                ),
                SizedBox(height: 10),
                Text('1. Kładź się spać i wstawaj zawsze o tej samej porze'),
                Text(
                    '2. Przed snem zajmij się czymś, co pozwoli ci się zrelaksować'),
                Text('3. Zjedz przed snem pełnowartościowy posiłek'),
                Text(
                    '4. Przed snem wypij gorący napój, który nie zawiera kofeiny'),
                Text('5. Unikaj kofeiny i alkoholu (szczególnie wieczorem)'),
                Text(
                    '6. Śpij w znajomym, ciemnym i cichym pomieszczeniu, które jest dobrze przewietrzone i ma odpowiednią temperaturę'),
                Text(
                    '7. Jeśli sen nie nadchodzi, postaraj się nie denerwować i nie zmuszać do spania'),
                Text('8. Ćwicz regularnie'),
                Text('9. Zredukuj poziom codziennego stresu'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
