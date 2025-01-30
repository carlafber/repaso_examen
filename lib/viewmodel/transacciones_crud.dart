import '/model/transaccion.dart';
import 'package:sqflite/sqflite.dart';
import '/services/bd_helper.dart';

class TransaccionCRUD {
  DBHelper db = DBHelper();

  /// Método que devuelve la lista de transacciones
  Future<List<Transaccion>> obtenerTransacciones() async {
    Database database = await db.abrirBD();
    final List<Map<String, dynamic>> mapas = await database.query('transaccion');
    return List.generate(mapas.length, (i){
      return Transaccion.fromMap(mapas[i]);
    });
  }

  /// Método que crea una transacción
  Future crearTransaccion(Transaccion transaccion) async {
    Database database = await db.abrirBD();
    
    /// Convertir el objeto Transaccion a mapa
    Map<String, dynamic> transaccionMap = transaccion.toMap();

    int resultado = await database.insert(
      'transaccion', // Nombre de la tabla
      transaccionMap, // Mapa de la transaccion que se insertará
      conflictAlgorithm: ConflictAlgorithm.replace, // Si ya existe, reemplaza
    );
    print("Transaccion creada con ID: $resultado");
  }

  /// Método para eliminar una transacción
  Future<void> eliminarTransaccion(int id) async {
    Database database = await db.abrirBD();  // Abre la base de datos
    await database.delete(
      'transaccion',  // El nombre de la tabla
      where: 'id = ?',  // Filtro para eliminar la transacción por ID
      whereArgs: [id],  // El argumento que contiene el ID de la transacción
    );
    print('TRANSACCIÓN con id $id eliminada');
  }
}