import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PortfolioScreen extends StatelessWidget {
  final String name;
  final String role;
  final String about;
  final String address;
  final String phone;
  final String email;
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
    required this.address,
    required this.phone,
    required this.email,
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
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
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
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          role,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "About",
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
              const Divider(thickness: 1, color: Colors.black12),
              const SizedBox(height: 16),
              const Text(
                "Works",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 200,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: works.length,
                  itemBuilder: (context, index) {
                    final work = works[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: SizedBox(
                        height: 200,
                        width: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (work['image'] != null)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  work['image'],
                                  height: 120,
                                  width: double.infinity,
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
                            const SizedBox(height: 4),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Text(
                                  work['description'] ?? '',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Contact info",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                address,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
              Text(
                email,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
              Text(
                phone,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(height: 16),
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
        // Text(
        //   toolName,
        //   style: const TextStyle(fontSize: 12),
        //   textAlign: TextAlign.center,
        // ),
      ],
    );
  }
}
