import 'package:flutter/material.dart';
import 'package:imoveis_app/factories/announcement_factory.dart';
import 'package:imoveis_app/models/custom_file.dart';
import 'package:imoveis_app/repositories/announcements_repository.dart';
import 'package:imoveis_app/widgets/cards/card_custom_file.dart';
import 'package:imoveis_app/widgets/multimage_picker.dart';

class GallerySection extends StatefulWidget {
  final String id;
  final AnnouncementFactory announcementFactory;
  const GallerySection(
      {super.key, required this.announcementFactory, required this.id});

  @override
  State<GallerySection> createState() => _GallerySectionState();
}

class _GallerySectionState extends State<GallerySection> {
  final AnnouncementsRepository _repository = AnnouncementsRepository();

  handleRemoveImage(CustomFile file) async {
    if (file.url != null) {
      await _repository.removeImage(
        widget.id,
        file.url!,
      );
    }
    setState(() {
      widget.announcementFactory.files.remove(file);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
          runAlignment: WrapAlignment.start,
          spacing: 8,
          runSpacing: 8,
          children: widget.announcementFactory.files
              .map(
                (element) => CardCustomFile(
                  customFile: element,
                  onRemove: () => handleRemoveImage(element),
                  full: width > 500,
                ),
              )
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
