import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:imoveis_app/models/address.dart';

class SelectDistrict extends StatefulWidget {
  final List<District> districts;
  final void Function(District district) onSelected;

  const SelectDistrict(
      {super.key, required this.districts, required this.onSelected});

  @override
  State<SelectDistrict> createState() => _SelectDistrictState();
}

class _SelectDistrictState extends State<SelectDistrict> {
  final TextEditingController _filterController = TextEditingController();
  List<District> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.districts;
    _filterController.addListener(_filterList);
  }

  void _filterList() {
    final query = removeDiacritics(_filterController.text.toLowerCase());
    List<District> filtered = widget.districts.where((item) {
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
