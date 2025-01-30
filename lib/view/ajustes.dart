import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '/viewmodel/provider_ajustes.dart';
import 'drawer.dart';

/// Pantalla de configuración que permite cambiar el modo oscuro, el idioma y el tamaño del texto.
class Ajustes extends StatelessWidget {
  const Ajustes({super.key});

  @override
  Widget build(BuildContext context) {
    final ajustesProvider = Provider.of<ProviderAjustes>(context);
    final List<String> idiomas = ['es', 'en'];

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.titleSet),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: [
                  /// Card para cambiar el tema oscuro
                  Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      title: Text(AppLocalizations.of(context)!.themeSet),
                      trailing: Switch(
                        value: ajustesProvider.modoOscuroG,
                        onChanged: (valor) {
                          ajustesProvider.cambiarModoOscuro(valor);
                        },
                      ),
                    ),
                  ),
                  
                  /// Card para cambiar el idioma
                  Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      title: Text(AppLocalizations.of(context)!.languageSet),
                      trailing: DropdownButton<String>(
                        value: ajustesProvider.idiomaG.languageCode,
                        items: idiomas.map((String idioma) {
                          return DropdownMenuItem(
                            value: idioma,
                            child: Text(idioma == 'es' ? 'Español' : 'English'),
                          );
                        }).toList(),
                        onChanged: (String? nuevoIdioma) {
                          if (nuevoIdioma != null) {
                            ajustesProvider.cambiarIdioma(nuevoIdioma);
                          } 
                        },
                      ),
                    ),
                  ),

                  /// Card para cambiar el tamaño del texto
                  Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      title: Text(AppLocalizations.of(context)!.textSet),
                      subtitle: Slider(
                        min: 10.0,
                        max: 30.0,
                        divisions: 20,
                        label: ajustesProvider.tamanoTextoG.toStringAsFixed(1),
                        value: ajustesProvider.tamanoTextoG,
                        onChanged: (valor) {
                          ajustesProvider.cambiarTamanoTexto(valor);
                        },
                      ),
                    ),
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
