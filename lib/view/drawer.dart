import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(AppLocalizations.of(context)!.headerDrawer, style: TextStyle(color: Colors.white),),
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.swap_horiz),
                Padding(padding: EdgeInsets.all(10)),
                Text(AppLocalizations.of(context)!.titleCon)
              ],
            ),
            onTap: () {
              ///navegar a la pantalla 'conversor' remplazando la pantalla
              Navigator.pushReplacementNamed(context, '/conversor');
            },
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.list),
                Padding(padding: EdgeInsets.all(10)),
                Text(AppLocalizations.of(context)!.titleTrans)
              ],
            ),
            onTap: () {
              ///navegar a la pantalla 'transacciones' remplazando la pantalla
              Navigator.pushReplacementNamed(context, '/transacciones');
            },
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.settings),
                Padding(padding: EdgeInsets.all(10)),
                Text(AppLocalizations.of(context)!.titleSet)
              ],
            ),
            onTap: () {
              ///navegar a la pantalla 'ajustes' remplazando la pantalla
              Navigator.pushReplacementNamed(context, '/ajustes');
            },
          ),
        ],
      ),
    );
  }
}