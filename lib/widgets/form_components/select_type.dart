import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:imoveis_app/models/property_type.dart';

class SelectPropertyType extends StatefulWidget {
  final List<PropertyType> types;
  final void Function(PropertyType type) onSelected;

  const SelectPropertyType({super.key, required this.types, required this.onSelected});

  @override
  State<SelectPropertyType> createState() => _SelectPropertyTypeState();
}

class _SelectPropertyTypeState extends State<SelectPropertyType> {
  final TextEditingController _filterController = TextEditingController();
  List<PropertyType> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.types;
    _filterController.addListener(_filterList);
  }

  void _filterList() {
    final query = removeDiacritics(_filterController.text.toLowerCase());
    List<PropertyType> filtered = widget.types.where((item) {
      return removeDiacritics(item.name.toLowerCase()).contains(query);
    }).toList();

    setState(() {
      _filteredItems = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 80,
          title: TextFormField(
            controller: _filterController,
            decoration: InputDecoration(
              hintText: 'Busque pelo nome',
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          actions: [
            SizedBox(
              width: 56,
              height: 56,
              child: IconButton.filled(
                onPressed: () {},
                style: ButtonStyle(
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
          ],
        ),
        body: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemBuilder: (context, index) => ListTile(
            title: Text(_filteredItems[index].name),
            onTap: () {
              widget.onSelected(_filteredItems[index]);
              Navigator.pop(context);
            },
          ),
          itemCount: _filteredItems.length,
          separatorBuilder: (context, index) => const SizedBox(
            height: 16,
          ),
        ),
      ),
    );
  }
}
