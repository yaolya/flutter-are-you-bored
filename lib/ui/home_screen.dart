import 'package:are_you_bored/data/models/activity.dart';
import 'package:are_you_bored/ui/custom_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'dart:math' as math;

import '../business_logic/activity/activity_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  ActivityCubit get _cubit => context.read<ActivityCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActivityCubit, ActivityState>(
      builder: _buildCurrentState,
      listener: _onStateChanged,
    );
  }

  void _onStateChanged(context, state) {
    if (state is ActivitySaveFailure) {
      showAlertDialog(context);
    }
  }

  Widget _buildCurrentState(
    BuildContext context,
    ActivityState state,
  ) {
    if (state is ActivityInitial) {
      return _buildInitial();
    } else if (state is ActivityLoadingFailure) {
      return _buildErrorWidget();
    }
    return _buildContent(
      state,
      state.activity,
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: CustomErrorWidget(
        title: "Oops!",
        text: "It looks like something\nwent wrong",
        onReload: () => _cubit.getNextButtonTapped(),
      ),
    );
  }

  Widget _buildInitial() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: Color.fromARGB(59, 255, 215, 106),
                border: _buildBorder(),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildIcon(),
                    _buildActivityText("Tap a button to get an activity"),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.rotate(
                angle: 3 * math.pi / 2,
                child: Lottie.asset(
                  'assets/animations/arrow.json',
                  repeat: true,
                  width: 32,
                  height: 32,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: _buildButton(
                  text: 'Get an activity',
                  onPressed: () => _cubit.getNextButtonTapped(),
                ),
              ),
              Transform.rotate(
                angle: math.pi / 2,
                child: Lottie.asset(
                  'assets/animations/arrow.json',
                  repeat: true,
                  width: 32,
                  height: 32,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContent(
    ActivityState state,
    Activity? activity,
  ) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(59, 255, 215, 106),
                border: _buildBorder(),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  _buildIcon(),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: _buildBorder(),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: EdgeInsets.fromLTRB(8, 8, 8, 16),
                      child: state is ActivityLoadingSuccess
                          ? Center(
                              child: _buildActivityText(activity?.text ?? ""),
                            )
                          : _buildProgressIndicator(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: _buildButton(
                  text: activity?.isSaved == true ? 'Saved' : 'Save',
                  onPressed: activity?.isSaved == true
                      ? null
                      : () => _cubit.saveButtonTapped(activity),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: _buildButton(
                  text: 'Get next',
                  onPressed: () => _cubit.getNextButtonTapped(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActivityText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.pixelifySans(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: CircularProgressIndicator(
          color: Color(0xFFFFD86A),
        ),
      ),
    );
  }

  BoxBorder _buildBorder() {
    return Border.all(
      color: Color(0xFFFFD86A),
      width: 4,
    );
  }

  Widget _buildButton({
    required String text,
    required void Function()? onPressed,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black87,
        backgroundColor: Color(0xFFFFD86A),
        disabledBackgroundColor: Color.fromARGB(255, 235, 201, 106),
        disabledForegroundColor: Colors.black87,
        minimumSize: Size(140, 40),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.pixelifySans(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  void showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
        _cubit.notifySaveActivityFailureProcessed(_cubit.state.activity);
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Oops"),
      content: Text("Activity wasn't saved"),
      actions: [okButton],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget _buildIcon() {
    return Image(
      image: AssetImage('assets/images/pixel_black.png'),
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
    );
  }
}
