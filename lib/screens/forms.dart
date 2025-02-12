import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:ionicons/ionicons.dart';
import 'package:portfolio_app/screens/ai_generator.dart';
import 'package:portfolio_app/screens/constant.dart';
import 'package:portfolio_app/screens/custom_container.dart';
import 'package:portfolio_app/screens/markdown.dart';
import 'package:iconsax/iconsax.dart';

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
  final List<Map<String, dynamic>> _education = [];
  final List<TextEditingController> _titleControllers = [];
  final List<TextEditingController> _descriptionControllers = [];
  final List<TextEditingController> _companyControllers = [];
  final List<TextEditingController> _schoolControllers = [];
  final List<TextEditingController> _programmeControllers = [];

  final List<String> _skills = [
    "Microsft Suite",
    "HTML & CSS",
    "Git",
    "WordPress" ,
    "Adobe photoshop",
    "MySQL",
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
    for (var controller in _schoolControllers) {
      controller.dispose();
    }
    for (var controller in _programmeControllers) {
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

  @override
  void initState() {
    super.initState();
    _addWork();
    _addEducation();
  }

  void _addEducation() {
    setState(() {
      _education.add({
        'school name': '',
        'programme': '',
      });
      _schoolControllers.add(TextEditingController());
      _programmeControllers.add(TextEditingController());
    });
  }

  void _addWork() {
    setState(() {
      _works.add({
        'company name': '',
        'job title': '',
        'job description': '',
      });
      _titleControllers.add(TextEditingController());
      _descriptionControllers.add(TextEditingController());
      _companyControllers.add(TextEditingController());
    });
  }

  void _removeWork(int index) {
    setState(() {
      _works.removeAt(index);
      _education.removeAt(index);
      _titleControllers[index].dispose();
      _descriptionControllers[index].dispose();
      _companyControllers[index].dispose();
      _schoolControllers[index].dispose();
      _programmeControllers[index].dispose();
      _titleControllers.removeAt(index);
      _descriptionControllers.removeAt(index);
      _companyControllers.removeAt(index);
      _schoolControllers.removeAt(index);
      _programmeControllers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Create Portfolio',
            style: TextStyle(color: Colors.black)),
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Colors.white,
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
                                  size: 40, color: Colors.black)
                              : null,
                        ),
                      ),
                    ),
                    Text('Upload profile picture')
                  ],
                ),
                maxHeight,
                Text("Personal Info", style: bigHeader),
                minHeight,
                CustomContainer(
                    child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(children: [
                    _buildTextField(
                      controller: _nameController,
                      label: 'Name',
                    ),
                    minHeight,
                    _buildTextField(
                      controller: _roleController,
                      label: 'Role',
                    ),
                    minHeight,
                    _buildTextField(
                      controller: _aboutController,
                      label: 'About',
                      maxLines: 3,
                    ),
                  ]),
                )),
                maxHeight,
                Text("Working Experience", style: bigHeader),
                minHeight,
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  ..._works.asMap().entries.map((entry) {
                    int index = entry.key;
                    return _buildWorkItem(index);
                  }),
                  minHeight,
                  ElevatedButton(
                    onPressed: _addWork,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Add Work',
                        style: TextStyle(color: Colors.white)),
                  ),
                ]),
                maxHeight,
                Text("Education background", style: bigHeader),
                minHeight,
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  ..._education.asMap().entries.map((entry) {
                    int index = entry.key;
                    return _buildEducationItem(index);
                  }),
                  minHeight,
                  ElevatedButton(
                    onPressed: _addEducation,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Add Education',
                        style: TextStyle(color: Colors.white)),
                  )
                ]),
                maxHeight,
                Text("Contact details", style: bigHeader),
                minHeight,
                CustomContainer(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        _buildTextField(
                          controller: _addressController,
                          label: 'Address',
                        ),
                        minHeight,
                        _buildTextField(
                          controller: _emailController,
                          label: 'Email ',
                        ),
                        minHeight,
                        _buildTextField(
                          controller: _phoneController,
                          label: 'Phone number',
                        ),
                      ],
                    ),
                  ),
                ),
                maxHeight,
                Text("Skiils", style: theme.textTheme.titleLarge),
                minHeight,
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
                      selectedColor: Colors.black,
                      backgroundColor: Color(0xFFF5F5F5),
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
                                  'company name': _companyControllers[entry.key]
                                      .text
                                      .trim(),
                                  'job title':
                                      _titleControllers[entry.key].text.trim(),
                                  'job description':
                                      _descriptionControllers[entry.key]
                                          .text
                                          .trim(),
                                })
                            .toList(),
                        'education': _education
                            .asMap()
                            .entries
                            .map((entry) => {
                                  'school name':
                                      _schoolControllers[entry.key].text.trim(),
                                  'programme': _programmeControllers[entry.key]
                                      .text
                                      .trim(),
                                })
                            .toList(),
                        'profileImage': _profileImage,
                      };

                      try {
                      
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        );

                       
                        String organizedText = await callGeminiAI(formData);

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
                    backgroundColor: Colors.black,
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
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: UnderlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.white,
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
    return CustomContainer(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            _buildTextField(
                controller: _companyControllers[index], label: 'Company Name'),
            minHeight,
            _buildTextField(
              controller: _titleControllers[index],
              label: 'Job Title',
            ),
            minHeight,
            _buildTextField(
              controller: _descriptionControllers[index],
              label: 'Job Description',
              maxLines: 2,
            ),
            minHeight,
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () => _removeWork(index),
                icon: const Icon(Iconsax.trash, color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEducationItem(int index) {
    return CustomContainer(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            _buildTextField(
              controller: _schoolControllers[index],
              label: 'Name of school',
            ),
            minHeight,
            _buildTextField(
              controller: _programmeControllers[index],
              label: 'Programme of study',
            ),
            minHeight,
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () => _removeWork(index),
                icon: Icon(Iconsax.trash, color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
