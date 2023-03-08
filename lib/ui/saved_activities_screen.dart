import 'package:first_app/data/models/activity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:first_app/business_logic/cubits/activity_cubit.dart';

class SavedActivitiesScreen extends StatelessWidget {
  const SavedActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _SavedActivitiesScreen();
  }
}

class _SavedActivitiesScreen extends StatefulWidget {
  const _SavedActivitiesScreen({super.key});

  @override
  State<_SavedActivitiesScreen> createState() => _SavedActivitiesScreenState();
}

class _SavedActivitiesScreenState extends State<_SavedActivitiesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Saved Activities')),
      ),
      body: BlocBuilder<ActivityCubit, ActivityState>(
        builder: (context, state) {
          if (!(state is ActivityListLoaded)) {
            return Center(child: CircularProgressIndicator());
          } else {
            return SingleChildScrollView(
              child: Column(
                children: state.activities
                    .map((e) => _activity(e, context))
                    .toList() as List<Widget>,
              ),
            );
          }
        },
      ),
    );
  }
}

Widget _activity(Activity activity, context) {
  return InkWell(
    child: Dismissible(
      key: Key("$activity.id"),
      child: _activityTile(activity, context),
      background: Container(
        color: Colors.indigo,
      ),
    ),
  );
}

Widget _activityTile(Activity activity, context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border(
        bottom: BorderSide(
          color: Colors.grey[200]!,
        ),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(activity.act)],
    ),
  );
}
