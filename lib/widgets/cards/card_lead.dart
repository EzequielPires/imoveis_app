import 'package:flutter/material.dart';
import 'package:imoveis_app/helpers/mask.dart';
import 'package:imoveis_app/models/lead.dart';

class CardLead extends StatelessWidget {
  final Lead lead;
  const CardLead({super.key, required this.lead});

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      margin: EdgeInsets.zero,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              lead.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              lead.email,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              lead.phone,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              lead.message,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(
              height: 8,
            ),
            lead.property != null ? const Divider() : Container(),
            const SizedBox(
              height: 8,
            ),
            lead.property != null
                ? Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(16),
                        width: 64,
                        height: 64,
                        color: Colors.grey.shade100,
                        child: lead.property?.thumbnail != null
                            ? Image.network(
                                lead.property!.thumbnail!.startsWith('storage')
                                    ? 'https://api.imoveis.portalcatalao.com.br/${lead.property?.thumbnail!}'
                                    : lead.property!.thumbnail!,
                                fit: BoxFit.cover,
                                width: 64,
                                height: 64,
                              )
                            : const Icon(Icons.image),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              lead.property?.getFullTitle(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'R\$${maskPrice(lead.property?.value ?? '')}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
