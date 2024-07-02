import 'package:flutter/material.dart';
import 'package:imoveis_app/factories/announcement_factory.dart';

class AdditionalSection extends StatefulWidget {
  final AnnouncementFactory announcementFactory;
  const AdditionalSection({super.key, required this.announcementFactory});

  @override
  State<AdditionalSection> createState() => _AdditionalSectionState();
}

class _AdditionalSectionState extends State<AdditionalSection> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: const EdgeInsets.only(left: 0, right: 8),
      title: const Text(
        'Adicionais',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      shape: Border.all(color: Colors.transparent),
      children: [
        CheckboxListTile(
          value: widget.announcementFactory.isFeatured,
          title: const Text('Imóvel em destaque?'),
          onChanged: (value) {
            setState(() {
              widget.announcementFactory.isFeatured = value ?? false;
            });
          },
        ),
        CheckboxListTile(
          value: widget.announcementFactory.isDeedRegistered,
          title: const Text('Imóvel escriturado?'),
          onChanged: (value) {
            setState(() {
              widget.announcementFactory.isDeedRegistered = value ?? false;
            });
          },
        ),
        CheckboxListTile(
          value: widget.announcementFactory.isRegistered,
          title: const Text('Imóvel averbado?'),
          onChanged: (value) {
            setState(() {
              widget.announcementFactory.isRegistered = value ?? false;
            });
          },
        ),
        CheckboxListTile(
          value: widget.announcementFactory.isFurnished,
          title: const Text('Imóvel mobiliado?'),
          onChanged: (value) {
            setState(() {
              widget.announcementFactory.isFurnished = value ?? false;
            });
          },
        ),
        CheckboxListTile(
          value: widget.announcementFactory.allowPets,
          title: const Text('Permite pets?'),
          onChanged: (value) {
            setState(() {
              widget.announcementFactory.allowPets = value ?? false;
            });
          },
        ),
        CheckboxListTile(
          value: widget.announcementFactory.isRoof,
          title: const Text('É uma cobertura?'),
          onChanged: (value) {
            setState(() {
              widget.announcementFactory.isRoof = value ?? false;
            });
          },
        ),
        CheckboxListTile(
          value: widget.announcementFactory.hasPool,
          title: const Text('Tem piscina?'),
          onChanged: (value) {
            setState(() {
              widget.announcementFactory.hasPool = value ?? false;
            });
          },
        ),
        CheckboxListTile(
          value: widget.announcementFactory.hasSolarEnergy,
          title: const Text('Tem energia solar?'),
          onChanged: (value) {
            setState(() {
              widget.announcementFactory.hasSolarEnergy = value ?? false;
            });
          },
        ),
        CheckboxListTile(
          value: widget.announcementFactory.hasSecuritySystem,
          title: const Text('Tem sistema de segurança?'),
          onChanged: (value) {
            setState(() {
              widget.announcementFactory.hasSecuritySystem = value ?? false;
            });
          },
        ),
        CheckboxListTile(
          value: widget.announcementFactory.hasElectricFence,
          title: const Text('Tem cerca elétrica?'),
          onChanged: (value) {
            setState(() {
              widget.announcementFactory.hasElectricFence = value ?? false;
            });
          },
        ),
        CheckboxListTile(
          value: widget.announcementFactory.hasConcertina,
          title: const Text('Tem concertina?'),
          onChanged: (value) {
            setState(() {
              widget.announcementFactory.hasConcertina = value ?? false;
            });
          },
        ),
        CheckboxListTile(
          value: widget.announcementFactory.hasBarbecue,
          title: const Text('Tem churrasqueira?'),
          onChanged: (value) {
            setState(() {
              widget.announcementFactory.hasBarbecue = value ?? false;
            });
          },
        ),
        CheckboxListTile(
          value: widget.announcementFactory.hasGym,
          title: const Text('Tem academia?'),
          onChanged: (value) {
            setState(() {
              widget.announcementFactory.hasGym = value ?? false;
            });
          },
        ),
        CheckboxListTile(
          value: widget.announcementFactory.hasSoccerField,
          title: const Text('Tem campo?'),
          onChanged: (value) {
            setState(() {
              widget.announcementFactory.hasSoccerField = value ?? false;
            });
          },
        ),
        CheckboxListTile(
          value: widget.announcementFactory.hasCourt,
          title: const Text('Tem quadra?'),
          onChanged: (value) {
            setState(() {
              widget.announcementFactory.hasCourt = value ?? false;
            });
          },
        ),
      ],
    );
  }
}
