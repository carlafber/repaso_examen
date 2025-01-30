import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:repaso_examen/model/transaccion.dart';
import 'package:repaso_examen/viewmodel/transacciones_crud.dart';
import 'drawer.dart';

class Conversor extends StatefulWidget {
  const Conversor({super.key});

  @override
  ConversorState createState() => ConversorState();
}

class ConversorState extends State<Conversor> {
  AppDrawer appDrawer = AppDrawer();
  TransaccionCRUD transaccionCRUD = TransaccionCRUD();

  final _valor = TextEditingController();
  final List<String> unidades = <String>["km", "m", "mi"];
  String? unidadEntrada = "km";
  String? unidadSalida = "mi";
  double resultado = 0.0;
  String hintValor = "";
  Icon? iconoValor;

  static const conversionRates = {
    'km': {'km': 1.0, 'm': 1000.0, 'mi': 0.621371},
    'm': {'km': 0.001, 'm': 1.0, 'mi': 0.000621371},
    'mi': {'km': 1.60934, 'm': 1609.34, 'mi': 1.0},
  };

  @override
  void initState() {
    super.initState();
    ///Escuchar cambios
    _valor.addListener(() => actualizarHintValor(context, _valor.text)); 
  }

  void actualizarHintValor(BuildContext context, String valor){
    setState(() {
      if(valor.isEmpty){
        iconoValor = null;
      } else if(!RegExp(r'^\d+$').hasMatch(valor)){
        hintValor = AppLocalizations.of(context)!.hintTextoCon;
        iconoValor = const Icon(Icons.error, color: Colors.red);
      } else{
        hintValor = AppLocalizations.of(context)!.hintOKCon;
        iconoValor = const Icon(Icons.check_circle, color: Colors.green);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.titleCon),
      ),
      drawer: appDrawer,
      body: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _valor,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.labelCon,
                hintText: AppLocalizations.of(context)!.hintCon,
                suffixIcon: iconoValor,
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => actualizarHintValor(context, value),
              validator: (value) {
                if(value == null || value.isEmpty || double.tryParse(value) == 0) {
                  return AppLocalizations.of(context)!.errorCon; // Mensaje de error si el valor es 0 o vacío
                }
                return null;
              }
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    hintValor,
                  ),
                ],
              ),
            Padding(padding: EdgeInsets.all(10)),
            DropdownButton<String>(
              value: unidadEntrada,
              items: unidades
                .map((item) => DropdownMenuItem(
                  value: item,
                    child: Text(item),
                ))
                .toList(),
              onChanged: (String? newValue) {
                setState(() {
                  unidadEntrada = newValue;
                });
              }
            ),
            Padding(padding: EdgeInsets.all(10)),
            DropdownButton<String>(
              value: unidadSalida,
              items: unidades
                .map((item) => DropdownMenuItem(
                  value: item,
                    child: Text(item),
                ))
                .toList(),
              onChanged: (String? newValue) {
                setState(() {
                  unidadSalida = newValue;
                });
              }
            ),
            Padding(padding: EdgeInsets.all(10)),
            ElevatedButton(
              onPressed: (){
                ///convertir el text a número
                double valor = double.tryParse(_valor.text) ?? 0.0;
                //NO ESTA VALIDANDO SI ES 0

                if (_valor.text.isEmpty || valor == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(AppLocalizations.of(context)!.errorZeroCon)),
                  );
                  return;
                } else if (unidadEntrada != null && unidadSalida != null) {
                  resultado = valor * conversionRates[unidadEntrada]![unidadSalida]!;
                  ///Añadir resultado a la bbdd
                  Transaccion transaccion = Transaccion(unidadEntrada: unidadEntrada as String, unidadSalida: unidadSalida as String, valorEntrada: valor, valorSalida: resultado);

                  setState(() {
                    transaccionCRUD.crearTransaccion(transaccion);
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(AppLocalizations.of(context)!.valueSent)), // mensaje de confirmación abajo
                  );
                }
              },
              child: Text(AppLocalizations.of(context)!.btCont)
            ),
            Padding(padding: EdgeInsets.all(10)),
            Text(AppLocalizations.of(context)!.resultCon(resultado.toString(), unidadSalida!))
            //(conversionRates["km"])["mi"] <-- para convertir
          ],
        )
      ),
    );
  }
}
