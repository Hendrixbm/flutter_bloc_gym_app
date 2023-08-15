import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_complete/blocs/workout_cubit.dart';
import 'package:flutter_bloc_app_complete/states/workout_states.dart';

import '../workout.dart';

class WorkoutProgress extends StatelessWidget {
  const WorkoutProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Map<String, dynamic> getStats(Workout workout, int workoutElapsed){

      int workoutTotal = workout.getTotal();

      return {
        "workoutTitle": workout.title
      };
    }
    return BlocConsumer<WorkoutCubit, WorkoutState>(
        builder: (context, state){
          return Scaffold(
            appBar: AppBar(
              title: Text(state.workout!.title.toString(),),
              leading: BackButton(
                onPressed: ()=>BlocProvider.of<WorkoutCubit>(context).goHome(),
              ),
            ),
            body: Center(child: Text("${state.elapsed}"),),
          );
        },
        listener: (context, state){

    }
    );
  }
}
