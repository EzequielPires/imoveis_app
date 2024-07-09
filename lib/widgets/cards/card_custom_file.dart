import 'package:flutter/material.dart';
import 'package:imoveis_app/models/custom_file.dart';
import 'package:imoveis_app/widgets/buttons/button_primary.dart';
import 'package:imoveis_app/widgets/buttons/button_text.dart';

class CardCustomFile extends StatelessWidget {
  final CustomFile customFile;
  final bool? full;
  const CardCustomFile({super.key, required this.customFile, this.full});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: customFile.file != null
              ? Image.file(
                  customFile.file!,
                  width: full == true
                      ? double.infinity
                      : (MediaQuery.of(context).size.width - 64) / 3,
                  height: full == true
                      ? 228
                      : (MediaQuery.of(context).size.width - 64) / 3,
                  fit: BoxFit.cover,
                )
              : Image.network(
                  width: (MediaQuery.of(context).size.width - 64) / 3,
                  height: (MediaQuery.of(context).size.width - 64) / 3,
                  fit: BoxFit.cover,
                  customFile.toString(),
                ),
        ),
        Positioned(
            top: 4,
            right: 4,
            child: FloatingActionButton.small(
              backgroundColor: Colors.red[50],
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: const Text('Deseja mesmo remover essa imagem?'),
                    actions: [
                      ButtonPrimary(
                        title: 'Confirmar',
                        onPressed: () {},
                      ),
                      ButtonText(
                        title: 'Cancelar',
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                );
              },
              child: const Icon(
                Icons.delete_outline,
                color: Colors.red,
              ),
            )),
      ],
    );
  }
}
