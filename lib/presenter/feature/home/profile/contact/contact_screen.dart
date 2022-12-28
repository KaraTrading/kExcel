import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:kexcel/presenter/common/localization.dart';
import 'package:kexcel/presenter/utils/app_colors.dart';
import 'package:kexcel/presenter/utils/text_styles.dart';
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => directionTo(lat, lng),
              child: Text('companyAddress'.translate, style: titleTextStyle.medium),
            ),
            Divider(color: colorTransparent),
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
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                Divider(color: colorTransparent, height: 8,),
                GestureDetector(
                  onTap: () => copyToClipboard('fax'.translate, context: context),
                  onLongPress: () {
                    copyToClipboard('fax'.translate, context: context);
                  },
                  child: AppTextWidget(
                    'fax'.translate,
                    icon: Icon(
                      Icons.fax,
                      size: 18,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            Divider(color: colorTransparent),
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
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),

            SizedBox(
              height: 200,
              child: FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  maxZoom: 18,
                  zoom: 15,
                  enableMultiFingerGestureRace: true,
                  enableScrollWheel: true,
                  onTap: (pos, latLng) => directionTo(lat, lng),
                  center: LatLng(lat, lng),
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'de.karatrading.kexcel',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: LatLng(lat, lng),
                        width: 80,
                        height: 80,
                        builder: (context) => Icon(
                          Icons.location_on,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
