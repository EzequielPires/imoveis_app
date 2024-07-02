import 'package:flutter/material.dart';
import 'package:imoveis_app/models/user.dart';

class RealtorWrapper extends StatelessWidget {
  final User realtor;
  const RealtorWrapper({super.key, required this.realtor});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: realtor.avatar != null
              ? Image.network(
                  'https://api.imoveis.portalcatalao.com.br/${realtor.avatar!}',
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                )
              : null,
        ),
        realtor.avatar != null
            ? const SizedBox(
                width: 16,
              )
            : Container(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                realtor.name ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Text(
                realtor.email ?? '',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              realtor.cellPhone != null ? Text(
                realtor.cellPhone ?? '',
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ) : Container(),
            ],
          ),
        ),
      ],
    );
  }
}
