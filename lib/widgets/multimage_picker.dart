import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imoveis_app/models/custom_file.dart';
import 'package:imoveis_app/widgets/buttons/button_outlined.dart';

class MultimagePicker extends StatelessWidget {
  final Function(List<CustomFile> file) onImageSelected;
  final ImagePicker picker = ImagePicker();

  MultimagePicker({super.key, required this.onImageSelected});

  @override
  Widget build(BuildContext context) {
    return ButtonOutlined(
        title: 'Adicionar imagem',
        icon: Icons.image_outlined,
        onPressed: () {
          showModalBottomSheet<void>(
            backgroundColor: Colors.white,
            context: context,
            showDragHandle: true,
            builder: (context) {
              return SizedBox(
                width: double.infinity,
                height: 150,
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {
                        getFromCamera();
                        Navigator.pop(context);
                      },
                      leading: const Icon(Icons.camera_alt_outlined),
                      title: const Text(
                        'Tirar foto',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        getFromGallery();
                        Navigator.pop(context);
                      },
                      leading: const Icon(Icons.image_outlined),
                      title: const Text(
                        'Galeria',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }

  Future<void> getFromCamera() async {
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo == null) return;

    onImageSelected([CustomFile(file: File(photo.path))]);
  }

  Future<void> getFromGallery() async {
    final List<XFile> images = await picker.pickMultiImage();
    if (images.isEmpty) return;

    onImageSelected(images.map((e) => CustomFile(file: File(e.path))).toList());
  }
}
