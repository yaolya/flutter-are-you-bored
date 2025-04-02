import 'package:are_you_bored/business_logic/activities_list/activities_list_cubit.dart';
import 'package:are_you_bored/data/database/database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import './ui/home_screen.dart';
import './ui/saved_activities_screen.dart';
import 'business_logic/activity/activity_cubit.dart';
import 'data/network/activity_api.dart';
import 'data/repositories/activity_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    RepositoryProvider<ActivityRepository>(
      create: (_) => ActivityRepository(
        api: ActivityAPI(),
        dbService: DatabaseService.instance,
      ),
      child: const AreYouBoredApplication(),
    ),
  );
}

class AreYouBoredApplication extends StatefulWidget {
  const AreYouBoredApplication({super.key});

  @override
  State<AreYouBoredApplication> createState() => _AreYouBoredApplicationState();
}

class _AreYouBoredApplicationState extends State<AreYouBoredApplication> {
  ActivityRepository get _repository => context.read<ActivityRepository>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFFFD86A),
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => ActivityCubit(
              activityRepository: _repository,
            ),
          ),
          BlocProvider<ActivitiesListCubit>(
            create: (context) => ActivitiesListCubit(
              activityRepository: _repository,
            ),
          ),
        ],
        child: const MainPage(),
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

  final List<Widget> _pages = <Widget>[
    HomeScreen(),
    SavedActivitiesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Are You Bored?',
          style: GoogleFonts.pixelifySans(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
      body: _pages.elementAt(_currentIndex),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black87,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        iconSize: 32,
        elevation: 80,
        unselectedLabelStyle: GoogleFonts.pixelifySans(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        selectedLabelStyle: GoogleFonts.pixelifySans(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        items: [
          BottomNavigationBarItem(
            label: 'Explore Activities',
            icon: ImageIcon(
              AssetImage("assets/images/icon_search.png"),
              size: 24,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Saved',
            icon: const Icon(Icons.list_alt_sharp),
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
