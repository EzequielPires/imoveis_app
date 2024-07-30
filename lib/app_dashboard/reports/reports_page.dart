import 'package:flutter/material.dart';
import 'package:imoveis_app/controllers/reports_controller.dart';
import 'package:imoveis_app/widgets/form_components/select_city.dart';
import 'package:imoveis_app/widgets/form_components/select_district.dart';
import 'package:imoveis_app/widgets/form_components/select_state.dart';
import 'package:imoveis_app/widgets/form_components/select_type.dart';
import 'package:provider/provider.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Relatórios',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: Consumer<ReportsController>(
        builder: (context, value, child) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                children: [
                  TextFormField(
                    controller: value.stateController,
                    decoration: const InputDecoration(
                      label: Text('Estado'),
                      hintText: 'Escolha um estado',
                      hintStyle: TextStyle(fontWeight: FontWeight.w300),
                      suffixIcon: Icon(Icons.arrow_drop_down),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                    enabled: !value.isLoading,
                    readOnly: true,
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (context) => SelectState(
                          states: value.states,
                          onSelected: (state) {
                            value.changeState(state);
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    controller: value.cityController,
                    decoration: const InputDecoration(
                      label: Text('Cidade'),
                      hintText: 'Escolha uma cidade',
                      hintStyle: TextStyle(fontWeight: FontWeight.w300),
                      suffixIcon: Icon(Icons.arrow_drop_down),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                    readOnly: true,
                    enabled: !value.isLoading,
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (context) => SelectCity(
                          cities: value.cities,
                          onSelected: (cityData) {
                            value.changeCity(cityData);
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    controller: value.districtController,
                    decoration: const InputDecoration(
                      label: Text('Bairro'),
                      hintText: 'Escolha um bairro',
                      hintStyle: TextStyle(fontWeight: FontWeight.w300),
                      suffixIcon: Icon(Icons.arrow_drop_down),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                    enabled: !value.isLoading,
                    readOnly: true,
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (context) => SelectDistrict(
                          districts: value.districts,
                          onSelected: (district) {
                            value.changeDistrict(district);
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    controller: value.typeController,
                    decoration: const InputDecoration(
                      label: Text('Tipo de imóvel'),
                      hintText: 'Selecione um tipo',
                      hintStyle: TextStyle(fontWeight: FontWeight.w300),
                      suffixIcon: Icon(Icons.arrow_drop_down),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                    enabled: !value.isLoading,
                    readOnly: true,
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (context) => SelectPropertyType(
                          types: value.types,
                          onSelected: (type) {
                            value.changeType(type);
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
