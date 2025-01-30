class Transaccion {
  int? id;
  String unidadEntrada;
  String unidadSalida;
  double valorEntrada;
  double valorSalida;

  Transaccion({
    this.id,
    required this.unidadEntrada,
    required this.unidadSalida,
    required this.valorEntrada,
    required this.valorSalida,
  });

  /// Convertir una transacción a un Map (para insertar en la base de datos)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'unidadEntrada': unidadEntrada,
      'unidadSalida': unidadSalida,
      'valorEntrada': valorEntrada,
      'valorSalida': valorSalida,
    };
  }

  /// Crear una transacción a partir de un Map (para leer desde la base de datos)
  factory Transaccion.fromMap(Map<String, dynamic> map) {
    return Transaccion(
      id: map['id'],
      unidadEntrada: map['unidadEntrada'],
      unidadSalida: map['unidadSalida'],
      valorEntrada: map['valorEntrada'],
      valorSalida: map['valorSalida'],
    );
  }
}