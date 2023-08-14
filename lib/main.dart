import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_complete/blocs/workouts_cubit.dart';
import 'package:flutter_bloc_app_complete/screens/edit_workout_screen.dart';
import 'package:flutter_bloc_app_complete/screens/home_page.dart';
import 'package:flutter_bloc_app_complete/states/workout_states.dart';
import 'package:flutter_bloc_app_complete/workout.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'blocs/workout_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
 final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory()
  );
  HydratedBlocOverrides.runZoned(() => runApp(WorkoutTime()),
    storage: storage
  );
}

class WorkoutTime extends StatelessWidget {
  const WorkoutTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Workout',
        theme: ThemeData(
            primaryColor: Colors.blue,
            textTheme: const TextTheme(
              bodyMedium: TextStyle(color: Color.fromARGB(255, 66, 74, 96)),
            )),
        home: MultiBlocProvider(
          providers: [
            BlocProvider<WorkoutsCubit>(create: (BuildContext context) {
              WorkoutsCubit workoutsCubit = WorkoutsCubit();
              if (workoutsCubit.state.isEmpty) {
                print("...loading json since the state is empty");
                workoutsCubit.getWorkouts();
              } else {
                print("...the state is not empty..");
              }
              return workoutsCubit;
            }),
            BlocProvider<WorkoutCubit>(
                create: (BuildContext contex) => WorkoutCubit())

          ],
          child: BlocBuilder<WorkoutCubit, WorkoutState>(
            builder: (context, state) {
              if (state is WorkoutInitial) {
                return HomePage();
              } else if (state is WorkoutEditing) {
                return EditWorkoutScreen();
              }
              return Container();
            },
          ),
        ));
  }
}
