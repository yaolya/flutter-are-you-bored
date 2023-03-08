import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:first_app/business_logic/cubits/activity_cubit.dart';
import '../data/data_providers/activity_api.dart';
import '../data/repositories/activity_repository.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _HomeScreen();
  }
}

class _HomeScreen extends StatefulWidget {
  const _HomeScreen({super.key});

  @override
  State<_HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<_HomeScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Are You Bored?')),
      ),
      body: BlocBuilder<ActivityCubit, ActivityState>(
        builder: (context, state) {
          if (state is ActivityInitial) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<ActivityCubit, ActivityState>(
                    builder: (context, state) {
                      if (state is ActivityInitial) {
                        return Stack(
                          children: <Widget>[
                            Text(
                              state.initState,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 6
                                  ..color = Colors.blue[700]!,
                              ),
                            ),
                            Text(
                              state.initState,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 40,
                                color: Colors.grey[300],
                              ),
                            ),
                          ],
                        );
                      }
                      return Container();
                    },
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(120, 40),
                        ),
                        onPressed: () {
                          BlocProvider.of<ActivityCubit>(context)
                              .getNextButtonTapped();
                        },
                        child: const Text("Get an activity"),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else if (state is ActivityError) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ActivityLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: <Widget>[
                        Text(
                          state.activityDescription.act,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 40,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 6
                              ..color = Colors.blue[700]!,
                          ),
                        ),
                        Text(
                          state.activityDescription.act,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.grey[300],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(120, 40),
                            ),
                            onPressed: () {
                              BlocProvider.of<ActivityCubit>(context)
                                  .saveButtonTapped(state.activityDescription);
                            },
                            child: const Text("Save activity"),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(120, 40),
                            ),
                            onPressed: () {
                              BlocProvider.of<ActivityCubit>(context)
                                  .getNextButtonTapped();
                            },
                            child: const Text("Get next"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
