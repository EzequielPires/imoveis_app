import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:imoveis_app/models/address.dart';

class SelectCity extends StatefulWidget {
  final List<City> cities;
  final void Function(City city) onSelected;

  const SelectCity({super.key, required this.onSelected, required this.cities});

  @override
  State<SelectCity> createState() => _SelectCityState();
}

class _SelectCityState extends State<SelectCity> {
  final TextEditingController _filterController = TextEditingController();
  List<City> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.cities;
    _filterController.addListener(_filterList);
  }

  void _filterList() {
    final query = removeDiacritics(_filterController.text.toLowerCase());
    List<City> filtered = widget.cities.where((item) {
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
