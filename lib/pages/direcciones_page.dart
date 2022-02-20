import 'package:flutter/material.dart';
import 'package:qr_reader/widgets/scan_tiles.dart';

// ignore: use_key_in_widget_constructors
class DireccionesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const ScanTiles(tipo: 'http');
  }
}
