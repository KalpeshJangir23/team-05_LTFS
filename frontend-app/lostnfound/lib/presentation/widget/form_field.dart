import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lostnfound/core/inputDecoration.dart';
import 'package:lostnfound/core/theme.dart';
import 'package:lostnfound/model/item_model.dart';
import 'package:lostnfound/provider/item_provider.dart';

class LostFoundForm extends ConsumerStatefulWidget {
  final String category; // "lost" or "found"
  const LostFoundForm({super.key, required this.category});

  @override
  ConsumerState<LostFoundForm> createState() => _LostFoundFormState();
}

class _LostFoundFormState extends ConsumerState<LostFoundForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _psidController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _type = "";
  File? _imageFile;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImageFromCamera() async {
    final picked = await _picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
    }
  }

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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _psidController,
                decoration: AppInputDecoration.rounded(
                  hintText: "Enter PS ID",
                  labelText: "PS ID",
                ),
                validator: (val) =>
                    val == null || val.trim().isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _titleController,
                decoration: AppInputDecoration.rounded(
                  hintText: "Enter Item Name",
                  labelText: "Item Name",
                ),
                validator: (val) =>
                    val == null || val.trim().isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _placeController,
                decoration: AppInputDecoration.rounded(
                  hintText: "Enter Place",
                  labelText: "Place",
                ),
                validator: (val) =>
                    val == null || val.trim().isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _tagsController,
                decoration: AppInputDecoration.rounded(
                  hintText: "Enter Tags (comma separated)",
                  labelText: "Tags",
                ),
                validator: (val) =>
                    val == null || val.trim().isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: AppInputDecoration.rounded(
                  hintText: "Enter Description",
                  labelText: "Description",
                ),
                validator: (val) =>
                    val == null || val.trim().isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _type.isEmpty ? null : _type,
                decoration: AppInputDecoration.rounded(
                  hintText: "Select Type",
                  labelText: "Type",
                ),
                items: ["LOST", "FOUND"]
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    _type = val ?? "";
                  });
                },
                validator: (val) =>
                    val == null || val.isEmpty ? "Please select a type" : null,
              ),
              const SizedBox(height: 16),
              if (_imageFile != null)
                Column(
                  children: [
                    Image.file(_imageFile!, height: 200, fit: BoxFit.cover),
                    const SizedBox(height: 8),
                    TextButton.icon(
                      onPressed: () => setState(() => _imageFile = null),
                      icon: const Icon(Icons.delete, color: Colors.red),
                      label: const Text("Remove Image",
                          style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              ElevatedButton.icon(
                onPressed: _pickImageFromCamera,
                icon: const Icon(Icons.camera_alt),
                label: const Text("Take Photo"),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    if (_imageFile == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please take a photo")),
                      );
                      return;
                    }

                    final item = ItemModel(
                      psid: _psidController.text.trim(),
                      title: _titleController.text.trim(),
                      place: _placeController.text.trim(),
                      tags: _tagsController.text.trim(),
                      description: _descriptionController.text.trim(),
                      image: _imageFile!.path, // store path for upload
                      type: _type,
                      handedToAdmin: false, // required by backend
                    );

                    try {
                      await ref.read(postItemProvider(item).future);
                      _formKey.currentState!.reset();
                      setState(() {
                        _imageFile = null;
                        _type = "";
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Item submitted successfully")),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Failed to submit item: $e")),
                      );
                    }
                  }
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
            ],
          ),
        ),
      ),
    );
  }
}
