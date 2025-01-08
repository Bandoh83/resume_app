import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PortfolioScreen extends StatelessWidget {
  final String name;
  final String role;
  final String about;
  final List<String> languages;
  final List<Map<String, dynamic>> works;
  final File? profileImage;

  const PortfolioScreen({
    super.key,
    required this.name,
    required this.role,
    required this.about,
    required this.languages,
    required this.works,
    required this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Section
              Container(
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: profileImage != null
                          ? FileImage(profileImage!)
                          : null,
                      child: profileImage == null
                          ? const Icon(Icons.camera_alt, size: 40)
                          : null,
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          role,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // About Section
              const Text(
                "About:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                about,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(height: 16),

              // Divider Section
              const Divider(thickness: 1, color: Colors.black12),
              const SizedBox(height: 16),

              // Works Section
              const Text(
                "Works",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 200, // Set a fixed height for the horizontal list
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: works.length,
                  itemBuilder: (context, index) {
                    final work = works[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (work['image'] != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                work['image'],
                                height: 120,
                                width: 180,
                                fit: BoxFit.cover,
                              ),
                            ),
                          const SizedBox(height: 8),
                          Text(
                            work['title'] ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            work['description'] ?? '',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),

              // Languages and Tools Section
              const Text(
                "Languages and Tools:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: languages.length,
                itemBuilder: (context, index) {
                  return _buildToolIcon(languages[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToolIcon(String toolName) {
    // Map of tool names to their respective icon URLs
    final Map<String, String> toolIcons = {
      "Bootstrap": "https://cdn-icons-png.flaticon.com/512/5968/5968672.png",
      "Chart.js": "https://cdn-icons-png.flaticon.com/512/4701/4701482.png",
      "Docker": "https://cdn-icons-png.flaticon.com/512/919/919853.png",
      "Git": "https://cdn-icons-png.flaticon.com/512/733/733553.png",
      "HTML": "https://cdn-icons-png.flaticon.com/512/732/732212.png",
      "JS": "https://cdn-icons-png.flaticon.com/512/5968/5968292.png",
      "TS": "https://cdn-icons-png.flaticon.com/512/5968/5968381.png",
      "MongoDB": "https://cdn-icons-png.flaticon.com/512/919/919836.png",
      "MySQL": "https://cdn-icons-png.flaticon.com/512/919/919836.png",
      "Python": "https://cdn-icons-png.flaticon.com/512/5968/5968350.png",
    };

    // Fallback in case an icon URL is not found
    final iconUrl =
        toolIcons[toolName] ?? "https://via.placeholder.com/64?text=No+Icon";

    return Column(
      children: [
        Image.network(
          iconUrl,
          width: 50,
          height: 50,
        ),
        const SizedBox(height: 4),
        Text(
          toolName,
          style: const TextStyle(fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
