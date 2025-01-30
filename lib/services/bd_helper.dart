import 'package:path/path.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
 
class DBHelper{
  Future<Database> abrirBD() async{
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'transacciones.db');


    return openDatabase(path, onCreate: (db, version) async{
      await db.execute('''
        CREATE TABLE IF NOT EXISTS transaccion (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          unidadEntrada TEXT NOT NULL,
          unidadSalida TEXT NOT NULL,
          valorEntrada REAL NOT NULL,
          valorSalida REAL NOT NULL
        )
      ''');

      await db.insert('transaccion', {'unidadEntrada': 'km', 'unidadSalida': 'mi', 'valorEntrada': 1234.0, 'valorSalida': 7670.82}, conflictAlgorithm: ConflictAlgorithm.replace);
    }, version: 1
    );

  }

}