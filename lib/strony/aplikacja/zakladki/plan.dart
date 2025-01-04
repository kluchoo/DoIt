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
        title: Text('Plan Treningowy'),
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
                    child: Text('Dodaj ćwiczenie'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addWorkout,
        child: Icon(Icons.add),
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
