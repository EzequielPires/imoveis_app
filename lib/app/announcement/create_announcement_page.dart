import 'package:flutter/material.dart';
import 'package:imoveis_app/app/announcement/components/address_section.dart';
import 'package:imoveis_app/app/announcement/components/description_section.dart';
import 'package:imoveis_app/app/announcement/components/details_section.dart';
import 'package:imoveis_app/app/announcement/success_create_announcement.dart';
import 'package:imoveis_app/factories/announcement_factory.dart';
import 'package:imoveis_app/models/announcement.dart';
import 'package:imoveis_app/models/property_type.dart';
import 'package:imoveis_app/repositories/announcements_repository.dart';
import 'package:imoveis_app/widgets/buttons/button_primary.dart';
import 'package:imoveis_app/widgets/form_components/price_input_field.dart';
import 'package:imoveis_app/widgets/form_components/select_type.dart';

class CreateAnnouncementPage extends StatefulWidget {
  const CreateAnnouncementPage({super.key});

  @override
  State<CreateAnnouncementPage> createState() => _CreateAnnouncementPageState();
}

class _CreateAnnouncementPageState extends State<CreateAnnouncementPage> {
  final AnnouncementFactory _announcementFactory = AnnouncementFactory();
  final AnnouncementsRepository _announcementsRepository =
      AnnouncementsRepository();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  changeType(PropertyType type) {
    setState(() {
      _announcementFactory.type = type;
      _announcementFactory.typeController.text = type.name;
    });
  }

  handleSubmit() async {
    try {
      setState(() {
        isLoading = true;
      });

      var valid = _announcementFactory.isValid();
      if (valid == null) {
        var res = await _announcementsRepository
            .create(_announcementFactory.toJson());
        if (res.success && res.announcement != null) {
          handleSuccess(res.announcement!);
        }
      } else {
        handleError(valid);
      }
    } catch (error) {
      handleError(error.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  handleSuccess(Announcement announcement) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            SuccessCreateAnnouncement(announcement: announcement),
      ),
    );
  }

  handleError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.red),
      ),
      backgroundColor: Colors.red[50],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title: const Text(
          'Cadastrar anúncio',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 4,
                ),
                DropdownMenu(
                  controller: _announcementFactory.adTypeController,
                  expandedInsets: const EdgeInsets.all(0),
                  label: const Text('Finalidade'),
                  inputDecorationTheme: const InputDecorationTheme(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  onSelected: (value) => setState(() {
                    _announcementFactory.adType = value == 1
                        ? PropertyAdType.venda
                        : value == 2
                            ? PropertyAdType.aluguel
                            : PropertyAdType.venda;
                  }),
                  dropdownMenuEntries: const [
                    DropdownMenuEntry(value: 1, label: 'Venda'),
                    DropdownMenuEntry(value: 2, label: 'Aluguel'),
                  ],
                ),
                const SizedBox(
                  height: 24,
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
                PriceInputField(controller: _announcementFactory.price),
                const SizedBox(
                  height: 12,
                ),
                Divider(
                  color: Colors.grey[200],
                ),
                DetailsSection(announcementFactory: _announcementFactory),
                Divider(
                  color: Colors.grey[200],
                ),
                AddressSection(announcementFactory: _announcementFactory),
                Divider(
                  color: Colors.grey[200],
                ),
                DescriptionSection(announcementFactory: _announcementFactory),
                Divider(
                  color: Colors.grey[200],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: ButtonPrimary(
          title: 'Salvar imóvel',
          isLoading: isLoading,
          onPressed: handleSubmit,
        ),
      ),
    );
  }
}
