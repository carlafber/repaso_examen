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
            brightness: providerAjustes.modoOscuroG ? Brightness.dark : Brightness.light,
            textTheme: TextTheme(
              displayLarge: TextStyle(fontSize: providerAjustes.tamanoTextoG),
              displayMedium: TextStyle(fontSize: providerAjustes.tamanoTextoG),
              displaySmall: TextStyle(fontSize: providerAjustes.tamanoTextoG),
              headlineMedium: TextStyle(fontSize: providerAjustes.tamanoTextoG),
              headlineSmall: TextStyle(fontSize: providerAjustes.tamanoTextoG),
              titleLarge: TextStyle(fontSize: providerAjustes.tamanoTextoG),
              titleMedium: TextStyle(fontSize: providerAjustes.tamanoTextoG),
              titleSmall: TextStyle(fontSize: providerAjustes.tamanoTextoG),
              bodyLarge: TextStyle(fontSize: providerAjustes.tamanoTextoG),
              bodyMedium: TextStyle(fontSize: providerAjustes.tamanoTextoG),
              bodySmall: TextStyle(fontSize: providerAjustes.tamanoTextoG),
              labelLarge: TextStyle(fontSize: providerAjustes.tamanoTextoG),
              labelSmall: TextStyle(fontSize: providerAjustes.tamanoTextoG),
            ),
          ),
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: providerAjustes.idiomaG,
          supportedLocales: const [
            Locale('en'),
            Locale('es'),
          ],
        );
      },
    );
  }
}
