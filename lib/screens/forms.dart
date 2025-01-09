import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:ionicons/ionicons.dart';

class FormsScreen extends StatefulWidget {
  const FormsScreen({super.key});

  @override
  _FormsScreenState createState() => _FormsScreenState();
}

class _FormsScreenState extends State<FormsScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();

  File? _profileImage;
  final List<Map<String, dynamic>> _works = [
    {'image': null, 'title': '', 'description': ''}
  ];

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

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  void _addWork() {
    setState(() {
      _works.add({'image': null, 'title': '', 'description': ''});
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Create Portfolio',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: theme.primaryColor,
       elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      backgroundColor: Color(0xFFF5F5F5),
                      radius: 60,
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!)
                          : null,
                      child: _profileImage == null
                          ? Icon(Ionicons.camera_outline, size: 40, color: theme.primaryColor)
                          : null,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                _buildTextField(
                  controller: _nameController,
                  label: 'Name',
                  hintText: 'Enter your full name',
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _roleController,
                  label: 'Role',
                  hintText: 'Enter your professional role',
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _aboutController,
                  label: 'About',
                  hintText: 'Write a brief description about yourself',
                  maxLines: 3,
                ),
                const SizedBox(height: 24),
                Text("Works", style: theme.textTheme.titleLarge),
                const SizedBox(height: 12),
                ..._works.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, dynamic> work = entry.value;
                  return _buildWorkItem(index, work);
                }),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: _addWork,
                  icon: const Icon(Ionicons.add_circle_outline),
                  label: const Text('Add Work'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text("Languages and Tools", style: theme.textTheme.titleLarge),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: _tools.map((tool) {
                    final isSelected = _selectedTools.contains(tool);
                    return ChoiceChip(
                      label: Text(tool),
                      selected: isSelected,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedTools.add(tool);
                          } else {
                            _selectedTools.remove(tool);
                          }
                        });
                      },
                      selectedColor: theme.primaryColor,
                      backgroundColor: Colors.white,
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final formData = {
                        'name': _nameController.text,
                        'role': _roleController.text,
                        'about': _aboutController.text,
                        'languages': _selectedTools,
                        'works': _works,
                        'profileImage': _profileImage,
                      };
                      // Navigate or handle form submission
                    }
                  },
                  child: const Text('Update Portfolio'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hintText,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Color(0xFFF5F5F5),
      ),
      maxLines: maxLines,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  Widget _buildWorkItem(int index, Map<String, dynamic> work) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: work['image'] != null
                    ? Image.file(work['image'], fit: BoxFit.cover)
                    : const Icon(Icons.camera_alt, size: 40),
              ),
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: TextEditingController(text: work['title']),
              label: 'Title',
              hintText: 'Enter work title',
            ),
            const SizedBox(height: 12),
            _buildTextField(
              controller: TextEditingController(text: work['description']),
              label: 'Description',
              hintText: 'Enter work description',
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
