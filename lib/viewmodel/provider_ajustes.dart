import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Gestiona el estado global de la app. Se encarga de manejar el tema, idioma y el tamaño de texto
class ProviderAjustes extends ChangeNotifier{
  bool _modoOscuro = false;
  Locale _idioma = Locale('es');
  double _tamanoTexto = 16.0;

  /// Constructor que carga las preferencias guardadas al iniciar la app.
  ProviderAjustes() {
    _cargarPreferencias();
  }

  /// Obtener el estado actual del modo oscuro.
  bool get modoOscuro => _modoOscuro;

  /// Obtener el idioma actual.
  Locale get idioma => _idioma;

  /// Obtener el tamaño actual del texto.
  double get tamanoTexto => _tamanoTexto;

  /// Cambiar el modo oscuro y guarda la preferencia.
  Future<void> cambiarModoOscuro(bool valor) async {
    _modoOscuro = valor;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('modoOscuro', valor);
  }

  /// Cambiar el idioma de la app y guarda la preferencia.
  Future<void> cambiarIdioma(String codigoIdioma) async {
    _idioma = Locale(codigoIdioma);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('idioma', codigoIdioma);
  }

  /// Cambiar el tamaño del texto y guarda la preferencia.
  Future<void> cambiarTamanoTexto(double valor) async {
    _tamanoTexto = valor;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('tamanoTexto', valor);
  }

  /// Cargar las preferencias guardadas en el dispositivo.
  Future<void> _cargarPreferencias() async {
    final prefs = await SharedPreferences.getInstance();
    _modoOscuro = prefs.getBool('modoOscuro') ?? false;
    _idioma = Locale(prefs.getString('idioma') ?? 'es');
    _tamanoTexto = prefs.getDouble('tamanoTexto') ?? 16.0;
    notifyListeners();
  }
}