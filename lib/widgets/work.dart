import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:portfolio_app/widgets/custom_container.dart';

class WorkItem extends StatelessWidget {
  final int index;
  final TextEditingController companyController;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final Function(int) onRemove;

  const WorkItem({
    super.key,
    required this.index,
    required this.companyController,
    required this.titleController,
    required this.descriptionController,
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
                controller: companyController, label: 'Company Name'),
            const SizedBox(height: 10),
            _buildTextField(
              controller: titleController,
              label: 'Job Title',
            ),
            const SizedBox(height: 10),
            _buildTextField(
              controller: descriptionController,
              label: 'Job Description',
              maxLines: 2,
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