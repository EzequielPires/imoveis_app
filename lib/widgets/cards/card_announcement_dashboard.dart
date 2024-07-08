import 'package:flutter/material.dart';
import 'package:imoveis_app/app/announcement/update_announcement_page.dart';
import 'package:imoveis_app/models/announcement.dart';
import 'package:imoveis_app/models/property_type.dart';
import 'package:intl/intl.dart';

class CardAnnouncementDashboard extends StatelessWidget {
  final Announcement announcement;
  const CardAnnouncementDashboard({super.key, required this.announcement});

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
    return Card.filled(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UpdateAnnouncementPage(
                announcement: announcement,
              ),
            )),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.all(16),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16),
                    width: 100,
                    height: 100,
                    color: Colors.grey.shade100,
                    child: announcement.thumbnail != null
                        ? Image.network(
                            announcement.thumbnail!.startsWith('storage')
                                ? 'https://api.imoveis.portalcatalao.com.br/${announcement.thumbnail!}'
                                : announcement.thumbnail!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 228,
                          )
                        : const Icon(Icons.image),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 16,
                    top: 16,
                    bottom: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
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
                      const SizedBox(
                        height: 8,
                      ),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            propertyTypeData
                                .firstWhere((item) =>
                                    item.enumValue == announcement.type)
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
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
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
                          Row(
                            children: [
                              const Icon(Icons.bed_outlined),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(announcement.numberRooms.toString())
                            ],
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.shower_outlined),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(announcement.numberBathrooms.toString())
                            ],
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.directions_car_outlined),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(announcement.numberGarages.toString())
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
