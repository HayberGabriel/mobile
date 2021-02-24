import 'package:flutter/material.dart';
import 'package:lojavirtual/common/custom_icon_button.dart';
import 'package:lojavirtual/models/store.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreCard extends StatelessWidget {
  const StoreCard(this.store);

  final Store store;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Colors.black;

    Color colorForStatus(StoreStatus status) {
      switch (status) {
        case StoreStatus.closed:
          return Colors.red;
        case StoreStatus.open:
          return Colors.green;
        case StoreStatus.closing:
          return Colors.orange;
        default:
          return Colors.green;
      }
    }

    void showError() {
      Scaffold.of(context).showSnackBar(const SnackBar(
        content: Text('Esta função não está disponível neste dispositivo'),
        backgroundColor: Colors.red,
      ));
    }

    Future<void> openPhone() async {
      if (await canLaunch('tel:${store.cleanPhone}')) {
        launch('tel:${store.cleanPhone}');
      } else {
        showError();
      }
    }

    Future<void> openMap() async {
      try {
        final availableMaps = await MapLauncher.installedMaps;

        showModalBottomSheet(
            context: context,
            builder: (_) {
              return SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    for (final map in availableMaps)
                      ListTile(
                        onTap: () {
                          map.showMarker(
                            coords:
                                Coords(store.address.lat, store.address.long),
                            title: store.name,
                            description: store.addressText,
                          );
                          Navigator.of(context).pop();
                        },
                        title: Text(map.mapName),
                        leading: Image(
                          image: map.icon,
                          width: 30,
                          height: 30,
                        ),
                      )
                  ],
                ),
              );
            });
      } catch (e) {
        showError();
      }
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      clipBehavior: Clip.antiAlias,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              store.name,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 22,
              ),
            ),
            Text(
              store.statusText,
              style: TextStyle(
                color: colorForStatus(store.status),
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 8)),
            Text(
              "Horário de Funcionamento",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 4)),
            Text(
              store.openingText,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 4)),
            Column(children: [
              Row(
                children: [
                  Text(
                    "Local:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  CustomIconButton(
                    size: 25,
                    iconData: Icons.map,
                    color: primaryColor,
                    onTap: openMap,
                  ),
                 Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
                  Text(
                    "Contato:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  CustomIconButton(
                    size: 25,
                    iconData: Icons.phone,
                    color: primaryColor,
                    onTap: openMap,
                  ),
                ],
              ),


            ])
          ],
        ),
      ),
    );
  }
}
