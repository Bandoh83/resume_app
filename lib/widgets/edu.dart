import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:portfolio_app/widgets/custom_container.dart';

class EducationItem extends StatelessWidget {
  final int index;
  final TextEditingController schoolController;
  final TextEditingController programmeController;
  final Function(int) onRemove;

  const EducationItem({
    super.key,
    required this.index,
    required this.schoolController,
    required this.programmeController,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            _buildTextField(
              controller: schoolController,
              label: 'Name of school',
            ),
            const SizedBox(height: 10),
            _buildTextField(
              controller: programmeController,
              label: 'Programme of study',
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () => onRemove(index),
                icon: const Icon(Iconsax.trash, color: Colors.red),
              ),
            ),
          ],
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
}