import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_complete/workout.dart';
import 'package:wakelock/wakelock.dart';

import '../states/workout_states.dart';

class WorkoutCubit extends Cubit<WorkoutState>{
  WorkoutCubit():super(const WorkoutInitial());

  Timer? _timer;

  editWorkout(Workout workout, int index)
     => emit(WorkoutEditing(workout, index, null));

  editExercise(int? exIndex) {
    print('..my exercise index is $exIndex ');
    emit(WorkoutEditing(state.workout, (state as WorkoutEditing).index, exIndex));
  }

  goHome()=> emit(const WorkoutInitial());

  onTick(Timer timer){
    if(state is WorkoutIntProgress){
     WorkoutIntProgress wip = state as WorkoutIntProgress;
     if(wip.elapsed! < wip.workout!.getTotal()){
       emit(WorkoutIntProgress(wip.workout, wip.elapsed! + 1));
       print("...my elapsed time is ${wip.elapsed}");
     }else{
       _timer!.cancel();
       Wakelock.disable();
       emit(const WorkoutInitial());
     }
    }
  }

  startWorkout(Workout workout, [int? index]){
    Wakelock.enable();
    if(index != null){

    }else{
      emit(WorkoutIntProgress(workout, 0));
    }
    _timer = Timer.periodic(const Duration(seconds: 1), onTick);
  }
}