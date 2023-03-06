import 'package:first_app/business_logic/cubits/activity_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './ui/home_screen.dart';
import './ui/saved_activities_screen.dart';
import 'data/data_providers/activity_api.dart';
import 'data/repositories/activity_repository.dart';

void main() => runApp(AreYouBoredApplication());

class AreYouBoredApplication extends StatelessWidget {
  static const String title = 'Are You Bored?';

  AreYouBoredApplication({super.key});

  @override
  Widget build(BuildContext context) {
    ActivityRepository repository = ActivityRepository(api: ActivityAPI());
    return BlocProvider(
      create: (BuildContext context) => ActivityCubit(
          activityRepository: ActivityRepository(api: ActivityAPI())),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomeScreen(),
    SavedActivitiesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Saved activities',
            icon: Icon(Icons.list_alt),
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            if (index == 1) {
              BlocProvider.of<ActivityCubit>(context).getActivities();
            } else {
              BlocProvider.of<ActivityCubit>(context).getNextButtonTapped();
            }
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
