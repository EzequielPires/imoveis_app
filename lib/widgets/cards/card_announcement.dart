import 'package:flutter/material.dart';
import 'package:imoveis_app/app/announcement/%5Bannouncement_id%5D_page.dart';
import 'package:imoveis_app/models/announcement.dart';
import 'package:imoveis_app/models/property_type.dart';
import 'package:intl/intl.dart';

class CardAnnouncement extends StatelessWidget {
  final Announcement announcement;
  const CardAnnouncement({super.key, required this.announcement});

  String formatCurrency(int number) {
    final NumberFormat formatter = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: '',
      decimalDigits: 2,
    );
    return formatter.format(number / 100);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AnnouncementViewPage(
                announcement: announcement,
              ),
            )),
        child: SizedBox(
          width: 348,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 228,
                    child: announcement.thumbnail != null
                        ? Image.network(
                            'https://api.imoveis.portalcatalao.com.br/${announcement.thumbnail!}',
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  Positioned(
                    left: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        announcement.adType == 'venda' ? 'Venda' : 'Aluguel',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          propertyTypeData
                              .firstWhere(
                                  (item) => item.enumValue == announcement.type)
                              .name,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Icon(
                          Icons.circle,
                          size: 4,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          '${announcement.address?.city?.name} - ${announcement.address?.state?.shortName}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      announcement.getFullTitle(),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade800),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        announcement.numberRooms > 0
                            ? Row(
                                children: [
                                  const Icon(Icons.bed_outlined),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text('${announcement.numberRooms}'),
                                  const SizedBox(
                                    width: 16,
                                  )
                                ],
                              )
                            : Container(),
                        announcement.numberBathrooms > 0
                            ? Row(
                                children: [
                                  const Icon(Icons.shower_outlined),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text('${announcement.numberBathrooms}'),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                ],
                              )
                            : Container(),
                        announcement.numberGarages > 0
                            ? Row(
                                children: [
                                  const Icon(Icons.directions_car_outlined),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text('${announcement.numberGarages}')
                                ],
                              )
                            : Container(),
                      ],
                    ),
                    Text(
                      'R\$${formatCurrency(int.parse(announcement.value))}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade900,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
