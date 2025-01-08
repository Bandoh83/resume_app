import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:portfolio_app/screens/homescreen.dart';
import 'package:ionicons/ionicons.dart';

class FormsScreen extends StatefulWidget {
  const FormsScreen({super.key});

  @override
  _FormsScreenState createState() => _FormsScreenState();
}

class _FormsScreenState extends State<FormsScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();

  // Profile Image
  File? _profileImage;

  // Works Section
  List<Map<String, dynamic>> _works = [];

  // Languages and Tools
  final List<String> _tools = [
    "Bootstrap",
    "Chart.js",
    "Docker",
    "Git",
    "HTML",
    "JS",
    "TS",
    "MongoDB",
    "MySQL",
    "Python"
  ];
  final List<String> _selectedTools = [];

  // Select Image
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  // Add Work
  void _addWork() {
    setState(() {
      _works.add({'image': null, 'title': '', 'description': ''});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Create Portfolio'),
         centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Section
                Center(
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      backgroundColor: Color(0xFFF5F5F5),
                      radius: 50,
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!)
                          : null,
                      child: _profileImage == null
                          ? Icon(Ionicons.camera_outline, size: 40)
                          : null,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Name Text Field
                TextFormField(
                  controller: _nameController,
                  
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    filled: true,
                    fillColor: Color(0xFFF5F5F5),
                    border: OutlineInputBorder(
                      //borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Role Text Field
                TextFormField(
                  controller: _roleController,
                  decoration: const InputDecoration(
                    labelText: 'Role',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your role';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // About Text Field
                TextFormField(
                  controller: _aboutController,
                  decoration: const InputDecoration(
                    labelText: 'About',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide an "About" description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Works Section
                const Text(
                  "Works",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ..._works.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, dynamic> work = entry.value;
                  return _buildWorkItem(index, work);
                }).toList(),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _addWork,
                  child: const Text('Add Work'),
                ),
                const SizedBox(height: 16),

                // Languages and Tools Section
                const Text(
                  "Languages and Tools",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: _tools.map((tool) {
                    final isSelected = _selectedTools.contains(tool);
                    return ChoiceChip(
                      label: Text(tool),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedTools.add(tool);
                          } else {
                            _selectedTools.remove(tool);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),

                // Submit Button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Collect form data
                      final formData = {
                        'name': _nameController.text,
                        'role': _roleController.text,
                        'about': _aboutController.text,
                        'languages': _selectedTools,
                        'works': _works,
                        'profileImage': _profileImage,
                      };

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PortfolioScreen(
                            name: formData['name']! as String,
                            role: formData['role']! as String,
                            about: formData['about']! as String,
                            languages: formData['languages'] as List<String>,
                            works: formData['works'] as List<Map<String, dynamic>>,
                            profileImage: formData['profileImage'] as File?,
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text('Update Portfolio'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWorkItem(int index, Map<String, dynamic> work) {
    return Column(
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () async {
                final picker = ImagePicker();
                final pickedFile =
                    await picker.pickImage(source: ImageSource.gallery);

                if (pickedFile != null) {
                  setState(() {
                    _works[index]['image'] = File(pickedFile.path);
                  });
                }
              },
              child: Container(
                width: 60,
                height: 60,
                color: Colors.grey.shade300,
                child: work['image'] != null
                    ? Image.file(work['image'], fit: BoxFit.cover)
                    : const Icon(Icons.camera_alt),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                initialValue: work['title'],
                decoration: const InputDecoration(labelText: 'Title'),
                onChanged: (value) {
                  _works[index]['title'] = value;
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: work['description'],
          decoration: const InputDecoration(labelText: 'Description'),
          maxLines: 2,
          onChanged: (value) {
            _works[index]['description'] = value;
          },
        ),
        const Divider(),
      ],
    );
  }
}
