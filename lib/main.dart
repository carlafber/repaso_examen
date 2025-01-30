import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repaso_examen/services/bd_helper.dart';
import 'view/conversor.dart';
import 'view/transacciones.dart';
import 'view/ajustes.dart';
import 'viewmodel/provider_ajustes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';


void main() async {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  await DBHelper().abrirBD(); 
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProviderAjustes(),
        )
      ],
      child: const MainApp(),
    )
  );
}

/// Configura la aplicación y gestiona los ajustes globales.
class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  MainAppState createState() => MainAppState();
}

class MainAppState extends State<MainApp> {

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderAjustes>(
      builder: (context, providerAjustes, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/conversor',
          routes:{
            '/conversor': (context) => Conversor(),
            '/transacciones': (context) => Transacciones(),
            '/ajustes': (context) => Ajustes()
          },
          theme: ThemeData(
            brightness: providerAjustes.modoOscuro ? Brightness.dark : Brightness.light,
            textTheme: TextTheme(
              displayLarge: TextStyle(fontSize: providerAjustes.tamanoTexto),
              displayMedium: TextStyle(fontSize: providerAjustes.tamanoTexto),
              displaySmall: TextStyle(fontSize: providerAjustes.tamanoTexto),
              headlineMedium: TextStyle(fontSize: providerAjustes.tamanoTexto),
              headlineSmall: TextStyle(fontSize: providerAjustes.tamanoTexto),
              titleLarge: TextStyle(fontSize: providerAjustes.tamanoTexto),
              titleMedium: TextStyle(fontSize: providerAjustes.tamanoTexto),
              titleSmall: TextStyle(fontSize: providerAjustes.tamanoTexto),
              bodyLarge: TextStyle(fontSize: providerAjustes.tamanoTexto),
              bodyMedium: TextStyle(fontSize: providerAjustes.tamanoTexto),
              bodySmall: TextStyle(fontSize: providerAjustes.tamanoTexto),
              labelLarge: TextStyle(fontSize: providerAjustes.tamanoTexto),
              labelSmall: TextStyle(fontSize: providerAjustes.tamanoTexto),
            ),
          ),
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: providerAjustes.idioma,
          supportedLocales: const [
            Locale('en'),
            Locale('es'),
          ],
        );
      },
    );
  }
}
