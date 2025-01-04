import 'package:do_it/theme.dart';
import 'package:flutter/material.dart';

class Plan extends StatefulWidget {
  @override
  _PlanState createState() => _PlanState();
}

class _PlanState extends State<Plan> {
  List<Workout> workouts = [];

  void _addWorkout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String workoutName = '';
        DateTime selectedDate = DateTime.now();

        return AlertDialog(
          title: const Text('Dodaj Trening'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Nazwa Treningu'),
                onChanged: (value) {
                  workoutName = value;
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != selectedDate) {
                    setState(() {
                      selectedDate = picked;
                    });
                  }
                },
                child: Text('Wybierz Datę'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Anuluj'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  workouts.add(Workout(
                      name: workoutName, date: selectedDate, exercises: []));
                });
                Navigator.of(context).pop();
              },
              child: const Text('Dodaj'),
            ),
          ],
        );
      },
    );
  }

  void _addExercise(int index) {
    setState(() {
      workouts[index].exercises.add(Exercise(name: 'Nowe ćwiczenie'));
    });
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
            'Twój Plan',
            style: TextStyle(
              color: Colors.black, // Czarny kolor tekstu
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: workouts.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nazwa: ${workouts[index].name}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Data: ${workouts[index].date.toLocal()}'.split(' ')[0],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: workouts[index].exercises.length,
                    itemBuilder: (context, exerciseIndex) {
                      return ListTile(
                        title:
                            Text(workouts[index].exercises[exerciseIndex].name),
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => _addExercise(index),
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
                          'Dodaj ćwiczenie',
                          style: TextStyle(
                            color: Colors.black, // Czarny kolor tekstu
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 16, 16),
        child: IconButton.filled(
          style: ButtonStyle(
            iconSize: const MaterialStatePropertyAll(40),
            backgroundColor: WidgetStatePropertyAll(
                AppColors.primaryColor), // Replace with your desired color
            iconColor: const MaterialStatePropertyAll(Colors.black),
            elevation: const MaterialStatePropertyAll(0),
          ),
          onPressed: _addWorkout,
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class Workout {
  String name;
  DateTime date;
  List<Exercise> exercises;

  Workout({required this.name, required this.date, required this.exercises});
}

class Exercise {
  String name;

  Exercise({required this.name});
}
