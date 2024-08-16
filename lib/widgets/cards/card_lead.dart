import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:imoveis_app/helpers/mask.dart';
import 'package:imoveis_app/models/lead.dart';
import 'package:imoveis_app/widgets/buttons/button_primary.dart';
import 'package:url_launcher/url_launcher.dart';

class CardLead extends StatelessWidget {
  final Lead lead;
  const CardLead({super.key, required this.lead});

  void _openWhatsApp() async {
    if (lead.phone != null) {
      final url = Uri.parse('https://wa.me/+55${lead.phone}');

      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  void _openCellphone() async {
    if (lead.phone != null) {
      final url = Uri.parse('tel:${lead.phone}');

      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  void _openMail() async {
    if (lead.email != null) {
      final url = Uri(
        scheme: 'mailto',
        path: lead.email,
        queryParameters: {
          'subject': '',
          'body': '',
        },
      );

      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      margin: EdgeInsets.zero,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              lead.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              lead.email,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              lead.phone,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              lead.message,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(
              height: 8,
            ),
            lead.property != null ? const Divider() : Container(),
            const SizedBox(
              height: 8,
            ),
            lead.property != null
                ? Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(16),
                          width: 64,
                          height: 64,
                          color: Colors.grey.shade100,
                          child: lead.property?.thumbnail != null
                              ? Image.network(
                                  lead.property!.thumbnail!
                                          .startsWith('storage')
                                      ? 'https://api.imoveis.portalcatalao.com.br/${lead.property?.thumbnail!}'
                                      : lead.property!.thumbnail!,
                                  fit: BoxFit.cover,
                                  width: 64,
                                  height: 64,
                                )
                              : const Icon(Icons.image),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              lead.property?.getFullTitle(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'R\$${maskPrice(lead.property?.value ?? '')}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Container(),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                lead.phone != null
                    ? SizedBox(
                        width: 56,
                        height: 56,
                        child: IconButton.filled(
                          onPressed: _openWhatsApp,
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStateProperty.all(Colors.green),
                              shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)))),
                          icon: const FaIcon(
                            FontAwesomeIcons.whatsapp,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Container(),
                lead.phone != null
                    ? const SizedBox(
                        width: 8,
                      )
                    : Container(),
                Expanded(
                    child: ButtonPrimary(
                  title: 'Contatar',
                  onPressed: () async {
                    await showModalBottomSheet<void>(
                      backgroundColor: Colors.white,
                      showDragHandle: true,
                      context: context,
                      builder: (context) {
                        return SizedBox(
                          width: double.infinity,
                          height: 150,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 32.0),
                            child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.email_outlined),
                                  title: const Text('E-mail'),
                                  onTap: _openMail,
                                ),
                                ListTile(
                                  leading: const Icon(Icons.phone_outlined),
                                  title: const Text('Ligar'),
                                  onTap: _openCellphone,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
