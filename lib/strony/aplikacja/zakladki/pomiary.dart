import 'package:flutter/material.dart';

class Pomiary extends StatefulWidget {
  const Pomiary({super.key});

  @override
  _PomiaryState createState() => _PomiaryState();
}

class _PomiaryState extends State<Pomiary> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _measurements = {
    'wzrost': '',
    'waga': '',
    'klatka piersiowa': '',
    'szyja/kark': '',
    'brzuch': '',
    'biodra': '',
    'talia': '',
    'ramię/biceps': '',
    'udo': '',
    'łydka': '',
  };

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Przetwarzanie danych pomiarów
      print(_measurements);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pomiary zostały zapisane.')),
      );
    }
  }

  void _showMeasurementGuide() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Jak się mierzyć?'),
          content: Image.asset('assets/img/measurement_guide.png'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Zamknij'),
            ),
          ],
        );
      },
    );
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
            'Pomiary Ciała',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              ..._measurements.keys.map((key) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        key,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white70,
                        ),
                        style: TextStyle(color: Colors.black),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Proszę wprowadzić wartość';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _measurements[key] = value!;
                        },
                      ),
                    ],
                  ),
                );
              }).toList()
                ..add(
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      onPressed: _showMeasurementGuide,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: const Text(
                          'Jak się mierzyć?',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18, // Zwiększ rozmiar czcionki
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                ..add(
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      onPressed: _submitForm,
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
                            'Zapisz Pomiary',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
