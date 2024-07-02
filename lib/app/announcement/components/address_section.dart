import 'package:flutter/material.dart';
import 'package:imoveis_app/factories/announcement_factory.dart';
import 'package:imoveis_app/models/address.dart';
import 'package:imoveis_app/repositories/address_repository.dart';
import 'package:imoveis_app/widgets/form_components/select_city.dart';
import 'package:imoveis_app/widgets/form_components/select_district.dart';
import 'package:imoveis_app/widgets/form_components/select_state.dart';

class AddressSection extends StatefulWidget {
  final AnnouncementFactory announcementFactory;
  const AddressSection({super.key, required this.announcementFactory});

  @override
  State<AddressSection> createState() => _AddressSectionState();
}

class _AddressSectionState extends State<AddressSection> {
  final AddressRepository _addressRepository = AddressRepository();

  changeState(StateAddress state) async {
    List<City> cities = await _addressRepository.findCities(state);

    setState(() {
      widget.announcementFactory.addressFactory.cities = cities;
      widget.announcementFactory.addressFactory.districts = [];
      widget.announcementFactory.addressFactory.stateAddress = state;
      widget.announcementFactory.addressFactory.stateController.text =
          state.name;
    });
  }

  changeCity(City city) async {
    List<District> districts = await _addressRepository.findDistricts(city);

    setState(() {
      widget.announcementFactory.addressFactory.districts = districts;
      widget.announcementFactory.addressFactory.city = city;
      widget.announcementFactory.addressFactory.cityController.text = city.name;
    });
  }

  changeDistrict(District district) async {
    setState(() {
      widget.announcementFactory.addressFactory.district = district;
      widget.announcementFactory.addressFactory.districtController.text =
          district.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: const EdgeInsets.only(left: 0, right: 8),
      title: const Text(
        'Endereço do imóvel',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      shape: Border.all(color: Colors.transparent),
      children: [
        const SizedBox(
          height: 16,
        ),
        TextFormField(
          controller: widget.announcementFactory.addressFactory.stateController,
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
                states: widget.announcementFactory.addressFactory.states,
                onSelected: changeState,
              ),
            );
          },
        ),
        const SizedBox(
          height: 24,
        ),
        TextFormField(
          controller: widget.announcementFactory.addressFactory.cityController,
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
                cities: widget.announcementFactory.addressFactory.cities,
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
              widget.announcementFactory.addressFactory.districtController,
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
                districts: widget.announcementFactory.addressFactory.districts,
                onSelected: changeDistrict,
              ),
            );
          },
        ),
        const SizedBox(
          height: 24,
        ),
        TextFormField(
          controller: widget.announcementFactory.addressFactory.route,
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
                controller: widget.announcementFactory.addressFactory.number,
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
                controller: widget.announcementFactory.addressFactory.zipcode,
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
          controller: widget.announcementFactory.addressFactory.complement,
          maxLines: 3,
          decoration: const InputDecoration(
            alignLabelWithHint: true,
            label: Text('Complemento'),
            hintText: 'Insira o complamento do imóvel',
            hintStyle: TextStyle(fontWeight: FontWeight.w300),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ),
      ],
    );
  }
}
