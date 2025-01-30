import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '/view/conversor.dart';

void main() {
  test('Conversión de unidades de km a m', () {
    final conversor = Conversor();

    /// Datos de prueba: 1 km a metros
    double valorEntrada = 1.0;
    String unidadEntrada = 'km';
    String unidadSalida = 'm';

    /// Realizar la conversión
    double resultado = valorEntrada * conversor.conversionRates[unidadEntrada]![unidadSalida]!;

    /// Verificar si el resultado es correcto
    expect(resultado, 1000.0); // 1 km = 1000 m

  
  });
}