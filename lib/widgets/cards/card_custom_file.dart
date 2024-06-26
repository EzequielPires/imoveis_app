import 'package:flutter/material.dart';
import 'package:imoveis_app/models/custom_file.dart';

class CardCustomFile extends StatelessWidget {
  final CustomFile customFile;
  const CardCustomFile({super.key, required this.customFile});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: customFile.file != null
          ? Image.file(
              customFile.file!,
              width: (MediaQuery.of(context).size.width - 56) / 3,
              height: (MediaQuery.of(context).size.width - 56) / 3,
              fit: BoxFit.cover,
            )
          : Image.network(
              customFile.toString(),
            ),
    );
  }
}
