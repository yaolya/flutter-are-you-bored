import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:first_app/business_logic/cubits/activity_cubit.dart';
import '../data/data_providers/activity_api.dart';
import '../data/repositories/activity_repository.dart';
import '../i18n/localizations.i18n.dart';

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
  var currentActivity = "";

  Widget activityText(String text) {
    return Stack(
      children: <Widget>[
        Text(
          text,
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
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 40,
            color: Colors.grey[300],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        return activityText(state.initState.i18n);
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
                        child: Text("Get an activity".i18n),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else if (state is ActivityError) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ActivityLoaded) {
            currentActivity = state.activityDescription.act;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    activityText(currentActivity),
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
                            child: Text("Save activity".i18n),
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
                            child: Text("Get next".i18n),
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
