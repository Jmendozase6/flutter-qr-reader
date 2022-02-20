import 'package:flutter/cupertino.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

void launchURL(BuildContext context, ScanModel scan) async {
  final String _url = scan.valor;

  if (scan.tipo == 'http') {
    if (!await launch(_url)) throw 'Could not launch $_url';
  } else {
    Navigator.pushNamed(context, 'mapa', arguments: scan);
  }
}
