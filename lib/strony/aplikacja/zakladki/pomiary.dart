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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pomiary Ciała'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: _measurements.keys.map((key) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      key,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                    onPressed: _submitForm,
                    child: Text('Zapisz Pomiary'),
                  ),
                ),
              ),
          ),
        ),
      ),
    );
  }
}
