import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:ionicons/ionicons.dart';
import 'package:portfolio_app/screens/ai_generator.dart';
import 'package:portfolio_app/screens/markdown.dart';

class FormsScreen extends StatefulWidget {
  const FormsScreen({super.key});

  @override
  FormsScreenState createState() => FormsScreenState();
}

class FormsScreenState extends State<FormsScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  File? _profileImage;
  final List<Map<String, dynamic>> _works = [];
  final List<TextEditingController> _titleControllers = [];
  final List<TextEditingController> _descriptionControllers = [];
  final List<TextEditingController> _companyControllers = [];

  final List<String> _skills = [
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

  @override
  void dispose() {
    _phoneController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _roleController.dispose();
    _aboutController.dispose();
    for (var controller in _titleControllers) {
      controller.dispose();
    }
    for (var controller in _descriptionControllers) {
      controller.dispose();
    }
    for (var controller in _companyControllers) {
       controller.dispose();
    }
    super.dispose();
  }

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
      _works.add({
        'company name':'',
        'job title':'',
        'job description':'',
      });
      _titleControllers.add(TextEditingController());
      _descriptionControllers.add(TextEditingController());
      _companyControllers.add(TextEditingController());
    });
  }

  void _removeWork(int index) {
    setState(() {
      _works.removeAt(index);
      _titleControllers[index].dispose();
      _descriptionControllers[index].dispose();
      _titleControllers.removeAt(index);
      _descriptionControllers.removeAt(index);
      _companyControllers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Create Portfolio',
            style: TextStyle(color: Colors.white)),
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
                Column(
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: CircleAvatar(
                          backgroundColor: const Color(0xFFF5F5F5),
                          radius: 60,
                          backgroundImage: _profileImage != null
                              ? FileImage(_profileImage!)
                              : null,
                          child: _profileImage == null
                              ? Icon(Ionicons.camera_outline,
                                  size: 40, color: theme.primaryColor)
                              : null,
                        ),
                      ),
                    ),
                    Text('Upload profile picture')
                  ],
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
                Text("Working Experience", style: theme.textTheme.titleLarge),
                const SizedBox(height: 12),
                // ..._works.asMap().entries.map((entry) {
                //   int index = entry.key;
                //   return _buildWorkItem(index);
                // }),
                const SizedBox(height: 12),
             
                ..._works.asMap().entries.map((entry) {
                  int index = entry.key;
                  return _buildWorkItem(index);
                }),
                   ElevatedButton(
                  onPressed: _addWork,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Add Work',
                      style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 24),
                Text("Contact details", style: theme.textTheme.titleLarge),
                const SizedBox(height: 12),
                _buildTextField(
                  controller: _addressController,
                  label: 'Address',
                  hintText: 'Enter address',
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _emailController,
                  label: 'Email ',
                  hintText: 'Enter email',
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _phoneController,
                  label: 'Phone number',
                  hintText: 'Enter phone number',
                ),
                const SizedBox(height: 24),
                Text("Skiils", style: theme.textTheme.titleLarge),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: _skills.map((tool) {
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
                      backgroundColor: Colors.grey[200],
                    );
                  }).toList(),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final formData = {
                        'name': _nameController.text.trim(),
                        'role': _roleController.text.trim(),
                        'about': _aboutController.text.trim(),
                        'address': _addressController.text.trim(),
                        'email': _emailController.text.trim(),
                        'phone': _phoneController.text.trim(),
                        'languages': _selectedTools ?? [],
                        'works': _works
                            .asMap()
                            .entries
                            .map((entry) => {
                                  // 'image': entry.value['image'],
                                  'title':
                                      _titleControllers[entry.key].text.trim(),
                                  'description':
                                      _descriptionControllers[entry.key]
                                          .text
                                          .trim(),
                                })
                            .toList(),
                        'profileImage': _profileImage,
                      };

                      try {
                        // Show loading indicator
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        );

                        // Fetch AI response
                        String organizedText = await callGeminiAI(formData);

                        // Close loading indicator
                        if (context.mounted) Navigator.pop(context);

                        // Navigate to Markdown Preview Screen
                        if (context.mounted) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MarkdownPreviewScreen(
                                  markdownText: organizedText),
                            ),
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          Navigator.pop(
                              context); // Ensure loading is closed before error
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: $e')),
                          );
                        }
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                    backgroundColor: theme.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Create Portfolio',
                    style: TextStyle(color: Colors.white),
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
        fillColor: const Color(0xFFF5F5F5),
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

  Widget _buildWorkItem(int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

              _buildTextField(
              controller: _companyControllers[index],
              label: 'Company Name',
              hintText: 'Enter company name',
            ),

            _buildTextField(
              controller: _titleControllers[index],
              label: 'Job Title',
              hintText: 'Enter work title',
            ),
            const SizedBox(height: 12),
            _buildTextField(
              controller: _descriptionControllers[index],
              label: 'Job Description',
              hintText: 'Enter work description',
              maxLines: 2,
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () => _removeWork(index),
                icon: const Icon(Icons.delete, color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
