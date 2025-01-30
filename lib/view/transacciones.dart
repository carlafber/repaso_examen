import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '/viewmodel/transacciones_crud.dart';
import '/model/transaccion.dart';
import 'drawer.dart';

class Transacciones extends StatefulWidget {
  const Transacciones({super.key});

  @override
  TransaccionesState createState() => TransaccionesState();
}

class TransaccionesState extends State<Transacciones> {
  AppDrawer appDrawer = AppDrawer();
  TransaccionCRUD transaccionCRUD = TransaccionCRUD();

  List<Transaccion> transacciones = [];

  @override
  void initState() {
    super.initState();
    _cargarTransacciones();
  }

  /// Cargar transacciones desde la base de datos
  Future<void> _cargarTransacciones() async {
    List<Transaccion> lista = await transaccionCRUD.obtenerTransacciones();
    setState(() {
      transacciones = lista;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.titleTrans),
      ),
      drawer: appDrawer,
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: transacciones.length,
                itemBuilder: (context, index) {  
                  Transaccion transaccion = transacciones[index];
                  return ListTile(
                    title: Text("${transaccion.valorEntrada} ${transaccion.unidadEntrada} → ${transaccion.unidadSalida}", style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: Text("${AppLocalizations.of(context)!.resultTrans}: ${transaccion.valorSalida}"),
                    trailing: IconButton(
                      onPressed: () {
                        transaccionCRUD.eliminarTransaccion(transaccion.id as int);
                        setState(() {
                          /// Elimina la transacción de la lista
                          transacciones.removeWhere((t) => t.id == transaccion.id);
                        });
                      }, 
                      icon: Icon(Icons.delete, color: Colors.red)
                    ),
                  );
                },
              ),
            )
          ]
        )
      )
    );
  }
}