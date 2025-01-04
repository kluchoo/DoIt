import 'package:do_it/theme.dart';
import 'package:flutter/material.dart';

class Plan extends StatefulWidget {
  @override
  _PlanState createState() => _PlanState();
}

class _PlanState extends State<Plan> {
  List<Workout> workouts = [];

  void _addWorkout() {
    setState(() {
      workouts.add(Workout(date: DateTime.now(), exercises: []));
    });
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
            iconSize: const WidgetStatePropertyAll(40),
            backgroundColor: WidgetStatePropertyAll(
                AppColors.primaryColor), // Replace with your desired color
            iconColor: const WidgetStatePropertyAll(Colors.black),
            elevation: const WidgetStatePropertyAll(0),
          ),
          onPressed: _addWorkout,
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class Workout {
  DateTime date;
  List<Exercise> exercises;

  Workout({required this.date, required this.exercises});
}

class Exercise {
  String name;

  Exercise({required this.name});
}
