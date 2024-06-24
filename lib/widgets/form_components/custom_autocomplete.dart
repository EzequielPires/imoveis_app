import 'package:flutter/material.dart';

class OptionProps {
  int id;
  String name;

  OptionProps({required this.id, required this.name});
}

class CustomAutocomplete extends StatefulWidget {
  final String label;
  final String hint;
  final List<OptionProps> options;
  final void Function(OptionProps)? onSelected;
  const CustomAutocomplete({
    super.key,
    required this.label,
    required this.hint,
    required this.options,
    this.onSelected,
  });

  @override
  State<CustomAutocomplete> createState() => _CustomAutocompleteState();
}

class _CustomAutocompleteState extends State<CustomAutocomplete> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 4,
        ),
        Autocomplete<OptionProps>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            return widget.options.where((item) {
              return item.name
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase());
            });
          },
          fieldViewBuilder:
              (context, textEditingController, focusNode, onFieldSubmitted) {
            return TextField(
              controller: textEditingController,
              focusNode: focusNode,
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: const TextStyle(fontWeight: FontWeight.w300),
                filled: true,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.grey.shade100,
              ),
            );
          },
          onSelected: widget.onSelected,
          displayStringForOption: (OptionProps option) => option.name,
          /* optionsViewBuilder: (context, onSelected, options) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width -
                          40), // Add appropriate padding/margin
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: options.length,
                    itemBuilder: (BuildContext context, int index) {
                      final OptionProps option = options.elementAt(index);
                      return GestureDetector(
                        onTap: () {
                          onSelected(option);
                        },
                        child: ListTile(
                          title: Text(option.name),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          }, */
        ),
      ],
    );
  }
}
