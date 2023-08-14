import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_complete/exercise.dart';
import 'package:flutter_bloc_app_complete/workout.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class WorkoutsCubit extends HydratedCubit< List<Workout>>{

  WorkoutsCubit():super([]);
  getWorkouts() async {
    final List<Workout> workouts = [];
    final workoutsJson = jsonDecode(await rootBundle.loadString('assets/workouts.json'));
    for(var el in (workoutsJson as Iterable)){
      workouts.add(Workout.fromJson(el));
    }
    emit(workouts);
  }

  saveWorkout(Workout workout, int index){
    Workout newWorkout = Workout (title: workout.title, exercises: []);
    int exIndex = 0;
    int startTime = 0;
    for(var ex in workout.exercises){
      newWorkout.exercises.add(
        Exercise(
            title: ex.title,
            prelude: ex.prelude,
            duration: ex.duration,
            index: ex.index,
            startTime: ex.startTime
        )
      );
      exIndex++;
      startTime += ex.prelude! + ex.duration!;
    }

    state[index] = newWorkout;
    print("...I have ${state.length} states");
    emit([...state]);
  }

  @override
  List<Workout>? fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    List<Workout> workout = [];
    json['workouts'].forEach((el)=>workout.add(Workout.fromJson(el)));
    return workout;
  }

  @override
  Map<String, dynamic>? toJson(List<Workout> state) {
    // TODO: implement toJson
    if(state is List<Workout>){
      var json = {
        'workout':[]
      };

      for(var workout in state){
        json['workout']!.add(workout.toJson());
      }
      return json;
    }else {
      return null;
    }

  }
}