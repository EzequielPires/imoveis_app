import 'package:flutter/material.dart';
import 'package:imoveis_app/models/user.dart';

class CardCollaborator extends StatelessWidget {
  final User collaborator;
  const CardCollaborator({super.key, required this.collaborator});

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      margin: EdgeInsets.zero,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: collaborator.avatar != null
                  ? Image.network(
                      'https://api.imoveis.portalcatalao.com.br/${collaborator.avatar!}',
                      width: 64,
                      height: 64,
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            collaborator.avatar != null
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
                    collaborator.name ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    collaborator.email ?? '',
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  collaborator.cellPhone != null
                      ? Text(
                          collaborator.cellPhone ?? '',
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w400),
                        )
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
