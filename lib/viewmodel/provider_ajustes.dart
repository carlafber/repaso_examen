import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Gestiona el estado global de la app. Se encarga de manejar el tema, idioma y el tamaño de texto
class ProviderAjustes extends ChangeNotifier{
  bool modoOscuro = false;
  Locale idioma = Locale('es');
  double tamanoTexto = 16.0;

  /// Constructor que carga las preferencias guardadas al iniciar la app.
  ProviderAjustes() {
    _cargarPreferencias();
  }

  /// Obtener el estado actual del modo oscuro.
  bool get modoOscuroG => modoOscuro;

  /// Obtener el idioma actual.
  Locale get idiomaG => idioma;

  /// Obtener el tamaño actual del texto.
  double get tamanoTextoG => tamanoTexto;

  /// Cambiar el modo oscuro y guarda la preferencia.
  Future<void> cambiarModoOscuro(bool valor) async {
    modoOscuro = valor;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('modoOscuro', valor);
  }

  /// Cambiar el idioma de la app y guarda la preferencia.
  Future<void> cambiarIdioma(String codigoIdioma) async {
    idioma = Locale(codigoIdioma);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('idioma', codigoIdioma);
  }

  /// Cambiar el tamaño del texto y guarda la preferencia.
  Future<void> cambiarTamanoTexto(double valor) async {
    tamanoTexto = valor;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('tamanoTexto', valor);
  }

  /// Cargar las preferencias guardadas en el dispositivo.
  Future<void> _cargarPreferencias() async {
    final prefs = await SharedPreferences.getInstance();
    modoOscuro = prefs.getBool('modoOscuro') ?? false;
    idioma = Locale(prefs.getString('idioma') ?? 'es');
    tamanoTexto = prefs.getDouble('tamanoTexto') ?? 16.0;
    notifyListeners();
  }

  void toogleModoOscuro(){
    modoOscuro = !modoOscuro;
    notifyListeners();
  }

  void toogleTamanoTexto(){
    tamanoTexto = tamanoTexto == 16.0 ? 20.0 : 16.0;
    notifyListeners();
  }
}