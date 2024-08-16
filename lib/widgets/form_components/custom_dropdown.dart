import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final String? placeholder;
  final Function(int? value) onSelected;
  final List<DropdownMenuEntry<int>> dropdownMenuEntries;

  const CustomDropdown({
    super.key,
    this.label,
    this.placeholder,
    required this.controller,
    required this.onSelected,
    required this.dropdownMenuEntries,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label != null ? Text(label!, style: const TextStyle(fontWeight: FontWeight.w500),) : Container(),
        const SizedBox(
          height: 4,
        ),
        DropdownMenu(
          hintText: placeholder ?? 'Selecione um valor',
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
          controller: controller,
          expandedInsets: const EdgeInsets.all(0),
          onSelected: onSelected,
          dropdownMenuEntries: dropdownMenuEntries,
        ),
      ],
    );
  }
}
