import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

var durationFormatter = MaskTextInputFormatter(
  mask: "###",
  filter: {"#": RegExp(r'[0-9]')},
);

var cpfFormatter = MaskTextInputFormatter(
  mask: "###.###.###-##",
  filter: {"#": RegExp(r'[0-9]')},
);

var dateFormatter = MaskTextInputFormatter(
  mask: "##/##/####",
  filter: {"#": RegExp(r'[0-9]')},
);

var phoneFormatter = MaskTextInputFormatter(
  mask: "(##) #####-####",
  filter: {"#": RegExp(r'[0-9]')},
);

String maskPrice(String value) {
  if (value.isEmpty) return "0,00";

  // Parse the string to a number
  double number = double.parse(value) / 100;

  // Format the number as currency
  final NumberFormat currencyFormat = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: '',
    decimalDigits: 2,
  );

  return currencyFormat.format(number);
}
