import 'package:flutter/material.dart';
import 'package:imoveis_app/factories/announcement_factory.dart';
import 'package:imoveis_app/widgets/cards/card_custom_file.dart';
import 'package:imoveis_app/widgets/multimage_picker.dart';

class GallerySection extends StatefulWidget {
  final AnnouncementFactory announcementFactory;
  const GallerySection({super.key, required this.announcementFactory});

  @override
  State<GallerySection> createState() => _GallerySectionState();
}

class _GallerySectionState extends State<GallerySection> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: const EdgeInsets.only(left: 0, right: 8),
      title: const Text(
        'Galeria do imóvel',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      shape: Border.all(color: Colors.transparent),
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          spacing: 8,
          runSpacing: 8,
          children: widget.announcementFactory.files
              .map((element) => CardCustomFile(customFile: element))
              .toList(),
        ),
        const SizedBox(
          height: 12,
        ),
        MultimagePicker(
          onImageSelected: (file) {
            setState(() {
              widget.announcementFactory.files.addAll(file);
            });
          },
        ),
      ],
    );
  }
}
