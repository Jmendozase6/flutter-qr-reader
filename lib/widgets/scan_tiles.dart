import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/utils/utils.dart';

class ScanTiles extends StatelessWidget {
  final String tipo;

  // ignore: use_key_in_widget_constructors
  const ScanTiles({required this.tipo});

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    if (scans.isEmpty) {
      return EmptyPage();
    } else {
      return ListView.builder(
          itemCount: scans.length,
          itemBuilder: (_, i) => Dismissible(
                key: UniqueKey(),
                background: Container(
                  color: Colors.red,
                ),
                onDismissed: (DismissDirection direction) {
                  Provider.of<ScanListProvider>(context, listen: false)
                      .borrarScanPorId(scans[i].id!);
                },
                child: ListTile(
                  leading: Icon(
                      tipo == 'http' ? Icons.home_outlined : Icons.map_outlined,
                      color: Theme.of(context).primaryColor),
                  title: Text(scans[i].valor),
                  subtitle: Text(scans[i].id.toString()),
                  trailing: const Icon(Icons.keyboard_arrow_right,
                      color: Colors.grey),
                  onTap: () => launchURL(context, scans[i]),
                ),
              ));
    }
  }
}

// ignore: use_key_in_widget_constructors
class EmptyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          FadeInImage(
            fit: BoxFit.cover,
            fadeOutDuration: Duration(seconds: 6),
            placeholder: AssetImage('assets/loading.gif'),
            image: AssetImage('assets/empty.png'),
            height: 200,
          ),
          SizedBox(height: 30),
          Text(
            'Ups! Escanea algo para mostrar',
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 20,
                color: Colors.deepPurpleAccent,
                overflow: TextOverflow.visible),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
