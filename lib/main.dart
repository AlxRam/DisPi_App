import 'package:esfuerzos/Paginas/calculo_esfuerzo.dart';
import 'package:esfuerzos/Paginas/contacto.dart';
import 'package:esfuerzos/Paginas/inicio.dart';
import 'package:esfuerzos/Paginas/manual.dart';
import 'package:esfuerzos/Paginas/micro_pilotes.dart';
import 'package:esfuerzos/Paginas/wip.dart';
import 'package:flutter/material.dart';
//Pruebas
import 'package:esfuerzos/Paginas/idea_dos.dart';

void main() => runApp(const EditarApp());

class EditarApp extends StatelessWidget {
  const EditarApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF590E11), //Color fondo
          foregroundColor: Color(0xFFD9CEA1) //Color letra
        ),
        // fontFamily: 'Raleway',  Para meterle la fuente
        textTheme: ThemeData.light().textTheme.copyWith(
          //headline6 titulo de los scafold
          //subtitle1 texto de los hint
          //bodytext2 texto normal
          headline6: const TextStyle(
            fontFamily: 'ubuntub',
            fontSize: 25,
          ),
          bodyText2: const TextStyle(
            fontFamily: 'ubuntur',
            fontSize: 20,
          ),
          subtitle1: const TextStyle(
            // fontFamily: 'cambri', //Use fuente cambri para formulas matematicas
            fontStyle: FontStyle.italic,
            fontSize: 20,
          )

        ),
        primarySwatch: Colors.pink,
        //primaryColor: Color(0xFF590E11)
      ),
      routes: {
        '/uno': (context) => const Inicio(),
        '/dos': (context) => CalculoEsfuerzos(),
        '/tres': (context) => Wip(),
        '/cuatro': (context) => const Inicializador(),
        '/cinco': (context) => const IniciaCalMicro(),
        '/seis': (context) => const Contacto(),
        '/siete': (context) => Manual()
      },
      home: const Reinicio(),
    );
  }
}

