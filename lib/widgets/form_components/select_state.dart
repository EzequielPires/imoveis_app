import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:imoveis_app/models/address.dart';

class SelectState extends StatefulWidget {
  final List<StateAddress> states;
  final void Function(StateAddress state) onSelected;
  const SelectState(
      {super.key, required this.onSelected, required this.states});

  @override
  State<SelectState> createState() => _SelectStateState();
}

class _SelectStateState extends State<SelectState> {
  final TextEditingController _filterController = TextEditingController();
  List<StateAddress> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.states;
    _filterController.addListener(_filterList);
  }

  void _filterList() {
    final query = removeDiacritics(_filterController.text.toLowerCase());
    List<StateAddress> filtered = widget.states.where((item) {
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
              hintText: 'Busque pelo nome, email ou CPF',
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
