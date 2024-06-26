import 'package:flutter/material.dart';
import 'package:imoveis_app/factories/announcement_factory.dart';
import 'package:imoveis_app/models/address.dart';
import 'package:imoveis_app/models/property_type.dart';
import 'package:imoveis_app/repositories/address_repository.dart';
import 'package:imoveis_app/services/api_service.dart';
import 'package:imoveis_app/widgets/form_components/select_city.dart';
import 'package:imoveis_app/widgets/form_components/select_district.dart';
import 'package:imoveis_app/widgets/form_components/select_state.dart';
import 'package:imoveis_app/widgets/form_components/select_type.dart';

class CreateAnnouncementPage extends StatefulWidget {
  const CreateAnnouncementPage({super.key});

  @override
  State<CreateAnnouncementPage> createState() => _CreateAnnouncementPageState();
}

class _CreateAnnouncementPageState extends State<CreateAnnouncementPage>
    with TickerProviderStateMixin {
  final ApiService _apiService = ApiService();
  final AddressRepository _addressRepository = AddressRepository();
  late TabController _tabController;
  final AnnouncementFactory _announcementFactory = AnnouncementFactory();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  changeType(PropertyType type) {
    setState(() {
      _announcementFactory.type = type;
      _announcementFactory.typeController.text = type.name;
    });
  }

  changeState(StateAddress state) async {
    List<City> cities = await _addressRepository.findCities(state);

    setState(() {
      _announcementFactory.addressFactory.cities = cities;
      _announcementFactory.addressFactory.districts = [];
      _announcementFactory.addressFactory.stateAddress = state;
      _announcementFactory.addressFactory.stateController.text = state.name;
    });
  }

  changeCity(City city) async {
    List<District> districts = await _addressRepository.findDistricts(city);

    setState(() {
      _announcementFactory.addressFactory.districts = districts;
      _announcementFactory.addressFactory.city = city;
      _announcementFactory.addressFactory.cityController.text = city.name;
    });
  }

  changeDistrict(District district) async {
    setState(() {
      _announcementFactory.addressFactory.district = district;
      _announcementFactory.addressFactory.districtController.text =
          district.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Criar anúncio',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(
                text: 'Comprar',
              ),
              Tab(
                text: 'Alugar',
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 4,
            ),
            TextFormField(
              controller: _announcementFactory.typeController,
              decoration: const InputDecoration(
                label: Text('Tipo de imóvel'),
                hintText: 'Selecione um tipo',
                hintStyle: TextStyle(fontWeight: FontWeight.w300),
                suffixIcon: Icon(Icons.arrow_drop_down),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
              //enabled: !value.isLoading,
              readOnly: true,
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (context) => SelectPropertyType(
                    types: propertyTypeData,
                    onSelected: changeType,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              controller: _announcementFactory.price,
              decoration: const InputDecoration(
                label: Text('Preço do imóvel'),
                hintText: 'Insira o preço do imóvel',
                hintStyle: TextStyle(fontWeight: FontWeight.w300),
                prefix: Text('R\$ '),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Divider(
              color: Colors.grey[200],
            ),
            const SizedBox(
              height: 12,
            ),
            /* Seção de detalhes */
            const Text(
              'Detalhes do imóvel',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 16,
            ),
            CountField(
              count: _announcementFactory.numberRooms,
              title: 'Quantos quartos?',
              onChange: (value) {
                setState(() {
                  _announcementFactory.numberRooms = value;
                });
              },
            ),
            const SizedBox(
              height: 8,
            ),
            CountField(
              count: _announcementFactory.numberSuites,
              title: 'Destes, quantos são suites?',
              onChange: (value) {
                setState(() {
                  _announcementFactory.numberSuites = value;
                });
              },
            ),
            const SizedBox(
              height: 8,
            ),
            CountField(
              count: _announcementFactory.numberBathrooms,
              title: 'Quantos banheiros?',
              onChange: (value) {
                setState(() {
                  _announcementFactory.numberBathrooms = value;
                });
              },
            ),
            const SizedBox(
              height: 8,
            ),
            CountField(
              count: _announcementFactory.numberGarages,
              title: 'E garagens?',
              onChange: (value) {
                setState(() {
                  _announcementFactory.numberGarages = value;
                });
              },
            ),
            const SizedBox(
              height: 12,
            ),
            Divider(
              color: Colors.grey[200],
            ),
            const SizedBox(
              height: 12,
            ),
            /* Seção de endereço */
            const Text(
              'Endereço do imóvel',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: _announcementFactory.addressFactory.stateController,
              decoration: const InputDecoration(
                label: Text('Estado'),
                hintText: 'Escolha um estado',
                hintStyle: TextStyle(fontWeight: FontWeight.w300),
                suffixIcon: Icon(Icons.arrow_drop_down),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
              //enabled: !value.isLoading,
              readOnly: true,
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (context) => SelectState(
                    states: _announcementFactory.addressFactory.states,
                    onSelected: changeState,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              controller: _announcementFactory.addressFactory.cityController,
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
              //enabled: !value.isLoading,
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (context) => SelectCity(
                    cities: _announcementFactory.addressFactory.cities,
                    onSelected: changeCity,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              controller:
                  _announcementFactory.addressFactory.districtController,
              decoration: const InputDecoration(
                label: Text('Bairro'),
                hintText: 'Escolha um bairro',
                hintStyle: TextStyle(fontWeight: FontWeight.w300),
                suffixIcon: Icon(Icons.arrow_drop_down),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
              //enabled: !value.isLoading,
              readOnly: true,
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (context) => SelectDistrict(
                    districts: _announcementFactory.addressFactory.districts,
                    onSelected: changeDistrict,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              controller: _announcementFactory.addressFactory.route,
              decoration: const InputDecoration(
                label: Text('Rua'),
                hintText: 'Insira a rua do imóvel',
                hintStyle: TextStyle(fontWeight: FontWeight.w300),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _announcementFactory.addressFactory.number,
                    decoration: const InputDecoration(
                      label: Text('Número'),
                      hintText: 'Insira a rua do imóvel',
                      hintStyle: TextStyle(fontWeight: FontWeight.w300),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: TextFormField(
                    controller: _announcementFactory.addressFactory.zipcode,
                    decoration: const InputDecoration(
                      label: Text('CEP'),
                      hintText: 'Insira o CEP do imóvel',
                      hintStyle: TextStyle(fontWeight: FontWeight.w300),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              controller: _announcementFactory.addressFactory.complement,
              maxLines: 3,
              decoration: const InputDecoration(
                alignLabelWithHint: true,
                label: Text('Complemento'),
                hintText: 'Insira a complamento do imóvel',
                hintStyle: TextStyle(fontWeight: FontWeight.w300),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CountField extends StatefulWidget {
  final int count;
  final String title;
  final Function(int value) onChange;
  const CountField(
      {super.key,
      required this.count,
      required this.title,
      required this.onChange});

  @override
  State<CountField> createState() => _CountFieldState();
}

class _CountFieldState extends State<CountField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.title),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            IconButton.filledTonal(
                onPressed: () {
                  setState(() {
                    widget.onChange(
                        widget.count > 0 ? widget.count - 1 : widget.count);
                  });
                },
                icon: const Icon(
                  Icons.remove,
                  size: 16,
                )),
            const SizedBox(
              width: 8,
            ),
            Text('${widget.count}'),
            const SizedBox(
              width: 8,
            ),
            IconButton.filledTonal(
                onPressed: () {
                  setState(() {
                    widget.onChange(
                        widget.count < 10 ? widget.count + 1 : widget.count);
                  });
                },
                icon: const Icon(
                  Icons.add,
                  size: 16,
                )),
          ],
        )
      ],
    );
  }
}
