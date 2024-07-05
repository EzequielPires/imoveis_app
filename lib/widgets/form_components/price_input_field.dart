import 'package:flutter/material.dart';
import 'package:imoveis_app/helpers/mask.dart';
import 'package:intl/intl.dart';

class PriceInputField extends StatefulWidget {
  final TextEditingController controller;

  const PriceInputField({super.key, required this.controller});

  @override
  State<PriceInputField> createState() => _PriceInputFieldState();
}

class _PriceInputFieldState extends State<PriceInputField> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_formatCurrency);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_formatCurrency);
    widget.controller.dispose();
    super.dispose();
  }

  void _formatCurrency() {
    String value = widget.controller.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (value.isNotEmpty) {
      double number = double.parse(value) / 100;
      final NumberFormat currencyFormat = NumberFormat.currency(
        locale: 'pt_BR',
        symbol: '',
        decimalDigits: 2,
      );
      widget.controller.value = widget.controller.value.copyWith(
        text: currencyFormat.format(number),
        selection: TextSelection.fromPosition(
          TextPosition(offset: currencyFormat.format(number).length),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        label: Text('Preço do imóvel'),
        hintText: 'Insira o preço do imóvel',
        hintStyle: TextStyle(fontWeight: FontWeight.w300),
        prefix: Text(
          'R\$ ',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.indigo),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    );
  }
}
