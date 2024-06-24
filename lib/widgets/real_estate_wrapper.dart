import 'package:flutter/material.dart';
import 'package:imoveis_app/models/announcement.dart';

class RealEstateWrapper extends StatelessWidget {
  final RealEstate realEstate;
  const RealEstateWrapper({super.key, required this.realEstate});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: realEstate.logo != null
              ? Image.network(
                  'https://api.imoveis.portalcatalao.com.br/${realEstate.logo!}',
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                )
              : null,
        ),
        realEstate.logo != null
            ? const SizedBox(
                width: 16,
              )
            : Container(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                realEstate.name ?? '',
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                realEstate.email ?? '',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              Text(
                realEstate.cellPhone ?? '',
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
