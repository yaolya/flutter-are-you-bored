import 'package:are_you_bored/business_logic/activities_list/activities_list_cubit.dart';
import 'package:are_you_bored/data/models/activity.dart';
import 'package:are_you_bored/ui/custom_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SavedActivitiesScreen extends StatefulWidget {
  const SavedActivitiesScreen({super.key});

  @override
  State<SavedActivitiesScreen> createState() => SavedActivitiesScreenState();
}

class SavedActivitiesScreenState extends State<SavedActivitiesScreen> {
  ActivitiesListCubit get _cubit => context.read<ActivitiesListCubit>();

  @override
  void initState() {
    super.initState();
    _cubit.getActivities();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActivitiesListCubit, ActivitiesListState>(
      builder: _buildCurrentState,
      listener: _onStateChanged,
    );
  }

  void _onStateChanged(context, state) {
    if (state is ActivitiesListDeleteFailure) {
      showAlertDialog(context);
    }
  }

  void showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
        _cubit.notifyDeleteActivityFailureProcessed();
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Oops"),
      content: Text("Activity wasn't deleted"),
      actions: [okButton],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget _buildCurrentState(
    BuildContext context,
    ActivitiesListState state,
  ) {
    if (state is ActivitiesListInitial ||
        state is ActivitiesListLoadingInProgress) {
      return _buildLoading();
    } else if (state is ActivitiesListLoadingFailure) {
      return _buildErrorWidget();
    }
    return _buildContent(state.activities ?? []);
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(
        color: Color(0xFFFFD86A),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: CustomErrorWidget(
        title: "Oops!",
        text: "It looks like something went wrong.",
        onReload: () => _cubit.getActivities(),
      ),
    );
  }

  Widget _buildContent(List<Activity> activities) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: activities.isEmpty
            ? _buildEmptyListWidget()
            : _buildList(activities),
      ),
    );
  }

  Widget _buildList(List<Activity> activities) {
    return ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: activities.length,
      itemBuilder: (context, index) {
        return _buildActivity(activities[index], context);
      },
    );
  }

  Widget _buildActivity(Activity activity, context) {
    return InkWell(
      child: Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.white,
        ),
        onDismissed: (_) => _cubit.deleteActivity(activity),
        child: _buildActivityTile(activity, context),
      ),
    );
  }

  Widget _buildActivityTile(Activity activity, context) {
    return Card(
      elevation: 8.0,
      color: Color.fromARGB(59, 255, 215, 106),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Color(0xFFFFD86A),
          width: 4,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      shadowColor: Colors.transparent,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        title: Text(
          activity.text,
          style: GoogleFonts.pixelifySans(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyListWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('assets/images/pixel_yellow.png'),
            width: 100,
            height: 100,
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
              if (wasSynchronouslyLoaded) {
                return child;
              }
              return AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: frame == null ? 0 : 1,
                child: child,
              );
            },
          ),
          SizedBox(height: 10),
          Text(
            "No activities yet",
            textAlign: TextAlign.center,
            style: GoogleFonts.pixelifySans(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "Looks like you haven't saved any activities yet! Save some on the first page, and you'll find them here.",
              textAlign: TextAlign.center,
              style: GoogleFonts.pixelifySans(
                fontSize: 24,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
