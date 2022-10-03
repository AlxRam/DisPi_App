import 'dart:math';
import 'dart:typed_data';
import 'dart:io';
import 'package:esfuerzos/Paginas/graficas.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'dart:ui';
import 'package:flutter/cupertino.dart';

class ResultadosMic extends StatelessWidget {
  //para capturar imagen
  ScreenshotController chequeos = ScreenshotController();
  ScreenshotController asenta = ScreenshotController();
  ScreenshotController micro = ScreenshotController();
  ScreenshotController secc1 = ScreenshotController();
  ScreenshotController secc2 = ScreenshotController();
  //para salvarla ojo con el ?
  late Uint8List _chequeos;
  late Uint8List _asenta;
  late Uint8List _micro;
  late Uint8List _secc1;
  late Uint8List _secc2;
  //Variables inicializadoras
  double pc=0,pt=0,cu=0,cy=0,fyb=0,fub=0,ab=0,es=0,od=0,tw=0,fyc=0,ac=0,lup=0,
      fc=0,eg=0,d=0,agc=0,aguc=0,dp=0,db=0,a=0,ar=0,a1=0,a2=0,abond=0,fs=0,tp=0;
  String tbar ='', tlec ='', est='', nbro='',dbro='';
  //Variables resultados
  double pce=0,pcs=0,pte=0,pts=0,lb=0,pg=0,eac=0,eas=0,atc=0,ats=0,on=0,ou=0;

  ResultadosMic(this.pc,this.pt,this.tbar,this.cu,this.cy,this.fyb,this.fub,this.ab, this.es, this.od,
      this.tw,this.fyc,this.ac,this.lup,this.fc,this.eg,this.d,this.agc, this.aguc, this.tlec,this.dp,
      this.db,this.a,this.ar,this.a1,this.a2,this.abond,this.fs,this.est,this.tp,this.nbro,this.dbro, {Key? key}
      ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Va despues del build para estar a la par de la jerarquia y usar el provider
    // final datos = Provider.of<Datos>(context);  //Este daña to-do el widget
    //Se usa uno aca, ya que varios comparten esta cara
    final decora = BoxDecoration(color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black38,
          width: 1,
        )
    );
    calculos();
    return Scaffold(
        appBar: AppBar(
            title: const Center(child: Text('Resultados'))
        ),
        backgroundColor: const Color(0xFFE7E7E7),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(11),
                child: Column(
                    children: [
                      Container(
                          decoration: decora,
                          width: MediaQuery.of(context).size.width*.95,
                          height: 1300,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Text(
                                    'PARAMETROS DE CALCULO',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color:Colors.lightBlueAccent)
                                ),
                                const SizedBox(height: 3),
                                const Text('  -Cargas en micropilote'),
                                subindice('Carga a compresión:  P', 'c', pc, 'kN'),
                                subindice('Carga a tensión:  P', 't', pt, 'kN'),
                                const SizedBox(height: 0.7),
                                const Text('  -Acero de refuerzo'),
                                subindice('Especificación de la barra ', '', tbar, ''),
                                subindice('Carga última barra:  C', 'u', cu, 'kN'),
                                subindice('Carga fluencia barra:  C', 'y', cy, 'kN'),
                                subindice('Resistencia a \n  fluencia barra:  F', 'yb', fyb, 'MPa'),
                                subindice('Resistencia última barra:  F', 'ub', fub, 'MPa'),
                                subindice('Area barra:  A', 'b', ab, 'mm²'),
                                subindice('Módulo elástico acero:  E', 's', es, 'MPa'),
                                subindice('Diámetro externo \n  encamisado:  O.D.', '', od, 'mm'),
                                subindice('Espesor encamisado:  t', 'w', tw, 'mm'),
                                subindice('Resistencia a  \n  fluencia encamisado:  F', 'yc', fyc, 'MPa'),
                                subindice('Area encamisado:  A', 'c', ac.toStringAsFixed(2), 'mm²'),
                                subindice('Longitud encamisado:  L', 'up', lup, 'm'),
                                const SizedBox(height: 0.7),
                                const Text('  -Lechada'),
                                subindice("Resistencia a \n  compresión lechada:  f '", 'C', fc, 'MPa'),
                                subindice('Módulo elástico grout:  E', 'g', eg.toStringAsFixed(2), 'MPa'),
                                subindice('Diámetro vaciado \n  lechada:  D', '', d, 'mm'),
                                subindice('Area lechada \n  encamisada:  A', 'gc', agc.toStringAsFixed(2), 'mm²'),
                                subindice('Area lechada \n  sin camisa:  A', 'guc', aguc.toStringAsFixed(2), 'mm²'),
                                subindice('Tipo lechada ', '', tlec, ''),
                                const SizedBox(height: 0.7),
                                const Text('  -Platina'),
                                subindice('Diámetro perforación:  D', 'p', dp, 'mm'),
                                subindice('Diámetro bisel:  D', 'b', db, 'mm'),
                                subindice('Longitud platina:  a', '', a, 'mm'),
                                subindice('Area platina:  A', '', ar, 'mm²'),
                                subindice('Area cargada:  A', '1', a1.toStringAsFixed(2), 'mm²'),
                                subindice('Area inferior base:  A', '2', a2.toStringAsFixed(2), 'mm²'),
                                const SizedBox(height: 0.7),
                                const Text('  -Suelo'),
                                subindice('Tipo de suelo ', '', est, ''),
                                subindice('Coeficiente α \n  ground to grout:  α', 'bond', abond, 'kPa'),
                                subindice('Factor de seguridad:  F.S.', '', fs, ''),
                              ]
                          )
                      ),
                      const SizedBox(height: 13),
                      Container(
                          decoration: decora,
                          width: MediaQuery.of(context).size.width*.95,
                          height: 720,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Text(
                                    'DISEÑO ESTRUCTURAL',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color:Colors.lightBlueAccent)
                                ),
                                const SizedBox(height: 3),
                                const Text('  -Capacidad a Compresión'),
                                formula('  Capacidad estructural (Encamisado)'),
                                Row(
                                  //Ecuacion  5-1
                                    children: [
                                      formula('  P','c'),
                                      formula(" = [0.4 f '" ,'c'),
                                      formula(' * A' ,'g'),
                                      formula(' + 0.47 F' ,'yc'),
                                      formula(' (A' ,'b'),
                                      formula(' + A' ,'c'),
                                      formula(' )]')
                                    ]
                                ),
                                Row(
                                  //Transpuesta
                                    children: [
                                      formula('  P','c'),
                                      formula('  = [0.4 * $fc * ${agc.toStringAsFixed(2)} \n  + 0.47 * $fyc * (${ab.toStringAsFixed(2)} + ${ac.toStringAsFixed(2)})]')
                                    ]
                                ),
                                subindice('P', 'c', pce.toStringAsFixed(2), 'kN'),
                                formula('  Capacidad estructural (Sin camisa)'),
                                Row(
                                  //Ecuacion  5-7
                                    children: [
                                      formula('  P','c'),
                                      formula(" = (0.4 f '" ,'c'),
                                      formula(' * A' ,'g'),
                                      formula(' + 0.47 F' ,'yb'),
                                      formula(' * A' ,'b'),
                                      formula(' )')
                                    ]
                                ),
                                Row(
                                  //Transpuesta
                                    children: [
                                      formula('  P','c'),
                                      formula('  = (0.4 * $fc * ${aguc.toStringAsFixed(2)} \n  + 0.47 * $fyb * $ab )')
                                    ]
                                ),
                                subindice('P', 'c', pcs.toStringAsFixed(2), 'kN'),
                                const SizedBox(height: 0.7),
                                const Text('  -Capacidad a Tensión'),
                                formula('  Capacidad estructural (Encamisado)'),
                                Row(
                                  //Ecuacion  5-2
                                    children: [
                                      formula('  P','t'),
                                      formula(' = 0.55 F' ,'yc'),
                                      formula(' (A' ,'b'),
                                      formula(' + A' ,'c'),
                                      formula(' )')
                                    ]
                                ),
                                Row(
                                  //Transpuesta
                                    children: [
                                      formula('  P','t'),
                                      formula('  = 0.55 * $fyc * (${ab.toStringAsFixed(2)} + ${ac.toStringAsFixed(2)})')
                                    ]
                                ),
                                subindice('P', 't', pte.toStringAsFixed(2), 'kN'),
                                formula('  Capacidad estructural (Sin camisa)'),
                                Row(
                                  //Ecuacion  5-8
                                    children: [
                                      formula('  P','t'),
                                      formula(' = 0.55 F' ,'yb'),
                                      formula(' * A' ,'b'),
                                    ]
                                ),
                                Row(
                                  //Transpuesta
                                    children: [
                                      formula('  P','t'),
                                      formula('  = 0.55 * $fyb * $ab')
                                    ]
                                ),
                                subindice('P', 't', pts.toStringAsFixed(2), 'kN'),
                              ]
                          )
                      ),
                      const SizedBox(height: 13),
                      Container(
                          decoration: decora,
                          width: MediaQuery.of(context).size.width*.95,
                          height: 520,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Text(
                                    'DISEÑO GEOTECNICO',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color:Colors.lightBlueAccent)
                                ),
                                const SizedBox(height: 3),
                                const Text('  -Cálculo longitud mínima de barra'),
                                formula('  Longitud mínima de barra,  L','b'),
                                //Ecuacion  5-10
                                Row(
                                    children: [
                                      formula('  L','b'),
                                      formula(' = '),
                                      Column(
                                          children: [
                                            Row(
                                                children: [
                                                  formula(' P' ,'c'),
                                                  formula(' * F.S.'),
                                                ]
                                            ),
                                            const Text('________________________', style: TextStyle(fontSize: 9.5)),
                                            Row(
                                                children: [
                                                  formula(' α' ,'bond'),
                                                  formula(' * π'),
                                                  formula(' * D')
                                                ]
                                            )
                                          ]
                                      )
                                    ]
                                ),
                                //Transpuesta
                                Row(
                                    children: [
                                      formula('  L','b'),
                                      formula(' = '),
                                      Column(
                                          children: [
                                            formula(' $pc * $fs'),
                                            const Text('________________________', style: TextStyle(fontSize: 9.5)),
                                            formula(' $abond * π * $d')
                                          ]
                                      )
                                    ]
                                ),
                                subindice('L', 'b', lb, 'm'),
                                const SizedBox(height: 0.7),
                                const Text('  -Capacidad Geotécnica'),
                                formula('  Capacidad Geotécnica'),
                                //Ecuacion  5-9
                                Row(
                                    children: [
                                      formula('  P','g'),
                                      formula(' = '),
                                      Column(
                                          children: [
                                            Row(
                                                children: [
                                                  formula(' α' ,'bond'),
                                                  formula(' * π * D * L' ,'b')
                                                ]
                                            ),
                                            const Text('_____________________________', style: TextStyle(fontSize: 9.5)),
                                            formula('F.S.')
                                          ]
                                      )
                                    ]
                                ),
                                //Transpuesta
                                Row(
                                    children: [
                                      formula('  P','g'),
                                      formula(' = '),
                                      Column(
                                          children: [
                                            formula(' $abond * π * $d * $lb'),
                                            const Text('________________________', style: TextStyle(fontSize: 9.5)),
                                            formula(' $fs')
                                          ]
                                      )
                                    ]
                                ),
                                subindice('P', 'g', pg.toStringAsFixed(2), 'kN'),
                              ]
                          )
                      ),
                      const SizedBox(height: 13),
                      Container(
                          decoration: decora,
                          width: MediaQuery.of(context).size.width*.95,
                          height: 730,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Text(
                                    'DISEÑO CONEXION A CABEZAL \n Y BROCA DE PERFORACION',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color:Colors.lightBlueAccent)
                                ),
                                const SizedBox(height: 3),
                                const Text('  -Cálculo Resistencia de la platina'),
                                formula('  Resistencia nominal al aplastamiento,  σ','n'),
                                //Ecuacion  Aci 10.17
                                Row(
                                    children: [
                                      formula('  σ','n'),
                                      formula(" = ϕ * 0.85 * f '",'C'),
                                      formula(' * √ ( A','2'),
                                      formula(' / A','1'),
                                      formula(' )')
                                    ]
                                ),
                                subindice('ϕ', '', 0.65, ''),
                                //Transpuesta
                                Row(
                                    children: [
                                      formula('  σ','n'),
                                      formula('  = 0.65 * 0.85 \n  * $fc * √ ( ${a2.toStringAsFixed(2)} / ${a1.toStringAsFixed(2)} )')
                                    ]
                                ),
                                subindice('σ', 'n', on.toStringAsFixed(2), 'MPa'),
                                const SizedBox(height: 0.7),
                                const Text('  -Capacidad Platina'),
                                formula('  Capacidad aplastamiento platina'),
                                //Ecuacion  Aci 10.17
                                Row(
                                    children: [
                                      formula('  σ','u'),
                                      formula(' = ϕ * P','c'),
                                      formula(' / A','1')
                                    ]
                                ),
                                subindice('ϕ', '', 1.6, ''),
                                //Transpuesta
                                Row(
                                    children: [
                                      formula('  σ','u'),
                                      formula(' = 1.6 * $pc / $a1')
                                    ]
                                ),
                                subindice('σ', 'u', ou.toStringAsFixed(2), 'MPa'),
                                const SizedBox(height: 0.7),
                                const Text('  -Broca de perforación'),
                                Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: formula(
                                        'Para un suelo de $est, \nel fabricante recomienda la broca $nbro,\nya que es $dbro')
                                ),
                                formula('  En caso de tener presencia de rocas duras\n  se recomienda usar la línea con refuerzos \n  de Widia o una broca de mayor capacidad')
                              ]
                          )
                      ),
                      const SizedBox(height: 13),
                      Container(
                          decoration: decora,
                          width: MediaQuery.of(context).size.width*.95,
                          height: 700,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Text(
                                    'CHEQUEO DE RESULTADOS',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color:Colors.lightBlueAccent)
                                ),
                                const SizedBox(height: 3),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      formula('   Capacidad Estructural \n  Compresión Encamisado'),
                                      pce > pc ? formula('OK     ') : formula('   Revisar \nCapacidad')
                                    ]
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      formula('  Capacidad Estructural \n  Compresión Sin Camisa'),
                                      pcs > pc ? formula('OK     ') : formula('   Revisar \nCapacidad')
                                    ]
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      formula('   Capacidad Estructural \n     Tensión Encamisado'),
                                      pte > pt ? formula('OK     ') : formula('   Revisar \nCapacidad')
                                    ]
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      formula('  Capacidad Estructural \n     Tensión Sin Camisa'),
                                      pts > pt ? formula('OK     ') : formula('   Revisar \nCapacidad')
                                    ]
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      formula('  Capacidad Geotécnica '),
                                      pg > pc ? formula('OK     ') : formula('   Revisar \nCapacidad')
                                    ]
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      formula('    Capacidad Platina '),
                                      on > ou ? formula('   OK     ') : formula('   Revisar \nCapacidad')
                                    ]
                                ),
                                const SizedBox(height: 0.7),
                                const Text(
                                    'Gráfica',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color:Colors.lightBlueAccent)
                                ),
                                SizedBox(
                                  height: 350,
                                  child: Screenshot(
                                      controller: chequeos,
                                      child: GraficaArea(pc,pt,pce,pcs,pte,pts,pg,on,ou)
                                  ),
                                )
                              ]
                          )
                      ),
                      const SizedBox(height: 13),
                      Container(
                          decoration: decora,
                          width: MediaQuery.of(context).size.width*.95,
                          height: 1500,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Text(
                                    'ESTIMACION DE ASENTAMIENTOS',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color:Colors.lightBlueAccent)
                                ),
                                const SizedBox(height: 3),
                                const Text('  -Asentamientos elásticos \n   Zona encamisada'),
                                formula('  Asentamientos elásticos,  Δt','elastic'),
                                //Ecuacion  5-20
                                Row(
                                    children: [
                                      formula('  EA','cased'),
                                      formula(' = A','gc'),
                                      formula(' * E','g'),
                                      formula(' + ( A','b'),
                                      formula(' + A','c'),
                                      formula(' ) * E','s')
                                    ]
                                ),
                                //Transpuesta
                                Row(
                                    children: [
                                      formula('  EA','cased'),
                                      formula('  = ${agc.toStringAsFixed(2)} * ${eg.toStringAsFixed(2)} \n  + ( ${ab.toStringAsFixed(2)} + ${ac.toStringAsFixed(2)} ) * $es')
                                    ]
                                ),
                                subindice('EA', 'cased', eac.toStringAsFixed(2), ''),
                                Row(
                                    children: [
                                      formula('  Δt','elastic'),
                                      formula(' = '),
                                      Column(
                                          children: [
                                            Row(
                                                children: [
                                                  formula(' P' ,'c'),
                                                  formula(' * L' ,'up')
                                                ]
                                            ),
                                            const Text('________________', style: TextStyle(fontSize: 9.5)),
                                            formula(' EA','cased')
                                          ]
                                      )
                                    ]
                                ),
                                //Transpuesta
                                Row(
                                    children: [
                                      formula('  Δt','elastic'),
                                      formula(' = '),
                                      Column(
                                          children: [
                                            formula(' $pc * $lup'),
                                            const Text('________________________', style: TextStyle(fontSize: 9.5)),
                                            formula(' ${eac.toStringAsFixed(2)}')
                                          ]
                                      )
                                    ]
                                ),
                                subindice('Δt', 'elastic', atc.toStringAsFixed(4), 'm'),
                                subindice('Δt', 'elastic', (atc*1000).toStringAsFixed(2), 'mm'),
                                const SizedBox(height: 0.7),
                                const Text('  -Asentamientos elásticos \n   Zona sin camisa'),
                                formula('  Asentamientos elásticos,  Δt','elastic'),
                                //Ecuacion  5-20
                                Row(
                                    children: [
                                      formula('  EA','uncased'),
                                      formula(' = A','guc'),
                                      formula(' * E','g'),
                                      formula(' + A','b'),
                                      formula(' * E','s')
                                    ]
                                ),
                                //Transpuesta
                                Row(
                                    children: [
                                      formula('  EA','uncased'),
                                      formula('  = ${aguc.toStringAsFixed(2)} * ${eg.toStringAsFixed(2)} \n  + ${ab.toStringAsFixed(2)} * ${es.toStringAsFixed(2)}')
                                    ]
                                ),
                                subindice('EA', 'uncased', eas.toStringAsFixed(2), ''),
                                Row(
                                    children: [
                                      formula('  Δt','elastic'),
                                      formula(' = '),
                                      Column(
                                          children: [
                                            Row(
                                                children: [
                                                  formula(' P' ,'c'),
                                                  formula(' * L' ,'b')
                                                ]
                                            ),
                                            const Text('_________________', style: TextStyle(fontSize: 9.5)),
                                            formula(' EA','uncased')
                                          ]
                                      )
                                    ]
                                ),
                                //Transpuesta
                                Row(
                                    children: [
                                      formula('  Δt','elastic'),
                                      formula(' = '),
                                      Column(
                                          children: [
                                            formula(' $pc * $lb'),
                                            const Text('________________________', style: TextStyle(fontSize: 9.5)),
                                            formula(' ${eas.toStringAsFixed(2)}')
                                          ]
                                      )
                                    ]
                                ),
                                subindice('Δt', 'elastic', ats.toStringAsFixed(4), 'm'),
                                subindice('Δt', 'elastic', (ats*1000).toStringAsFixed(2), 'mm'),
                                const SizedBox(height: 0.7),
                                const Text('  -Asentamientos elásticos \n   Totales'),
                                Row(
                                    children: [
                                      formula('  Δt','elastic'),
                                      formula(' = ${atc.toStringAsFixed(4)} + ${ats.toStringAsFixed(4)}')
                                    ]
                                ),
                                subindice('Δt', 'elastic', (ats+atc).toStringAsFixed(4), 'm'),
                                subindice('Δt', 'elastic', ((ats+atc)*1000).toStringAsFixed(2), 'mm'),
                                formula('  Los asentamientos no deben superar 0.3 m \n  según título H.4.9.2 de la NSR-10'),
                                const SizedBox(height: 0.7),
                                const Text(
                                    'Gráfica',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color:Colors.lightBlueAccent)
                                ),
                                SizedBox(
                                    height: 350,
                                    child: Screenshot(
                                        controller: asenta,
                                        child: GraficaAsenta(eac, eas, pc, lup, lb))
                                )
                              ]
                          )
                      ),
                      const SizedBox(height: 13),
                      Container(
                          decoration: decora,
                          width: MediaQuery.of(context).size.width*.95,
                          height: 1110, //600
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Text(
                                    'DETALLES DEL DISEÑO',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color:Colors.lightBlueAccent)
                                ),
                                const SizedBox(height: 3),
                                Screenshot(
                                  controller: micro,
                                  child: Container(
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(image: AssetImage('imagenes/pilotes/mic.png'))
                                      ),
                                      height: 550,
                                      child: Padding(
                                          padding: const EdgeInsets.only(top:10, left: 82),
                                          child: Row(
                                              children: [
                                                Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      const SizedBox(height: 135, width: 135),
                                                      Text('          ${lup.toStringAsFixed(2)} m', style: const TextStyle(fontFamily: 'cambri', fontSize: 14)),
                                                      const SizedBox(height: 90),
                                                      Text('${(lup+lb).toStringAsFixed(2)} m', style: const TextStyle(fontFamily: 'cambri', fontSize: 14)),
                                                      const SizedBox(height: 113),
                                                      Text('          ${lb.toStringAsFixed(2)} m', style: const TextStyle(fontFamily: 'cambri', fontSize: 14))
                                                    ]
                                                ),
                                                Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text('   Platina Cuadrada\n ${a.toStringAsFixed(0)} x ${a.toStringAsFixed(0)} x ${tp.toStringAsFixed(0)} mm', style: const TextStyle(fontFamily: 'cambri', fontSize: 15)),
                                                      const SizedBox(height: 2),
                                                      Text('  Encamisado\n O.D. = $od mm\n tw = $tw mm', style: const TextStyle(fontFamily: 'cambri', fontSize: 14.5)),
                                                      const SizedBox(height: 113),
                                                      Text(est, style: const TextStyle(fontFamily: 'cambri', fontSize: 15)),
                                                      const SizedBox(height: 65),
                                                      Text('   Lechada $tlec', style: const TextStyle(fontFamily: 'cambri', fontSize: 15)),
                                                      const SizedBox(height: 47),
                                                      Text('   Barra DSI $tbar', style: const TextStyle(fontFamily: 'cambri', fontSize: 15)),
                                                      const SizedBox(height: 82),
                                                      Text('   Rosca $nbro', style: const TextStyle(fontFamily: 'cambri', fontSize: 15))
                                                    ]
                                                )
                                              ]
                                          )
                                      )
                                  ),
                                ),
                                const SizedBox(height: 0.7),
                                Screenshot(
                                  controller: secc1,
                                  child: Container(
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(image: AssetImage('imagenes/pilotes/sec1.png')),
                                      ),
                                      height: 230,
                                      child: Padding(
                                        // padding: const EdgeInsets.only(top:8 ,right: 15, left: 225),
                                          padding: const EdgeInsets.only(top:3, left: 200),
                                          child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('  Barra DSI $tbar', style: const TextStyle(fontFamily: 'cambri', fontSize: 15)),
                                                const SizedBox(height: 33),
                                                Text('  Grout  f\'c  $fc MPa\n  $tlec ', style: const TextStyle(fontFamily: 'cambri', fontSize: 15)),
                                                const SizedBox(height: 30),
                                                Text('  Encamisado\n O.D. = $od mm\n tw = $tw mm', style: const TextStyle(fontFamily: 'cambri', fontSize: 15))
                                              ]
                                          )
                                      )
                                  ),
                                ),
                                const SizedBox(height: 0.7),
                                Screenshot(
                                    controller: secc2,
                                    child: Container(
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(image: AssetImage('imagenes/pilotes/sec2.png')),
                                        ),
                                        height: 250,
                                        child: Padding(
                                          // padding: const EdgeInsets.only(top:8 ,right: 15, left: 225),
                                            padding: const EdgeInsets.only(top:13, left: 200),
                                            child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('  Barra DSI $tbar', style: const TextStyle(fontFamily: 'cambri', fontSize: 15)),
                                                  const SizedBox(height: 33),
                                                  Text('  Grout  f\'c  $fc MPa\n  $tlec ', style: const TextStyle(fontFamily: 'cambri', fontSize: 15)),
                                                  const SizedBox(height: 50),
                                                  Text('  Cuerpo Grout\n  D = $d mm', style: const TextStyle(fontFamily: 'cambri', fontSize: 15))
                                                ]
                                            )
                                        )
                                    )
                                )
                              ]
                          )
                      ),
                      //remitir a PDF, darle nueva cara al programa y crear seccion ayuda
                      const SizedBox(height: 13),
                      ElevatedButton.icon(
                          onPressed: (){
                            chequeos.capture().then((value) async {
                              _chequeos = value!;
                            });
                            asenta.capture().then((value) async {
                              _asenta = value!;
                            });
                            micro.capture().then((value) async {
                              _micro = value!;
                            });
                            secc1.capture().then((value) async {
                              _secc1 = value!;
                            });
                            secc2.capture().then((value) async {
                              _secc2 = value!;
                              _createPDF();
                            });
                          },
                          label: const Text('Reporte', style: TextStyle(fontSize: 18)),
                          icon: const Icon(Icons.picture_as_pdf_outlined, size: 30),
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFA72026))
                      )
                    ]
                )
            )
        )
    );
  }
  //Calculos utilizados
  calculos (){
    //Ecuacion 5-1
    pce = (0.4*fc*agc+0.47*fyc*(ab+ac))/1000;
    //Ecuacion 5-7
    pcs = (0.4*fc*aguc+0.47*fyb*ab)/1000;
    //Ecuacion 5-2
    pte = (0.55*fyc*(ab+ac))/1000;
    //Ecuacion 5-8
    pts = (0.55*fyb*ab)/1000;
    //Ecuacion 5-10
    lb = double.parse(((pc*fs)/(pi*abond*d/1000)*1.008).toStringAsFixed(1)); //se agg 0.8% para que aproxime al de arriba
    //Ecuacion 5-9
    pg = abond/fs*d*pi*lb/1000;
    //Ecuacion Aci 10.17
    on = 0.65*0.85*fc*sqrt(a2/a1);
    ou = 1.6*pc*1000/a1;
    //Ecuadion 5-20
    eac = (agc*eg+(ab+ac)*es)/1000;
    atc = pc*lup/eac;
    eas = (aguc*eg+ab*es)/1000;
    ats = pc*lb/eas;

  }
  //Metodo escribir con bajitos
  subindice (String a, String s, var value, String unit) {
    return RichText(
        text: TextSpan(
            style: const TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'cambri'),
            children: [
              TextSpan(text: '  $a'),
              WidgetSpan(
                  child: Transform.translate(
                      offset: const Offset(0.0, 4.0),
                      child: Text( s, style: const TextStyle(fontSize: 13, fontFamily: 'cambri'))
                  )
              ),
              TextSpan(
                text: ' = $value $unit',
              )
            ]
        )
    );
  }
  //Metodo para escribir formulas
  formula (String a, [String s = '']) {
    return RichText(
        text: TextSpan(
            style: const TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'cambri'),
            children: [
              TextSpan(text: a),
              WidgetSpan(
                  child: Transform.translate(
                      offset: const Offset(0.0, 4.0),
                      child: Text(s, style: const TextStyle(fontSize: 13, fontFamily: 'cambri'))
                  )
              )
            ]
        )
    );
  }

  //PDF
//Metodo para crear el pdf
  Future<void>_createPDF() async {
    PdfDocument document = PdfDocument();
    final page = document.pages.add();

    //Agg de pie de pagina y cabeza
    //Create the header with specific bounds
    PdfPageTemplateElement header = PdfPageTemplateElement(
        Rect.fromLTWH(0, 0, document.pageSettings.size.width, 100));

    //Create the date and time field
    PdfDateTimeField dateAndTimeField = PdfDateTimeField(
        font: PdfStandardFont(PdfFontFamily.timesRoman, 12),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)));
    dateAndTimeField.date = DateTime.now();
    dateAndTimeField.dateFormatString = 'MM.dd.yyyy';

    //Create the composite field with date field
    PdfCompositeField compositefields = PdfCompositeField(
        font: PdfStandardFont(PdfFontFamily.timesRoman, 12),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        text: '    Date: {0}                            DISEÑO DE MICROPILOTES                             Project: 0001'
            '\n__________________________________________________________________________________ ',
        fields: <PdfAutomaticField>[dateAndTimeField]);

    //Add composite field in header
    compositefields.draw(header.graphics,
        Offset(0, 50 - PdfStandardFont(PdfFontFamily.timesRoman, 11).height));

    //Add the header at top of the document
    document.template.top = header;

    //Create the footer with specific bounds
    PdfPageTemplateElement footer = PdfPageTemplateElement(
        Rect.fromLTWH(0, 0, document.pageSettings.size.width, 50));

    //Create the page number field
    PdfPageNumberField pageNumber = PdfPageNumberField(
        font: PdfStandardFont(PdfFontFamily.timesRoman, 12),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)));

    //Sets the number style for page number
    pageNumber.numberStyle = PdfNumberStyle.upperRoman;

    //Create the page count field
    PdfPageCountField count = PdfPageCountField(
        font: PdfStandardFont(PdfFontFamily.timesRoman, 12),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)));

    //set the number style for page count
    count.numberStyle = PdfNumberStyle.upperRoman;

    //Create the composite field with page number page count
    PdfCompositeField compositeField = PdfCompositeField(
        font: PdfStandardFont(PdfFontFamily.timesRoman, 12),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        text: 'Page {0} of {1}, by DisPi',
        fields: <PdfAutomaticField>[pageNumber, count]);
    compositeField.bounds = footer.bounds;

    //Add the composite field in footer
    compositeField.draw(footer.graphics,
        Offset(400, 50 - PdfStandardFont(PdfFontFamily.timesRoman, 12).height));

    //Add the footer at the bottom of the document
    document.template.bottom = footer;

    //Pagina Inicio
    page.graphics.drawString(
        '/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////'
            '\n/////////////////////////////////////REPORTE DE RESULTADOS/////////////////////////////////////'
            '\n/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////'
            '\n'
            '\n'
            '\nPARAMETROS DE CALCULO'
            '\n'
            '\n  -Cargas en micropilote'
            '\nCarga a compresión:  Pc $pc kN'
            '\nCarga a tensión:  Pt $pt kN'
            '\n'
            '\n  -Acero de refuerzo'
            '\nEspecificación de la barra:  $tbar'
            '\nCarga última barra:  Cu $cu kN'
            '\nCarga fluencia barra:  Cy $cy kN'
            '\nResistencia a fluencia barra:  Fyb $fyb MPa'
            '\nResistencia última barra:  Fub $fub MPa'
            '\nArea barra:  Ab $ab mm²'
            '\nMódulo elástico acero:  Es $es MPa'
            '\nDiámetro externo encamisado:  O.D. $od mm'
            '\nEspesor encamisado:  tw $tw mm'
            '\nResistencia a  fluencia encamisado:  Fyc $fyc MPa'
            '\nArea encamisado:  Ac ${ac.toStringAsFixed(2)} mm²'
            '\nLongitud encamisado:  Lup $lup m'
            '\n'
            '\n  -Lechada'
            "\nResistencia a compresión lechada:  f 'c $fc MPa"
            '\nMódulo elástico grout:  Eg ${eg.toStringAsFixed(2)} MPa'
            '\nDiámetro vaciado lechada:  D $d mm'
            '\nArea lechada encamisada:  Agc ${agc.toStringAsFixed(2)} mm²'
            '\nArea lechada sin camisa:  Aguc ${aguc.toStringAsFixed(2)} mm²'
            '\nTipo lechada : $tlec'
            '\n'
        ,
        PdfStandardFont(PdfFontFamily.timesRoman, 16, style: PdfFontStyle.italic)
    );
    //Para Agg mas página
    document.pages.add().graphics.drawString(
        '  -Platina'
            '\nDiámetro perforación:  Dp $dp mm'
            '\nDiámetro bisel:  Db $db mm'
            '\nLongitud platina:  a $a mm'
            '\nArea platina:  A $ar mm²'
            '\nArea cargada:  A1 ${a1.toStringAsFixed(2)} mm²'
            '\nArea inferior base:  A2 ${a2.toStringAsFixed(2)} mm²'
            '\n'
            '\n  -Suelo'
            '\nTipo de suelo: $est'
            '\nCoeficiente a ground to grout:  abond $abond kPa'
            '\nFactor de seguridad:  F.S. $fs'
            '\n'
            '\n'
            '\nDISEÑO ESTRUCTURAL'
            '\n'
            '\n  -Capacidad a Compresión'
            '\n'
            '\n  Capacidad estructural (Encamisado)'
            '\nPc = [0.4 * Agc * f \'c  +  0.47 * Fyc * (Ac + Ab)]'
            '\nPc = [0.4 * ${agc.toStringAsFixed(2)} * $fc  +  0.47 * $fyc (${ab.toStringAsFixed(2)} + ${ac.toStringAsFixed(2)})]'
            '\nPc = ${pce.toStringAsFixed(2)} kN'
            '\n  Capacidad estructural (Sin camisa)'
            '\nPc = [0.4 * Aguc * f \'c  +  0.47 * Fyb * Ab]'
            '\nPc = [0.4 * ${aguc.toStringAsFixed(2)} * $fc  +  0.47 * $fyb * ${ab.toStringAsFixed(2)}]'
            '\nPc = ${pcs.toStringAsFixed(2)} kN'
            '\n'
            '\n  -Capacidad a Compresión'
            '\n'
            '\n  Capacidad estructural (Encamisado)'
            '\nPt = 0.55 * Fyc * (Ac + Ab)'
            '\nPt = 0.55 * $fyc * (${ab.toStringAsFixed(2)} + ${ac.toStringAsFixed(2)})'
            '\nPt = ${pte.toStringAsFixed(2)} kN'
        ,
        PdfStandardFont(PdfFontFamily.timesRoman, 16, style: PdfFontStyle.italic)
    );

    document.pages.add().graphics.drawString(
        '  Capacidad estructural (Sin camisa)'
            '\nPt = 0.55 * Fyc * Ab'
            '\nPt = 0.55 * $fyc * ${ab.toStringAsFixed(2)}'
            '\nPt = ${pts.toStringAsFixed(2)} kN'
            '\n'
            '\n'
            '\nDISEÑO GEOTECNICO'
            '\n'
            '\n  -Cálculo longitud mínima de barra'
            '\n  Longitud mínima de barra,  Lb'
            '\nLb = (Pc * F.S.) / (abond * Pi() * D'
            '\nLb = ($pc * $fs) / ($abond * 3.1416 * $d'
            '\nLb = $lb m'
            '\n'
            '\n  -Capacidad Geotécnica'
            '\n  Capacidad Geotécnica'
            '\nPg = (abond / F.S.) * Lb * Pi() * D'
            '\nPg = ($abond / $fs) * $lb * Pi() * $d'
            '\nPg = ${pg.toStringAsFixed(2)} kN'
            '\n'
            '\n'
            '\nDISEÑO CONEXION A CABEZAL Y BROCA DE PERFORACION'
            '\n'
            '\n  -Cálculo Resistencia de la platina'
            '\n  Resistencia nominal al aplastamiento,  on'
            '\non = Phi * 0.85 * f \'c * sqrt ( A2 / A1)'
            '\non = 0.65 * 0.85 * $fc * sqrt ( ${a2.toStringAsFixed(2)} / ${a1.toStringAsFixed(2)}'
            '\non = ${on.toStringAsFixed(2)} MPa'
            '\n'
            '\n  -Capacidad Platina'
            '\n  Capacidad aplastamiento platina, ou'
            '\nou = (Phi * Pc) / A1'
            '\nou = (1.6 * $pc) / ${a1.toStringAsFixed(2)}'
            '\nou = ${ou.toStringAsFixed(2)} MPa'
        ,
        PdfStandardFont(PdfFontFamily.timesRoman, 16, style: PdfFontStyle.italic)
    );

    document.pages.add().graphics.drawString(
        '  -Broca de perforación'
            '\nPara un suelo de características mayoritarias a $est, '
            '\nel fabricante DSI DiwyDag recomienda la broca endurecida $nbro,'
            '\nya que según sus estudios, es $dbro.'
            '\n'
            '\nEn caso de tener presencia de rocas duras o tamaños considerables de suelos '
            '\nde mayor resistencia a la penetración, se recomienda usar las brocas de la línea'
            '\ncon refuerzos de Widia o una broca de mayor capacidad a la excavación.'
            '\n'
            '\n'
            '\nCHEQUEO DE RESULTADOS'
            '\n'
            '\nSe deben cumplir con las siguientes condiciones, de lo contrario, se deberá '
            '\nreplantear la toma de parámetros o el diseño de la propia barra: '
            '\n'
            '\n  -Capacidad estructural'
            '\n  Compresión Encamisado'
            '\n$pce > $pc'
            '\n  Compresión Sin Camisa'
            '\n$pcs > $pc'
            '\n  Tensión Encamisado'
            '\n$pte > $pt'
            '\n  Tensión Sin Camisa'
            '\n$pts > $pt'
            '\n'
            '\n  -Capacidad Geotécnica'
            '\n  Capacidad Geotécnica'
            '\n$pg > $pc'
            '\n'
            '\n  -Capacidad Platina'
            '\n  Capacidad Platina'
            '\n$on > $ou'
        ,
        PdfStandardFont(PdfFontFamily.timesRoman, 16, style: PdfFontStyle.italic)
    );

    document.pages.add().graphics.drawString(
        '                        GRAFICA CHEQUEO CAPACIDADES',
        PdfStandardFont(PdfFontFamily.timesRoman, 18, style: PdfFontStyle.italic)
    );
    document.pages[4].graphics.drawImage(
        PdfBitmap(await _readImageData(_chequeos)),
        const Rect.fromLTWH(70, 35, 340, 450)
    );
    document.pages[4].graphics.drawString(
        'Todos  los  valores  calculados,  deberán  de  superar  los  de  la  gráfica'
            '\nCargas  Aplicadas,  y  si  la  gráfica  Cargas  Últimas  no  supera  la'
            '\ngráfica Cargas Aplicadas, se deberá volver a diseñar el micropilote o en'
            '\nsu defecto, controlar sus parámetros para obtener los cálculos esperados.'
            '\nSe recomienda a criterio del diseñador, tomar la decisión más adecuada'
            '\nteniendo en cuenta las propiedades del suelo, el presupuesto y la '
            '\nexperiencia que respalde al diseñador.'
        ,
        PdfStandardFont(PdfFontFamily.timesRoman, 16, style: PdfFontStyle.italic),
        bounds :const Rect.fromLTWH(0, 485, 600,600)
    );

    document.pages.add().graphics.drawString(
        '\nESTIMACION DE ASENTAMIENTOS'
            '\n'
            '\n  -Asentamientos elásticos Zona encamisada'
            '\n  Asentamientos elásticos, dt elastic'
            '\nEA cased = Agc * Eg + ( Ab + Ac ) * Es'
            '\nEA cased = ${agc.toStringAsFixed(2)} * ${eg.toStringAsFixed(2)} + ( ${ab.toStringAsFixed(2)} + ${ac.toStringAsFixed(2)} ) * $es'
            '\nEA cased = ${eac.toStringAsFixed(2)}'
            '\ndt = ( Pc * Lup ) / EA cased'
            '\ndt = ( $pc * $lup ) / ${eac.toStringAsFixed(2)}'
            '\ndt = ${atc.toStringAsFixed(4)} m'
            '\ndt = ${(atc*1000).toStringAsFixed(2)} mm'
            '\n'
            '\n  -Asentamientos elásticos Zona Sin Camisa'
            '\n  Asentamientos elásticos, dt elastic'
            '\nEA uncased = Aguc * Eg + Ab * Es'
            '\nEA uncased = ${aguc.toStringAsFixed(2)} * ${eg.toStringAsFixed(2)} + ${ab.toStringAsFixed(2)}  * $es'
            '\nEA uncased = ${eas.toStringAsFixed(2)}'
            '\ndt = ( Pc * Lb ) / EA uncased'
            '\ndt = ( $pc * $lb ) / ${eas.toStringAsFixed(2)}'
            '\ndt = ${ats.toStringAsFixed(4)} m'
            '\ndt = ${(ats*1000).toStringAsFixed(2)} mm'
            '\n'
            '\n  -Asentamientos elásticos Totales'
            '\n  Asentamientos elásticos, dt elastic'
            '\ndt total = dt cased + dt uncased'
            '\ndt total = ${atc.toStringAsFixed(4)} + ${ats.toStringAsFixed(4)}'
            '\ndt total = ${(ats+atc).toStringAsFixed(4)} m'
            '\ndt total = ${((ats+atc)*1000).toStringAsFixed(2)} mm'
            '\nLos asentamientos no deben superar 0.3 m según título H.4.9.2 de la NSR-10'
        ,
        PdfStandardFont(PdfFontFamily.timesRoman, 16, style: PdfFontStyle.italic)
    );

    document.pages.add().graphics.drawString(
        '                      GRAFICA ESTIMACION DE ASENTAMIENTOS',
        PdfStandardFont(PdfFontFamily.timesRoman, 18, style: PdfFontStyle.italic)
    );
    document.pages[6].graphics.drawImage(
        PdfBitmap(await _readImageData(_asenta)),
        const Rect.fromLTWH(70, 35, 340, 450)
    );
    document.pages[6].graphics.drawString(
        'Se estiman los valores de los asentamientos provocados por ambas zonas'
            '\ndel micropilote, ya que en cada zona, el comportamiento de los asentamientos'
            '\nserá diferente por las propiedades mécanicas de cada zona.'
            '\nEl asentamiento a evaluar, será el asentamiento total el cual no deberá '
            '\nsuperar 0.3 m según título H.4.9.2 de la NSR-10, en caso de que se los'
            '\nasentamientos superen este valor, se deberá garantizar que  las cargas'
            '\nno superen ese limite o se deberá replantear la longitud del micropilote.'
        ,
        PdfStandardFont(PdfFontFamily.timesRoman, 16, style: PdfFontStyle.italic),
        bounds :const Rect.fromLTWH(0, 485, 600,600)
    );

    document.pages.add().graphics.drawString(
        'DETALLES DE DISEÑO',
        PdfStandardFont(PdfFontFamily.timesRoman, 16, style: PdfFontStyle.italic)
    );
    document.pages[7].graphics.drawImage(
        PdfBitmap(await _readImageData(_micro)),
        const Rect.fromLTWH(70, 40, 340, 570)
    );

    document.pages.add().graphics.drawImage(
        PdfBitmap(await _readImageData(_secc1)),
        const Rect.fromLTWH(0, 10, 520, 240)
    );
    document.pages[8].graphics.drawImage(
        PdfBitmap(await _readImageData(_secc2)),
        const Rect.fromLTWH(0, 300, 510, 250)
    );

    document.pages.add().graphics.drawString(
        '\nDISCLAIMER DE RESPONSABILIDAD'
            '\n'
            '\nEl programa DisPi, no se responsabiliza por un mal diseño de los elementos de '
            '\nla conformación del micropilote, ni por las malas prácticas, deficiente calidad'
            '\nde los materiales o poca ética profesional del diseñador, este software solo '
            '\nagrupa la información y la presenta al usuario para tomar decisiones de diseño.'
            '\n'
            '\nDisPi ni su creador nunca se considerarán un referente de diseño y sus cálculos'
            '\nestán fundamentados en la Publication No. FHWA NHI-05-039 December 2005 de la'
            '\nNational Highway Institute, por lo tanto el diseño debe ajustarse a las normas '
            '\nlocales de sismoresistencia, ya que este software esta enfocado en la NSR-10.'
            '\n'
            '\n////////DisPi ES UN SOFTWARE GRATUITO, NO SE DEJE ENGAÑAR.///////////'
            '\n////DisPi NO SE RESPONSABILIZA POR EL MAL USO DE SU SOFTWARE.///////'
        ,
        PdfStandardFont(PdfFontFamily.timesRoman, 16, style: PdfFontStyle.italic),
        bounds: const Rect.fromLTWH(0, 200, 600,600)
    );

    document.pages.add().graphics.drawString(
        'CONSIDERACIONES Y RECOMENDACIONES'
            '\n'
            '\n* Es deber del diseñador, conocer toda la información de los datos geotécnicos'
            '\nde la zona, de lo contrario, el diseño no se ajustará a las condiciones dadas '
            '\ndel mismo terreno en estudio.'
            '\n'
            '\n* Se recomienda tomar la longitud de camisa, desde el fondo de la cimentación'
            '\nhasta el inicio del estrato de mejor capacida más un metro para que la '
            '\ncamisa se afiance sobre este estrato y evitar problemas de licuación en el'
            '\nmicropilote por encima del estrato de mejor capacidad.'
            '\n'
            '\n* Para los cálculos efectuados por el programa, no se han considerado pérdidas'
            '\nde sección por efectos de la corrosión en los micropilotes, por lo tanto el'
            '\ndiseñador debe asegurar una protección contra la corrosión o en su defecto'
            '\nrealizar una estudio de suelos potencialmente corrosivos y realizar un '
            '\nanálisis detallado, considerando los parámetros dados en FHWA-NHI-05-042.'
            '\n'
            '\n* Para el cálculo de a, o el coeficiente grout-to-ground, no se tomó en'
            '\nconsideración si hay más estratos en donde estará el tramo del micropilote'
            '\npor lo que el diseñador debe con base en su experiencia, decidir si hacer '
            '\nuso del estrato menos favorable, o considerar el estrato que tenga mayor '
            '\npresencia y utilizar un mayor factor de seguridad.'
            '\n'
            '\n* Se deben realizar las pruebas de cargas sobre los micropilotes para '
            '\ncorroborar los resultados obtenidos a través de los cálculos.'
            '\n'
            '\n* Se debe de socializar el proyecto, con un asesor de ventas del producto'
            '\nen este caso de la empresa DiwyDag, el cual aprobará y dará un segundo'
            '\nconcepto acerca del diseño, el presupuesto y la disponibilidad de los'
            '\nmateriales. En caso de cambiar algún parámetro, se debe reajustar el'
            '\ndiseño del micropilote, pero nunca dejarlo diferente al proyectado.'
        ,
        PdfStandardFont(PdfFontFamily.timesRoman, 16, style: PdfFontStyle.italic)
    );
    document.pages.add().graphics.drawString(
        'ANEXOS Y REFERENCIAS'
        ,
        PdfStandardFont(PdfFontFamily.timesRoman, 16, style: PdfFontStyle.italic)
    );
    document.pages[11].graphics.drawImage(
        PdfBitmap(await _readImageTable('pbarras.png')),
        const Rect.fromLTWH(0, 20, 510, 592)
    );

    document.pages.add().graphics.drawImage(
        PdfBitmap(await _readImageTable('prosca1.png')),
        const Rect.fromLTWH(0, 20, 510, 600)
    );

    document.pages.add().graphics.drawImage(
        PdfBitmap(await _readImageTable('prosca2.png')),
        const Rect.fromLTWH(0, 20, 510, 600)
    );
    document.pages.add().graphics.drawImage(
        PdfBitmap(await _readImageTable('pplaca.png')),
        const Rect.fromLTWH(0, 20, 510, 300)
    );
    document.pages.add().graphics.drawImage(
        PdfBitmap(await _readImageTable('gtga.png')),
        const Rect.fromLTWH(0, 20, 510, 600)
    );

    List<int> bytes = await document.save(); //cuidado que aca metio esta mmada del await
    document.dispose();

    saveAndLaunchFile(bytes, '${dateAndTimeField.date}.pdf');
  }
}
//Imagenes en PDF
//Este metodo convierte los datos de la captura para que los lea el pdf
Future<Uint8List> _readImageData(Uint8List name) async {
  final data = name;
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}
Future<Uint8List> _readImageTable(String name) async {
  final data = await rootBundle.load('imagenes/tablas/$name');
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}
//esta metodo guarda y lanza el archivo
Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
  final path = (await getExternalStorageDirectory())!.path;
  final file = File('$path/$fileName');
  await file.writeAsBytes(bytes, flush: true);
  OpenFile.open('$path/$fileName');
}