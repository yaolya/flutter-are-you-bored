import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomErrorWidget extends StatelessWidget {
  final String? title;
  final String text;
  final Function onReload;
  const CustomErrorWidget({
    super.key,
    this.title,
    required this.text,
    required this.onReload,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('assets/images/warning_pixel.jpg'),
            width: 80,
            height: 80,
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
          const SizedBox(height: 10),
          if (title?.isNotEmpty == true) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                title ?? "",
                textAlign: TextAlign.center,
                style: GoogleFonts.pixelifySans(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 4),
          ],
          Text(
            text,
            textAlign: TextAlign.center,
            style: GoogleFonts.pixelifySans(
              fontSize: 18,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black87,
              backgroundColor: Color(0xFFFFD86A),
            ),
            onPressed: () => onReload(),
            child: Text(
              "Reload",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
