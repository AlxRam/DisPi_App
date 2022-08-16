// ignore_for_file: prefer_const_constructors
import 'dart:ffi';

import 'package:esfuerzos/Paginas/calculo_esfuerzo.dart';
import 'package:esfuerzos/Paginas/capacidad_portante.dart';
import 'package:esfuerzos/Paginas/contacto.dart';
import 'package:esfuerzos/Paginas/inicio.dart';
import 'package:esfuerzos/Paginas/manual.dart';
import 'package:esfuerzos/Paginas/micro_pilotes.dart';
import 'package:esfuerzos/Paginas/nuevacon.dart'; //usado
import 'package:esfuerzos/Paginas/wip.dart';
import 'package:flutter/material.dart';
//Pruebas
import 'Paginas/otraprueba.dart';
import 'package:esfuerzos/Paginas/prueba.dart';
import 'package:esfuerzos/Paginas/pruebalista.dart';
import 'package:esfuerzos/Paginas/idea_dos.dart';
import 'package:esfuerzos/Paginas/idea_dos.dart';
import 'package:esfuerzos/Paginas/graficas.dart';

void main() => runApp(EditarApp());

class EditarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF590E11), //Color fondo
          foregroundColor: Color(0xFFD9CEA1) //Color letra
        ),
        // fontFamily: 'Raleway',  Para meterle la fuente
        textTheme: ThemeData.light().textTheme.copyWith(
          //headline6 titulo de los scafold
          //subtitle1 texto de los hint
          //bodytext2 texto normal
          headline6: TextStyle(
            fontFamily: 'ubuntub',
            fontSize: 25,
          ),
          bodyText2: TextStyle(
            fontFamily: 'ubuntur',
            fontSize: 20,
          ),
          subtitle1: TextStyle(
            // fontFamily: 'cambri', //Use fuente cambri para formulas matematicas
            fontStyle: FontStyle.italic,
            fontSize: 20,
          )

        ),
        primarySwatch: Colors.pink,
        //primaryColor: Color(0xFF590E11)
      ),
      routes: {
        '/uno': (context) => Inicio(),
        '/dos': (context) => CalculoEsfuerzos(),
        '/tres': (context) => Wip(),
        // '/cuatro': (context) => CalculoPortante(),
        '/cuatro': (context) => Inicializador(),
        '/cinco': (context) => IniciaCalMicro(),
        '/seis': (context) => Contacto(),
        '/siete': (context) => Manual()
        // '/cinco': (context) => Inicializador(),


      },
      // home: PruebaListas(title: 'Prueba Lista'),
      // home: PruebaListass(title: 'Prueba Lista numero 2'),
      // home: pruebaPizza(title: 'Prueba Pizza'),
      home: Reinicio(),
      // home: MyHomePage(title: 'Hi',),
      // home: Scaffold(body: GraficaArea(595,100,707.73,682.21,672.64,354.20,596.29,19.32,16.39)),
    );
  }
}

