import 'package:flutter/material.dart';
import 'package:imoveis_app/factories/announcement_factory.dart';
import 'package:imoveis_app/widgets/form_components/count_field.dart';

class DetailsSection extends StatefulWidget {
  final AnnouncementFactory announcementFactory;
  const DetailsSection({super.key, required this.announcementFactory});

  @override
  State<DetailsSection> createState() => _DetailsSectionState();
}

class _DetailsSectionState extends State<DetailsSection> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: const EdgeInsets.only(left: 0, right: 8),
      title: const Text(
        'Detalhes do imóvel',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      shape: Border.all(color: Colors.transparent),
      children: [
        CountField(
          count: widget.announcementFactory.numberRooms,
          title: 'Quantos quartos?',
          onChange: (value) {
            setState(() {
              widget.announcementFactory.numberRooms = value;
            });
          },
        ),
        const SizedBox(
          height: 8,
        ),
        CountField(
          count: widget.announcementFactory.numberSuites,
          title: 'Destes, quantos são suites?',
          onChange: (value) {
            setState(() {
              widget.announcementFactory.numberSuites = value;
            });
          },
        ),
        const SizedBox(
          height: 8,
        ),
        CountField(
          count: widget.announcementFactory.numberBathrooms,
          title: 'Quantos banheiros?',
          onChange: (value) {
            setState(() {
              widget.announcementFactory.numberBathrooms = value;
            });
          },
        ),
        const SizedBox(
          height: 8,
        ),
        CountField(
          count: widget.announcementFactory.numberGarages,
          title: 'E garagens?',
          onChange: (value) {
            setState(() {
              widget.announcementFactory.numberGarages = value;
            });
          },
        ),
      ],
    );
  }
}
