import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:kexcel/presenter/common/localization.dart';
import 'package:kexcel/presenter/utils/uri_launcher.dart';
import 'package:kexcel/presenter/widget/app_text_widget.dart';
import 'package:latlong2/latlong.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  final double lat = 51.24264;
  final double lng = 6.73728;

  @override
  Widget build(BuildContext context) {
    final MapController mapController = MapController();
    return Scaffold(
      appBar: AppBar(title: Text('contact'.translate)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => directionTo(lat, lng),
                  child: Text('companyAddress'.translate,
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
                const Divider(color: Colors.transparent),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => makePhoneCall('number'.translate),
                      onLongPress: () {
                        copyToClipboard('number'.translate, context: context);
                      },
                      child: AppTextWidget(
                        'number'.translate,
                        icon: Icon(
                          Icons.phone,
                          size: 18,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    const Divider(height: 8, color: Colors.transparent),
                    GestureDetector(
                      onTap: () =>
                          copyToClipboard('fax'.translate, context: context),
                      onLongPress: () {
                        copyToClipboard('fax'.translate, context: context);
                      },
                      child: AppTextWidget(
                        'fax'.translate,
                        icon: Icon(
                          Icons.fax,
                          size: 18,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(color: Colors.transparent),
                GestureDetector(
                  onTap: () => mailTo('mail'.translate),
                  onLongPress: () {
                    copyToClipboard('mail'.translate, context: context);
                  },
                  child: AppTextWidget(
                    'mail'.translate,
                    icon: Icon(
                      Icons.mail,
                      size: 18,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 400,
            child: FlutterMap(
              mapController: mapController,
              options: MapOptions(
                maxZoom: 18,
                zoom: 15,
                minZoom: 2.5,
                center: LatLng(lat, lng),
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'de.karatrading.kexcel',
                  tileBuilder: customTileBuilder,
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: LatLng(lat, lng),
                      width: 40,
                      height: 40,
                      builder: (context) => GestureDetector(
                        onTap: () => directionTo(lat, lng),
                        child: Icon(
                          Icons.location_on,
                          size: 40,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget customTileBuilder(BuildContext context,
      Widget tileWidget,
      Tile tile) =>
      ColorFiltered(
        colorFilter: const ColorFilter.matrix(<double>[
          0.2126, 0.7152, 0.0722, 0, 0,
          0.2126, 0.7152, 0.0722, 0, 0,
          0.2126, 0.7152, 0.0722, 0, 0,
          0,      0,      0,      1, 0,
        ]),
        child: tileWidget,
      );
}
