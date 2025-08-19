import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lostnfound/core/theme.dart';
import 'package:lostnfound/presentation/widget/form_field.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Report Item",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Buttons Row
            Row(
              children: [
                // Lost Button
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LostFoundForm(category: "lost"),
                        ),
                      );
                    },
                    child: Container(
                      height: 140,
                      decoration: BoxDecoration(
                        color: AppTheme.containerLost,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Lost",
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.white, // same color theme
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Found Button
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const LostFoundForm(category: "found"),
                        ),
                      );
                    },
                    child: Container(
                      height: 140,
                      decoration: BoxDecoration(
                        color: AppTheme.containerFound,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Found",
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.white, // same color theme
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Note section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1), // soft info background
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.info_outline, color: Colors.blue),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "💡 Before lodging a request:\n"
                      "• If you LOST an item, first search in the Found tab.\n"
                      "• If you FOUND an item, first search in the Lost tab.\n\n"
                      "If not found, then proceed to lodge your request.",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
