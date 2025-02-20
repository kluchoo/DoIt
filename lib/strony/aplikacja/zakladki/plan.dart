import 'package:do_it/providers/home_page_providers.dart';
import 'package:do_it/theme.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Plan extends ConsumerStatefulWidget {
  @override
  _PlanState createState() => _PlanState();
  Map<String, dynamic> serializeProgress(
      String name, String dateString, List<Exercise> exercises) {
    return {
      'name': name,
      'date': dateString,
      'exercises': exercises.map((exercise) => exercise.toMap()).toList(),
    };
  }
}

class _PlanState extends ConsumerState<Plan> {
  List<Workout> workouts = [];

  @override
  void initState() {
    super.initState();
    _fetchWorkouts();
  }

  Future<void> _fetchWorkouts() async {
    final uid = ref.read(appUserProvider).uid;
    debugPrint('UID: $uid'); // Dodaj debugowanie UID
    try {
      final docSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      final data = docSnapshot.data()?['workouts'];
      if (data != null && data is List) {
        deserializeWorkouts(List<Map<String, dynamic>>.from(data));
      }
    } catch (e) {
      debugPrint('Błąd podczas pobierania treningów: $e');
    }
  }

  void deserializeWorkouts(List<Map<String, dynamic>> data) {
    workouts = data.map((workoutData) {
      return Workout(
        id: workoutData['id'] ?? '',
        name: workoutData['name'] ?? '',
        date: DateTime.parse(workoutData['date']),
        dateString: workoutData['date'],
        exercises:
            (workoutData['exercises'] as List<dynamic>).map((exerciseData) {
          return Exercise(
            name: exerciseData['name'] ?? '',
            weight: exerciseData['weight'] ?? '',
            repetitions: exerciseData['repetitions'] ?? '',
            sets: exerciseData['sets'] ?? '',
          );
        }).toList(),
      );
    }).toList();
    setState(() {});
  }

  Future<void> _saveWorkout(Workout workout) async {
    final uid = ref.read(appUserProvider).uid;
    debugPrint('UID: $uid'); // Dodaj debugowanie UID
    if (uid == null) {
      debugPrint('Użytkownik nie jest zalogowany');
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).update(
        {
          'workouts': workouts
              .map((workout) => widget.serializeProgress(
                  workout.name, workout.dateString, workout.exercises))
              .toList(),
        },
      );
    } catch (e) {
      debugPrint('Błąd podczas zapisywania treningu: $e');
    }
  }

  Future<void> _deleteWorkout(int index) async {
    final uid = ref.read(appUserProvider).uid;
    debugPrint('UID: $uid'); // Dodaj debugowanie UID
    if (uid == null) {
      debugPrint('Użytkownik nie jest zalogowany');
      return;
    }

    try {
      final docRef = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('workouts')
          .doc(workouts[index].id);

      await docRef.delete();
    } catch (e) {
      debugPrint('Błąd podczas usuwania treningu: $e');
    }
  }

  void _addWorkout() {
    _fetchWorkouts();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String workoutName = '';
        String workoutDate = '';

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
              TextField(
                decoration: const InputDecoration(
                    labelText: 'Data Treningu (YYYY-MM-DD)'),
                onChanged: (value) {
                  workoutDate = value;
                },
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
              onPressed: () async {
                final newWorkout = Workout(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: workoutName,
                  date: DateTime.parse(workoutDate),
                  dateString: workoutDate,
                  exercises: [],
                );
                setState(() {
                  workouts.insert(0, newWorkout);
                });
                await _saveWorkout(newWorkout);
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String exerciseName = '';
        String weight = '';
        String repetitions = '';
        String sets = '';

        return AlertDialog(
          title: const Text('Dodaj Ćwiczenie'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration:
                      const InputDecoration(labelText: 'Nazwa Ćwiczenia'),
                  onChanged: (value) {
                    exerciseName = value;
                  },
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Ciężar'),
                  onChanged: (value) {
                    weight = value;
                  },
                ),
                TextField(
                  decoration:
                      const InputDecoration(labelText: 'Ilość Powtórzeń'),
                  onChanged: (value) {
                    repetitions = value;
                  },
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Ilość Serii'),
                  onChanged: (value) {
                    sets = value;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Anuluj'),
            ),
            TextButton(
              onPressed: () async {
                setState(() {
                  workouts[index].exercises.add(Exercise(
                        name: exerciseName,
                        weight: weight,
                        repetitions: repetitions,
                        sets: sets,
                      ));
                });
                await _saveWorkout(workouts[index]);
                Navigator.of(context).pop();
              },
              child: const Text('Dodaj'),
            ),
          ],
        );
      },
    );
  }

  void _removeWorkout(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Usuń Trening'),
          content: const Text(
            'Czy na pewno chcesz usunąć ten trening?',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Anuluj'),
            ),
            TextButton(
              onPressed: () async {
                await _deleteWorkout(index);
                setState(() {
                  workouts.removeAt(index);
                });
                Navigator.of(context).pop();
              },
              child: const Text('Usuń'),
            ),
          ],
        );
      },
    );
  }

  void _removeExercise(int workoutIndex, int exerciseIndex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Usuń Ćwiczenie'),
          content: const Text(
            'Czy na pewno chcesz usunąć to ćwiczenie?',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Anuluj'),
            ),
            TextButton(
              onPressed: () async {
                setState(() {
                  workouts[workoutIndex].exercises.removeAt(exerciseIndex);
                });
                await _saveWorkout(workouts[workoutIndex]);
                Navigator.of(context).pop();
              },
              child: const Text('Usuń'),
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
          return GestureDetector(
            onLongPress: () => _removeWorkout(index),
            child: Card(
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nazwa: ${workouts[index].name}',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      'Data: ${workouts[index].dateString}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Czarny kolor tekstu
                      ),
                    ),
                    SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: workouts[index].exercises.length,
                      itemBuilder: (context, exerciseIndex) {
                        final exercise =
                            workouts[index].exercises[exerciseIndex];
                        return GestureDetector(
                          onLongPress: () =>
                              _removeExercise(index, exerciseIndex),
                          child: ListTile(
                            title: Text(exercise.name),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (exercise.weight.isNotEmpty)
                                  Text('Ciężar: ${exercise.weight}'),
                                if (exercise.repetitions.isNotEmpty)
                                  Text('Powtórzenia: ${exercise.repetitions}'),
                                if (exercise.sets.isNotEmpty)
                                  Text('Serii: ${exercise.sets}'),
                              ],
                            ),
                          ),
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
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addWorkout,
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Workout {
  String id;
  String name;
  DateTime date;
  String dateString;
  List<Exercise> exercises;

  Workout({
    required this.id,
    required this.name,
    required this.date,
    required this.dateString,
    required this.exercises,
  });
}

class Exercise {
  String name;
  String weight;
  String repetitions;
  String sets;

  Exercise({
    required this.name,
    required this.weight,
    required this.repetitions,
    required this.sets,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'weight': weight,
      'repetitions': repetitions,
      'sets': sets,
    };
  }
}
