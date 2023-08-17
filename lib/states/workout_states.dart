import 'package:equatable/equatable.dart';

import '../workout.dart';

abstract class WorkoutState extends Equatable{

  final Workout? workout;
  final int? elapsed;
  const WorkoutState(this.workout, this.elapsed);
}

class WorkoutInitial extends WorkoutState{
  const WorkoutInitial():super(null,0);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class WorkoutIntProgress extends WorkoutState{
  const WorkoutIntProgress(Workout? workout, int? elapsed):
        super(workout, elapsed);

  @override
  // TODO: implement props
  List<Object?> get props => [workout, elapsed];
}

class WorkoutEditing extends WorkoutState{
  final int? exIndex;
  final int index;
  const WorkoutEditing(Workout? workout, this.index, this.exIndex):super(workout, 0);

  @override
  // TODO: implement props
  List<Object?> get props => [workout, index, exIndex];
}

class WorkoutPaused extends WorkoutState{
  const WorkoutPaused(Workout? workout, int? elapsed):super(workout, elapsed);

  @override
  // TODO: implement props
  List<Object?> get props =>[workout, elapsed];
}

