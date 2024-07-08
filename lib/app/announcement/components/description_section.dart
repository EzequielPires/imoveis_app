import 'package:flutter/material.dart';
import 'package:imoveis_app/factories/announcement_factory.dart';

class DescriptionSection extends StatefulWidget {
  final AnnouncementFactory announcementFactory;
  const DescriptionSection({super.key, required this.announcementFactory});

  @override
  State<DescriptionSection> createState() => _DescriptionSectionState();
}

class _DescriptionSectionState extends State<DescriptionSection> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: const EdgeInsets.only(left: 0, right: 8),
      title: const Text(
        'Descrição do imóvel',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      shape: Border.all(color: Colors.transparent),
      children: [
        const SizedBox(
          height: 16,
        ),
        TextFormField(
          controller: widget.announcementFactory.description,
          maxLines: 3,
          decoration: const InputDecoration(
            alignLabelWithHint: true,
            label: Text('Breve descrição'),
            hintText: 'Insira o complemento do imóvel',
            hintStyle: TextStyle(fontWeight: FontWeight.w300),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        TextFormField(
          controller: widget.announcementFactory.remarks,
          maxLines: 3,
          decoration: const InputDecoration(
            alignLabelWithHint: true,
            label: Text('Observações do imóvel'),
            hintText: 'Insira o complamento do imóvel',
            hintStyle: TextStyle(fontWeight: FontWeight.w300),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: widget.announcementFactory.keyInformation,
                decoration: const InputDecoration(
                  label: Text('Nº da chave'),
                  hintText: 'Insira o nº da chave',
                  hintStyle: TextStyle(fontWeight: FontWeight.w300),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: TextFormField(
                controller: widget.announcementFactory.commission,
                decoration: const InputDecoration(
                  label: Text('Comissão'),
                  hintText: 'Insira o valor da comissão',
                  hintStyle: TextStyle(fontWeight: FontWeight.w300),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: widget.announcementFactory.video,
                decoration: const InputDecoration(
                  label: Text('Código do Youtube'),
                  hintText: 'Insira o código do Youtube',
                  hintStyle: TextStyle(fontWeight: FontWeight.w300),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            SizedBox(
              width: 60,
              height: 60,
              child: IconButton.filled(
                icon: const Icon(Icons.search),
                onPressed: () {},
                style: ButtonStyle(
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
