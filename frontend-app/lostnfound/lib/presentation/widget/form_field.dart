import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lostnfound/core/inputDecoration.dart';
import 'package:lostnfound/core/theme.dart';

class LostFoundForm extends StatefulWidget {
  final String category; // "lost" or "found"
  const LostFoundForm({super.key, required this.category});

  @override
  State<LostFoundForm> createState() => _LostFoundFormState();
}

class _LostFoundFormState extends State<LostFoundForm> {
  final TextEditingController _psController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();
  bool _handedToAdmin = false;
  String _status = "Pending";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.category[0].toUpperCase()}${widget.category.substring(1)} Form",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: widget.category == "lost"
            ? AppTheme.containerLost
            : AppTheme.containerFound,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _psController,
              decoration: AppInputDecoration.rounded(
                  hintText: "PS Number (Founder Name)"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _placeController,
              decoration: AppInputDecoration.rounded(hintText: "Place"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _dateTimeController,
              decoration: AppInputDecoration.rounded(
                  hintText: "Date & Time (YYYY-MM-DD HH:MM)"),
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    setState(() {
                      _dateTimeController.text =
                          "${pickedDate.toLocal()} ${pickedTime.format(context)}";
                    });
                  }
                }
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: AppInputDecoration.rounded(hintText: "Description"),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _tagsController,
              decoration: AppInputDecoration.rounded(
                  hintText: "Tags (comma separated, e.g. Dell laptop bag)"),
            ),
            const SizedBox(height: 16),

            // Image Picker Button
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Implement image picker
              },
              icon: const Icon(Icons.image),
              label: const Text("Upload Image"),
            ),
            const SizedBox(height: 16),

            // Handed to Admin
            Row(
              children: [
                Switch(
                  value: _handedToAdmin,
                  onChanged: (val) {
                    setState(() {
                      _handedToAdmin = val;
                    });
                  },
                ),
                const SizedBox(width: 8),
                const Text("Handed to Admin"),
              ],
            ),
            const SizedBox(height: 16),

            // Status Dropdown
            DropdownButtonFormField<String>(
              value: _status,
              decoration: AppInputDecoration.rounded(hintText: "Status"),
              items: ["Pending", "Resolved", "Closed"]
                  .map((status) => DropdownMenuItem(
                        value: status,
                        child: Text(status),
                      ))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  _status = val!;
                });
              },
            ),
            const SizedBox(height: 20),

            // Submit Button
            GestureDetector(
              onTap: () {
                // TODO: Handle form submission (backend integration)
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: widget.category == "lost"
                      ? AppTheme.containerLost
                      : AppTheme.containerFound,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Submit",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
