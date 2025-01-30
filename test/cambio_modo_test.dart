import 'package:flutter_test/flutter_test.dart';
import 'package:repaso_examen/viewmodel/provider_ajustes.dart';


void main() {

  setUp((){
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  ///Prueba unitaria

  ///Comprobar que el modo oscuro y claro cambia de manera correcta
  test('Modo oscuro se cambia de manera correcta', () {

    final provider_ajustes = ProviderAjustes();

    expect(provider_ajustes.modoOscuro, false);

    provider_ajustes.toogleModoOscuro();

    expect(provider_ajustes.modoOscuro, true);

  });


  ///Comprobar que el tamaño de letra cambia de manera correcta
  test('El tamano de letra se cambia de manera correcta', () {

    final provider_ajustes = ProviderAjustes();

    expect(provider_ajustes.tamanoTexto, 16);

    provider_ajustes.toogleTamanoTexto();

    expect(provider_ajustes.tamanoTexto, 20);

  });

}