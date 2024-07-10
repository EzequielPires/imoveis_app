import 'package:flutter/material.dart';
import 'package:imoveis_app/models/custom_file.dart';
import 'package:imoveis_app/widgets/buttons/button_primary.dart';
import 'package:imoveis_app/widgets/buttons/button_text.dart';

class CardCustomFile extends StatelessWidget {
  final CustomFile customFile;
  final bool? full;
  final Function() onRemove;
  const CardCustomFile(
      {super.key, required this.customFile, this.full, required this.onRemove});

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
                  width: full == true
                      ? double.infinity
                      : (MediaQuery.of(context).size.width - 64) / 3,
                  height: full == true
                      ? 228
                      : (MediaQuery.of(context).size.width - 64) / 3,
                  fit: BoxFit.cover,
                  customFile.toString(),
                ),
        ),
        Positioned(
            top: 4,
            right: 4,
            child: IconButton.filled(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: const Text('Deseja mesmo remover essa imagem?'),
                    actions: [
                      ButtonPrimary(
                        title: 'Confirmar',
                        onPressed: () {
                          onRemove();
                          Navigator.pop(context);
                        },
                      ),
                      ButtonText(
                        title: 'Cancelar',
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.red[50]),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              icon: const Icon(
                Icons.delete_outline,
                color: Colors.red,
              ),
            )),
      ],
    );
  }
}
