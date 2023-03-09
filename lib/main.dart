import 'package:first_app/business_logic/cubits/activity_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import './ui/home_screen.dart';
import './ui/saved_activities_screen.dart';
import 'data/data_providers/activity_api.dart';
import 'data/repositories/activity_repository.dart';
import './i18n/localizations.i18n.dart';

void main() => runApp(AreYouBoredApplication());

class AreYouBoredApplication extends StatefulWidget {
  AreYouBoredApplication({super.key});
  static const String title = 'Are You Bored?';

  @override
  State<AreYouBoredApplication> createState() => _AreYouBoredApplicationState();
}

class _AreYouBoredApplicationState extends State<AreYouBoredApplication> {
  // Locale _locale = Locale.fromSubtags(languageCode: 'en');
  // void setLocale(Locale value) {
  //   setState(() {
  //     _locale = value;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    ActivityRepository repository = ActivityRepository(api: ActivityAPI());
    return BlocProvider(
      create: (BuildContext context) => ActivityCubit(
          activityRepository: ActivityRepository(api: ActivityAPI())),
      child: GetMaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', "US"),
          const Locale('ru', "RU"),
        ],
        debugShowCheckedModeBanner: false,
        // title: AreYouBoredApplication.title,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // locale: _locale,
        home: I18n(
          // initialLocale: Locale("en", "us"),
          child: MainPage(),
        ),
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
  var appBarTitle = 'Are You Bored?';

  static const List<Widget> _pages = <Widget>[
    HomeScreen(),
    SavedActivitiesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        actions: [
          PopupMenuButton(
              icon: Icon(IconData(0xe366, fontFamily: 'MaterialIcons')),
              itemBuilder: (context) {
                return [
                  PopupMenuItem<int>(
                    value: 0,
                    child: Text("English"),
                  ),
                  PopupMenuItem<int>(
                    value: 1,
                    child: Text("Русский"),
                  ),
                ];
              },
              onSelected: (value) {
                if (value == 0) {
                  Get.updateLocale(Locale("en", "US"));
                } else if (value == 1) {
                  Get.updateLocale(Locale("ru", "RU"));
                }
              }),
        ],
      ),
      body: Center(
        child: _pages.elementAt(_currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            label: 'Home'.i18n,
            icon: const Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Saved activities'.i18n,
            icon: const Icon(Icons.list_alt),
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            if (index == 1) {
              BlocProvider.of<ActivityCubit>(context).getActivities();
            } else {
              BlocProvider.of<ActivityCubit>(context).getCurrentActivity();
            }
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
