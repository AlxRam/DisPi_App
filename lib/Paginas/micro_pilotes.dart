import 'dart:typed_data';
import 'dart:ui';

import 'package:esfuerzos/Paginas/graficas.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:collection/collection.dart'; //Para sumar listas
import 'package:screenshot/screenshot.dart'; //Para tomar capturas
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';

//Provider
class Datos with ChangeNotifier {
  String tlec = 'Tipo Grout';
  String nbar = 'Tipo barra';
  String nbro = '';
  String dbro = '';
  String estra = '';
  double fs = 0;
  double abond = 0;
  List _datos = [' '];
  List<String> esgua = []; //revisar si no  mueren
  List<double> algua = [];
  List<double> zgua = [];
  // List guardado = [' '];
  int ne = 0;

  List get datos => _datos;

  set datos(List value){
    _datos = value;
    notifyListeners();
  }
  //espacios en numeros repetidos para no dañar la seleccion
  // siempre debe ir el ' '
  //Limos y arcillas blandas
  void goLimBla () {
    switch (tlec) {
      case 'Tipo A':
        _datos = [' ', '35', '52.5', '70'];
        break;
      case 'Tipo B':
        _datos = [' ', '35', '65', '95'];
        break;
      case 'Tipo C':
        _datos = [' ', '50', '85', '120'];
        break;
      case 'Tipo D':
        _datos = [' ', '50', '97.5', '145'];
        break;
    }
    nbro = 'CD-D-HD';
    dbro = 'Apto para arenas sueltas o incluso gravas';
    notifyListeners();
  }
  //Limos y Arcillas Duras
  void goLimDur () {
    switch (tlec) {
      case 'Tipo A':
        _datos = [' ', '50', '85', '120'];
        break;
      case 'Tipo B':
        _datos = [' ', '70', '130', '190'];
        break;
      case 'Tipo C':
        _datos = [' ', '95', '142.5', '190'];
        break;
      case 'Tipo D':
        _datos = [' ', '95', '142.5', '190'];
        break;
    }
    nbro = 'CD-D-HD';
    dbro = 'Apto para arenas sueltas o incluso gravas';
    notifyListeners();
  }
  //Arenas Finas
  void goAreFin () {
    switch (tlec) {
      case 'Tipo A':
        _datos = [' ', '70 ', '107.5', '145'];
        break;
      case 'Tipo B':
        _datos = [' ', '70 ', '130 ', '190 '];
        break;
      case 'Tipo C':
        _datos = [' ', '95 ', '142.5 ', '190 '];
        break;
      case 'Tipo D':
        _datos = [' ', '95 ', '167.5', '240'];
        break;
    }
    nbro = 'TSB-D-R';
    dbro = 'Apto para suelos gruesos y rellenos';
    notifyListeners();
  }
  //Arenas Gruesas
  void goAreGru () {
    switch (tlec) {
      case 'Tipo A':
        _datos = [' ', '95', '155', '215'];
        break;
      case 'Tipo B':
        _datos = [' ', '120', '240', '360'];
        break;
      case 'Tipo C':
        _datos = [' ', '145', '252.5', '360'];
        break;
      case 'Tipo D':
        _datos = [' ', '145', '265', '385'];
        break;
    }
    nbro = 'TSB-D-R';
    dbro = 'Apto para suelos gruesos y rellenos';
    notifyListeners();
  }
  //Gravas
  void goGra () {
    switch (tlec) {
      case 'Tipo A':
        _datos = [' ', '95 ', '180', '265'];
        break;
      case 'Tipo B':
        _datos = [' ', '120 ', '240 ', '360 '];
        break;
      case 'Tipo C':
        _datos = [' ', '145 ', '252.5 ', '360 '];
        break;
      case 'Tipo D':
        _datos = [' ', '145 ', '265 ', '385 '];
        break;
    }
    nbro = 'AR-D-HD';
    dbro = 'Apto para rellenos, gravas y suelos fracturados';
    notifyListeners();
  }
  //Depositos Glaciales
  void goDepGla () {
    switch (tlec) {
      case 'Tipo A':
        _datos = [' ', '95  ', '142.5', '190'];
        break;
      case 'Tipo B':
        _datos = [' ', '95 ', '202.5', '310'];
        break;
      case 'Tipo C':
        _datos = [' ', '120 ', '215', '310'];
        break;
      case 'Tipo D':
        _datos = [' ', '120', '227.5', '335'];
        break;
    }
    nbro = 'AR-D-HD';
    dbro = 'Apto para rellenos, gravas y suelos fracturados';
    notifyListeners();
  }
  //Lutitas Blandas
  void goLutBla () {
    switch (tlec) {
      case 'Tipo A':
        _datos = [' ', '205', '377.5', '550'];
        break;
      default:
        _datos = [' '];
        break;
    }
    nbro = 'AR-D-HD';
    dbro = 'Apto para rellenos, gravas y suelos fracturados';
    notifyListeners();
  }
  //Pizarras y Lutitas Duras
  void goLutDur () {
    switch (tlec) {
      case 'Tipo A':
        _datos = [' ', '515', '947.5', '1380'];
        break;
      default:
        _datos = [' '];
        break;
    }
    nbro = 'BB-D-HD';
    dbro = 'Apto para suelos fracturados, calizas y areniscas';
    notifyListeners();
  }
  //Calizas
  void goCal () {
    switch (tlec) {
      case 'Tipo A':
        _datos = [' ', '1035', '1552.5', '2070'];
        break;
      default:
        _datos = [' '];
        break;
    }
    nbro = 'BB-D-HD';
    dbro = 'Apto para suelos fracturados, calizas y areniscas';
    notifyListeners();
  }
  //Areniscas
  void goAre () {
    switch (tlec) {
      case 'Tipo A':
        _datos = [' ', '520', '1122.5', '1725'];
        break;
      default:
        _datos = [' '];
        break;
    }
    nbro = 'AB-D-HD';
    dbro = 'Apto para suelos fracturados, calizas y areniscas';
    notifyListeners();
  }
  //Granito y Basalto
  void goGraBas () {
    switch (tlec) {
      case 'Tipo A':
        _datos = [' ', '1380 ', '2790', '4200'];
        break;
      default:
        _datos = [' '];
        break;
    }
    nbro = 'AB-D-HD';
    dbro = 'Apto para suelos fracturados, calizas y areniscas';
    notifyListeners();
  }
}

class IniciaCalMicro extends StatelessWidget {
  const IniciaCalMicro({Key? key}) : super(key: key);
//Aca es importante que este inicializado el provider
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Datos>(
      create: (context) => Datos(),
      child: CalMicropilote(),
    );
  }
}

class CalMicropilote extends StatefulWidget {
  const CalMicropilote({Key? key}) : super(key: key);

  @override
  _CalMicropiloteState createState() => _CalMicropiloteState();
}

class _CalMicropiloteState extends State<CalMicropilote> {
  final GlobalKey<FormState> kkey = GlobalKey<FormState>();
  int a=1;
  int nEst=1;
  List <double> res = []; //revisar si este y el de abajo no mueren
  List <String> desSuel = ['0.Limos y arcillo Blandas', '1.Limos y arcillas Duras', '2.Arenas finas',
    '3.Arenas gruesas', '4.Gravas', '5.Depositos Glaciales', '6.Lutitas Blandas',
    '7.Pizarras y lutitas Duras', '8.Calizas', '9.Areniscas', '10.Granito y Basallto'];
  String nsuel =  'Tipo Suelo';
  List <String> tipoBar = ['R32-210','R32-250','R32-280','R32-320','R32-360','R32-400','R38-420',
    'R38-500','R38-550','R51-550','R51-660','R51-800','T76-1200','T76-1600','T76-1900'];
  List <String> fs = ['2', '2.5', '3'];
  String nbar =  'Tipo Barra'; //revisar si permanece
  List <String> tipoLec = ['Tipo A', 'Tipo B', 'Tipo C', 'Tipo D'];
  String nlec =  'Tipo Lechada'; //revisar
  List<double> val = [];
  //Propiedades barra
  List <double> ab = [340,370,410,470,510,560,660,750,800,890,970,1150,1610,1990,2360];
  List <double> cy = [160,190,220,250,280,330,350,400,450,450,540,640,1000,1200,1500];
  List <double> cu = [210,250,280,320,360,400,420,500,550,550,660,800,1200,1600,1900];
  List <double> fy = [470,510,540,530,550,590,530,530,560,510,560,560,625,600,640];
  List <double> fu = [620,680,680,680,710,710,640,670,690,620,680,700,750,800,810];
  @override
  Widget build(BuildContext context) {
    //Va despues del build para estar a la par de la jerarquia y usar el provider
    final datos = Provider.of<Datos>(context);
    //Se usa uno aca, ya que varios comparten esta cara
    final decora = BoxDecoration(color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: Colors.black38,
        width: 1,
      )
    );
    return Form(
      key: kkey,
      child: Scaffold(
        appBar: AppBar(
            actions: [IconButton(
                icon: const Icon(Icons.help_outline, size: 35, color: Color(0xFF590E11)),
                onPressed: _ayuda
            )
            ],
            title: const Center(child: Text('Ingreso Datos'))
        ),
        backgroundColor: const Color(0xFFE7E7E7),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(11),
            // padding: const EdgeInsets.only(top: 12),
            child: Column(
              children: [
                Container(
                  decoration: decora,
                  width: MediaQuery.of(context).size.width*.95,
                  height: 180,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween, //around
                         children: [
                           Text('  -Cargas en Micropilote', style: TextStyle(fontSize: 23.5, fontFamily: 'ubuntub')),
                           jelp(1)
                         ],
                       ),
                      nform('Carga a Compresión', 'ᴾc (kN)'),
                      nform('Carga a Tensión', 'ᴾt (kN)')
                    ]
                  )
                ),
                const SizedBox(height: 13),
                Container(
                    decoration: decora,
                    width: MediaQuery.of(context).size.width*.95,
                    height: 360,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('  -Acero de Refuerzo', style: TextStyle(fontSize: 23.5, fontFamily: 'ubuntub')),
                              jelp(2)
                            ]
                          ),
                          nbarras('Especificación de la barra', tipoBar),
                          nform('Diámetro externo encamisado', 'OD (mm)'),
                          nform('Espesor encamisado', 'ᵗw (mm)'),
                          nform('Resistencia a fluencia encamisado', 'Fᵧₛ (MPa)'),
                          nform('Longitud encamisado', 'Lᵤₚ (m)')
                        ]
                    )
                ),
                const SizedBox(height: 13),
                Container(
                    decoration: decora,
                    width: MediaQuery.of(context).size.width*.95,
                    height: 250,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('  -Lechada', style: TextStyle(fontSize: 23.5, fontFamily: 'ubuntub')),
                              jelp(3)
                            ]
                          ),
                          nlechada('Tipo de lechada', tipoLec),
                          nform('Resistencia a compresión lechada', "f 'c (MPa)"),
                          nform('Diámetro vaciado lechada', 'D (mm)')
                        ]
                    )
                ),
                const SizedBox(height: 13),
                Container(
                    decoration: decora,
                    width: MediaQuery.of(context).size.width*.95,
                    height: 120,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('  -Platina', style: TextStyle(fontSize: 23.5, fontFamily: 'ubuntub')),
                              jelp(4)
                            ]
                          ),
                          nform('Longitud', 'a (mm)')
                        ]
                    )
                ),
                const SizedBox(height: 13),
                Container(
                    decoration: decora,
                    width: MediaQuery.of(context).size.width*.95,
                    height: 220,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('  -Suelo', style: TextStyle(fontSize: 23.5, fontFamily: 'ubuntub')),
                              jelp(5)
                            ]
                          ),
                          DroplistDatos('Tipo suelo'),
                          nfsegu('Factor de Seguridad', fs)
                          // DroplistAlf(datos._datos),
                          // nform('Coeficiente ground to grout estrato', 'α (mm)'),
                          //revisar los estratos y meter aca los droplist para hacer el calculo
                        ]
                    )
                ),
                const SizedBox(height: 13),
                ElevatedButton.icon(
                    onPressed: _call,
                    label: const Text('Calcular', style: TextStyle(fontSize: 18)),
                    icon: const Icon(Icons.calculate_outlined, size: 30),
                    style: ElevatedButton.styleFrom(primary: Color(0xFFA72026))
                ),
              /*
              label: const Text('Reporte', style: TextStyle(fontSize: 18)),
                          icon: const Icon(Icons.picture_as_pdf_outlined, size: 30),
                          style: ElevatedButton.styleFrom(primary: Color(0xFFA72026))
               */

                //revisar si esto en adelante muere
                // barraPilote(),
                // seccionPilote(),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: ListView.builder(
                //       shrinkWrap: true,
                //       itemCount: nEst ,
                //       itemBuilder: (BuildContext context,int index){
                //         return estrato();
                //       }
                //   ),
                // ),
                // SizedBox(height: 150)
              ],
            ),
          ),
        ),
        //los dos botones de mierd aque estorban
        // floatingActionButton: Row(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   children: [
        //     FloatingActionButton(onPressed: _suma, child: Icon(Icons.add),heroTag: 'suma',),
        //     SizedBox.fromSize(size: Size.fromRadius(5)),
        //     FloatingActionButton(onPressed: _call, child: Icon(Icons.calculate),heroTag: 'resta',),
        //   ],
        // ),
      ),
    );
  }
//Nombre y form
  Row nform(String nombe, String hin){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width:MediaQuery.of(context).size.width*.45,
          child: Text(nombe)
        ),
        Container(
          width:MediaQuery.of(context).size.width*.30,
          child: entrada(hin),
        ),
      ],
    );
  }
//listas tipo barras
  Row nbarras(String nombe, List<String> lista ){
    final datos = Provider.of<Datos>(context);
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
            width:MediaQuery.of(context).size.width*.45,
            child: Text(nombe)
        ),
        Container(
          width:MediaQuery.of(context).size.width*.30,
          child: DropdownButton(
            isExpanded: true,
            onChanged: (value) {
              setState(() {
                datos.nbar = value as String;
                // nbar = value as String;
              });
            },
            items: lista.map((String a) {
            // items: tipoBar.map((String a) {
              return DropdownMenuItem(
                  value: a,
                  child: Text(a));
            }).toList(),
            hint: Text(datos.nbar),
            // hint: Text(nbar),
          ),
        ),
      ],
    );
  }
//listas tipo lechada
  Row nlechada(String nombe, List<String> lista ){
    final datos = Provider.of<Datos>(context);
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
            width:MediaQuery.of(context).size.width*.45,
            child: Text(nombe)
        ),
        Container(
          width:MediaQuery.of(context).size.width*.30,
          child: DropdownButton(
            isExpanded: true,
            onChanged: (value) {
              setState(() {
                datos.tlec = value as String;
              });
            },
            items:
            lista.map((String a) {
              return DropdownMenuItem(
                  value: a,
                  child: Text(a));
            }).toList(),
            hint: Text(datos.tlec),
          ),
        ),
      ],
    );
  }
//listas factor seguridad
  Row nfsegu(String nombe, List<String> lista ){
    final datos = Provider.of<Datos>(context);
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
            width:MediaQuery.of(context).size.width*.45,
            child: Text(nombe)
        ),
        Container(
          width:MediaQuery.of(context).size.width*.30,
          child: DropdownButton(
            isExpanded: true,
            onChanged: (value) {
              setState(() {
                datos.fs = double.parse(value.toString()); //mire este truco perrazo jaja
              });
            },
            items: lista.map((String a) {
              return DropdownMenuItem(
                  value: a,
                  child: Text(a));
            }).toList(),
            hint: Text(datos.fs.toString()),
          ),
        ),
      ],
    );
  }
//Imagenes
  Row barraPilote() {
    return Row(
        children: [
          Container(
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage('imagenes/pilotes/m.png')),
              ),
              height: 520,
              width: 240,
          ),
          Container(
              height: 520,
              width: 155,
              child: Column (
                children: [
                  entrada('Pc'),
                  entrada('Pt'),
                  const SizedBox(height: 70,),
                  entrada('OD'),
                  entrada('tw'),
                  entrada('Fyc'),
                  const SizedBox(height: 75,),
                  DropdownButton(
                    isExpanded: true,
                    onChanged: (value) {
                      setState(() {
                        nbar = value as String;
                      });
                    },
                    items: tipoBar.map((String a) {
                      return DropdownMenuItem(
                          value: a,
                          child: Text(a));
                    }).toList(),
                    hint: Text(nbar),
                  ),
                ],
              ),
          )
        ]
    );
  }

  Row seccionPilote() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('imagenes/pilotes/s.png')),
            ),
            height: 220,
            width: 220,
          ),
          Container(
            height: 185,
            width: 150,
            child: Column (
              children: [
                entrada('D'),
                DropdownButton(
                  isExpanded: true,
                  onChanged: (value) {
                    setState(() {
                      nlec = value as String;
                    });
                  },
                  items: tipoLec.map((String a) {
                    return DropdownMenuItem(
                        value: a,
                        child: Text(a));
                  }).toList(),
                  hint: Text(nlec),
                ),
                entrada("f'c"),
              ],
            ),
          )
        ]
    );
  }
  Row estrato() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('imagenes/pilotes/e.png')),
            ),
            height: 140,
            width: 270,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(85,45,45,5),
              child: DropdownButton(
                isExpanded: true,
                onChanged: (value) {
                  setState(() {
                    nsuel = value as String;
                  });
                },
                items: desSuel.map((String a) {
                  return DropdownMenuItem(
                      value: a,
                      child: Text(a));
                }).toList(),
                hint: Text(nsuel),
              ),
            ),
          ),
          Container(
            // height: 185,
            width: 60,
            child: entrada('Mts'),
          )
        ]
    );
  }
  // Este valida el key anterior
  void _valida() {
    final form = kkey.currentState!;
    if (form.validate()) {
      setState(() => form.save()
      );
    }
  }
  void _suma() {
    final form = kkey.currentState!;
    final datos = Provider.of<Datos>(context, listen: false);
    // if (form.validate()) {
    //   setState(() => a++
    // setState(() => nEst++  //para hacer pruebas
    setState(() => print(datos.algua)
    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => TablaDatos())
    );


  }

  void _resta() {
    final form = kkey.currentState!;
    if (a>1) {
      setState(() => a--
      );
    }

  }

  void _ayuda(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ayudaOculta()));
  }

  void _call() {
    final datos = Provider.of<Datos>(context, listen: false);
    final form = kkey.currentState!;

    setState(() {
      form.save(); //guarda valores formulario
      //declara variables
      int i = tipoBar.indexWhere((element) => element == datos.nbar); //Asigna posicion de la barra
      double ac = (pi/4)*(pow(val[2],2)-pow((val[2]-2*val[3]),2));
      double eg = 4732*sqrt(val[6]);
      double agc = ((pi/4)*pow((val[2]-2*val[3]),2))-ab[i];
      double aguc = ((pi/4)*pow(val[7],2))-ab[i];
      double dp = 0;
      double db = 0;
      double tp = 0;
      //diametro de perforacion segun posicion barra
      if (i<6){
        dp = 35;
        db = 46;
        tp = 20;
      }
      else if (i<9){
        dp = 41;
        db = 55;
        tp = 30;
      }
      else if (i<12){
        dp = 60;
        db = 75;
        tp = 35;
      }
      else if (i<15){
        dp = 85;
        db = 101;
        tp = 40;
      }
      double ar = pow(val[8], 2).toDouble(); //revise si el hpta sirve
      double a1 = ar-(pow(db, 2)*(pi/4));
      double a2 = ar-(pow(dp, 2)*(pi/4));
      print (val);
      //lo que debe de recibir
      //Pc,Pt,tbar,Cu,Cy,Fyb,Fub,Ab,Es,OD,tw,Fyc,Ac,Lup,fc,Eg,D,Agc,Aguc,tlec,dp,db,a,A,A1,A2,abond,FS, estra
      disenoMicro (val[0],val[1], tipoBar.indexWhere((element) => element == datos.nbar),val[2],val[3],val[4],val[6],val[5],[0,12.5],[0,2]);//,[0,eje[7]], [0,desSuel.indexWhere((element) => element == nsuel)]);
      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => TablaDatos(res)));
      Navigator.of(context).push(MaterialPageRoute(
          //receptor de datos si sirve
          builder: (context) => ResultadosMic(val[0],val[1],datos.nbar,cu[i],cy[i],fy[i],fu[i],ab[i],200000,val[2],
              val[3],val[4],ac,val[5],val[6],eg,val[7],agc,aguc,datos.tlec,dp,db,val[8],ar,a1,a2,datos.abond,datos.fs,datos.estra,tp,datos.nbro,datos.dbro)));
          //prueba para hacer
      //     builder: (context) => ResultadosMic(595,0,'R51-800',800,640,560,700,1150,200000,141,
      //         9.5,241,3924.63,4.6,34.5,27794.21,191,9632.67,27502.11,'Tipo B',60,75,250,62500,58082.13,59672.57,265,2,'Limos y arcillas')));
      // print('${val[0]}${val[1]}${datos.nbar}${cu[i]}${cy[i]}${fy[i]}${fu[i]}${ab[i]}200000${val[2]}${val[3]}${val[4]}$ac${val[5]}${val[6]}$eg${val[7]}$agc$aguc${datos.tlec}$dp$db${val[8]}$ar$a1$a2${datos.abond}${datos.fs}${datos.estra}');

      // print (res);
      // print (tipoBar.indexWhere((element) => element == datos.nbar));
    });

    // if (a>1) {
    //   setState(() => a--
    //   );
    // }

  }

  //Ex-Ayuda para usuario ahora sirve para testear
  ayudaOculta() {
    return Scaffold(
        appBar: AppBar(
          title: const Text ('Ayuda'),
        ),
        backgroundColor: const Color(0xFFE7E7E7),
        body: Padding(
          padding: const EdgeInsets.all(11.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                decoration:BoxDecoration(color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black38,
                      width: 1,
                    )
                ),
                width: MediaQuery.of(context).size.width*.95,
                height:MediaQuery.of(context).size.height*.75,
                child: Column(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width*.85,
                        height:MediaQuery.of(context).size.height*.70,
                        decoration: const BoxDecoration(
                            image: DecorationImage(image: AssetImage('imagenes/contacto/mientras.png'))
                        )
                    ),
                    const Center(
                      child: Text('Deberias estar acá?'),
                    )
                  ]
                )
              ),
              ElevatedButton(onPressed: prueba, child: Text('Ejemplo de diseño'),style: ElevatedButton.styleFrom(primary: Color(0xFFA72026)))
            ],
          ),
        )
    );
  }

  //info para secciones
  jelp(int tipo) {
    return GestureDetector(
      child: const Padding(
        padding: EdgeInsets.only(right: 12),
        child: Icon(
            Icons.question_mark_rounded,
            color: Colors.grey,
        ),
      ),
      onTap: (){
        switch(tipo) {
          case 1 :
            showDialog(
                context: context,
                builder: (context)=>const AlertDialog(
                  title: Text('INFO CARGAS'),
                  content: Text(
                      'Las cargas en el micropilote, deberán ser ingresadas por el usuario, bien haciendo uso de avaluó de cargas '
                      'por medio de la AASHTO LRFD Bridge Design Specifications, o bien empleando algún otro método válido para las '
                      'normas locales, debidamente referenciado en la memoria de cálculo.'
                  )
                )
            );
            break;
          case 2 :
            showDialog(
                context: context,
                builder: (context)=>const AlertDialog(
                  title: Text('INFO ACERO'),
                  content: SingleChildScrollView(
                    child: Text(
                      'El acero de se compone de dos partes, por un lado, la barra autoperforante DYWI® Drill, las cuales '
                      'se encuentran entre las referencias R25 - R51 y T76, que son las referencias comerciales más usadas en'
                      ' Colombia, la cual deberá seleccionar el usuario según los requerimientos estructurales del '
                      'micropilote.\n\nPor otro lado, se encuentra el encamisado, que se compone de un tubo metálico con un '
                      'diámetro externo y un espesor que varía según la zona donde se construirá, de igual manera, muchas '
                      'camisas son grado 60 o grado 50, sin embargo, se recomienda trabajar con camisas grado 35 lo que '
                      'equivalen a 241 MPa, o la resistencia que diga la ficha técnica.'
                    )
                  )
                )
            );
            break;
          case 3 :
            showDialog(
                context: context,
                builder: (context)=>AlertDialog(
                  title: const Text('INFO LECHADA'),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Text(
                            'La lechada la deberá considerar el usuario, la cual dependerá de las propiedades del suelo y el presupuesto'
                            ' del proyecto, sin embargo, se debe tener en cuenta lo siguiente:\n\n'
                            'Tipo A, se construyen colocando un mortero de arena y cemento o una lechada de cemento puro en el micropilote bajo un cabezal de gravedad solamente.\n\n'
                            'Tipo B, se construyen mediante la inyección de una lechada de cemento pura bajo presión (típicamente 6–21 kip/ft²) '
                            'en el orificio perforado mientras se retira la tubería de perforación temporal o la barrena.\n\n'
                            'Tipo C, se inyectan como el tipo A, seguidos de 15 a 25 minutos después de la inyección primaria mediante la inyección de '
                            'lechada adicional bajo presión (generalmente superior a 21 kip/ft²) a través de una tubería de lechada con manguito colocada previamente.\n\n'
                            'Tipo D, se inyectan de forma similar a los del tipo C, pero se permite que la lechada primaria se endurezca antes de inyectar'
                            ' la lechada secundaria bajo presión (típicamente 42–170 kip/ft²) con un empacador para lograr el tratamiento de intervalos de pilotes específicos o horizonte del material.'
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width*.75,
                            height:MediaQuery.of(context).size.height*.5,
                            decoration: const BoxDecoration(
                                image: DecorationImage(image: AssetImage('imagenes/tablas/lecha.png'))
                            )
                        ),
                        const Text('Clasificación de micropilotes por tipo de lechada. Tomado de (Sabatini et al., 2005).\n\n',textScaleFactor: 0.7),
                        const Text(
                            'La lechada comúnmente tiene altas resistencias a la compresión como 4000 psi o 28 MPa, pero se recomienda no usar una resistencia a la'
                            ' compresión de menor capacidad, y el diámetro de vaciado, será la estimación del cuerpo de la lechada que se generará al vaciar la lechada.'
                        )
                      ]
                    )
                  )
                )
            );
            break;
          case 4 :
            showDialog(
                context: context,
                builder: (context)=>const AlertDialog(
                  title: Text('INFO PLATINA'),
                  content: Text(
                      'La platina, sobre la cual se conectará el micropilote con la zapata o será el cabezal del micropilote, se diseñará por '
                      'aplastamiento, por lo que el fabricante DSI, recomienda unas dimensiones mínimas en la platina, las cuales son de calibres de platina '
                      'que van desde 1” y varían en función de la barra que se emplea, y dimensiones de 200 mm de lado y lado en la platina, se recomienda usar dimensiones mínimas de 250 mm por lado y lado.'
                  )
                )
            );
            break;
          case 5 :
            showDialog(
                context: context,
                builder: (context)=>const AlertDialog(
                  title: Text('INFO SUELO'),
                  content: SingleChildScrollView(
                    child: Text(
                      'El suelo es la parte importante para definir la capacidad geotécnica, por lo que se debe de contar con la información geotécnica'
                      ' del suelo y la estimación sobre el tipo de suelo al que estará en contacto con el pilote, la publicación'
                      ' FHWA NHI-05-039, propone unos tipos de suelos que se anexan en la memoria de cálculo.\n\n'
                      'El coeficiente a grout to ground, varía según el tipo de lechada que se seleccione, de igual manera el manual propone hacer uso '
                      'de tres valores, que componen el valor mínimo, intermedio y máximo del coeficiente, el cual deberá de seleccionar el usuario según lo considere.\n\n'
                      'Con el factor de seguridad, el usuario puede también seleccionarlo a su consideración, generalmente, se recomienda hacer uso de un factor de seguridad de 2.0, '
                      'en caso de desconfiar del estudio de suelos, poseer suelos potencialmente licuables, suelos expansivos o suelos con rocas débiles, se puede usar 2.5 y'
                      ' en condiciones totalmente extremas o lo anterior confirmado, se puede usar un factor de seguridad 3.0.'
                    )
                  )
                )
            );
            break;
        }
      }
    );
  }

  //prueba
  void prueba() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ResultadosMic(595,100,'R51-800',800,640,560,700,1150,200000,141,
            9.5,241,3924.63,4.6,34.5,27794.21,191,9632.67,27502.11,'Tipo B',60,75,250,62500,58082.13,59672.57,265,2,'Pizarras Duras',35,'BB-D-HD','Apto para suelos fracturados, calizas y areniscas')));
  }
  //inputs de formatos
  entrada(String hint){
    return TextFormField(
      validator: (String? value) { //Esta valida que no este vacio
        if (value == null || value.isEmpty) {
          return 'Campo requerido'; //campo en caso de que este vacio
        }
        return null;
      },
      onSaved: (value) => val.add(double.parse(value!)), //Aca guarda el valor
      decoration: InputDecoration(
        hintText: hint,
      ),
      keyboardType: TextInputType.number,
    );
  }
  //REVISAR SI AL FINAL QUEDA SIRVIENDO
  //REALIZA CALCULOS PARA DISEÑO
  disenoMicro (double pc,pt, int i,double od,tw,fyc,fc,dg,List <double> le, List <int> alf) {
    //TAMBIEN ACA, REVIS TEMA DEL INGRESO DE ESTRATOS
    //Propiedades barra
    List <double> ab = [340,370,410,470,510,560,660,750,800,890,970,1150,1610,1990,2360];
    List <double> fy = [470,510,540,530,550,590,530,530,560,510,560,560,625,600,640];
    List <double> fu = [620,680,680,680,710,710,640,670,690,620,680,700,750,800,810];
    //Geotecnico
    List <double> tipoA=[70,120,145,215,265,190,550,1380,2070,1725,4200,0]; //cero final para cancelar
    //Calculos
    double ac = (pi/4)*(pow(od,2)-pow((od-2*tw),2));
    double agc = ((pi/4)*pow((od-2*tw),2))-ab[i];
    double aguc = ((pi/4)*pow(dg,2))-ab[i];
    double pca = 0.4*agc*fc+0.47*fy[i]*(ac+ab[i]);
    double psca = 0.4*aguc*fc+0.47*fy[i]*ab[i];
    double ptp = 0.6*ab[i]*fu[i];
    List <double> pg = [];
    //MIRE COMO MEJORA ESTE PEEDACITO
    for(int j = 0;j!=le.length;j++){
      pg.add((tipoA[alf[j]]/2)*pi*dg*le[j]);
    }
//   pg.sum;
//   print ('Diametro barra ${tipoBar[i]} \nFy ${fy[i]} \nFu ${fu[i]}');
    print ('\nCalculos');
    //divido por 1000 para visualisar k
    print ('P encamisado ${pca/1000} \nPsin camisa ${psca/1000} \nCarga tension ${ptp/1000} \nCarga geotecnica ${pg.sum/1000}');

    //esto es para un return que pinte los resultados
    res.add(pca/1000);
    res.add(psca/1000);
    res.add(ptp/1000);
    res.add(pg.sum/1000);
    return res;
  }

}
//Droplist de los estratos y alfa
class DroplistDatos extends StatefulWidget {
  String nombe;
  DroplistDatos(this.nombe, {Key? key}) : super(key: key);

  @override
  _DroplistDatosState createState() => _DroplistDatosState();
}

class _DroplistDatosState extends State<DroplistDatos> {
  List selec = [' ','Limos y Arcillas Blandas','Limos y Arcillas Duras', 'Arenas finas',
    'Arenas gruesas', 'Gravas', 'Depositos Glaciales', 'Lutitas Blandas',
    'Pizarras y Lutitas Duras', 'Calizas', 'Areniscas', 'Granito y Basallto'];

  String initial = ' ';
  List temp = [];
  List<double> eje = [];

  @override
  Widget build(BuildContext context) {
    final datos = Provider.of<Datos>(context,listen: false);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width:MediaQuery.of(context).size.width*.45,
              child: Text(widget.nombe)
            ),
            Container(
              width:MediaQuery.of(context).size.width*.30,
              child: DropdownButton(
                  isExpanded: true,//sin esto no se acomoda en la lista
                  value: initial,
                  //Aca recibe los valores y los pasa al map
                  items: selec.map((value){ //datos se mete al list
                    return DropdownMenuItem(
                      child: new Text(value),
                      value:value,
                    );
                  }).toList(),
                  onChanged: (value) {
                    value.toString() == 'Limos y Arcillas Blandas' ?datos.goLimBla() :null;
                    value.toString() == 'Limos y Arcillas Duras' ?datos.goLimDur() :null;
                    value.toString() == 'Arenas finas' ?datos.goAreFin() :null;
                    value.toString() == 'Arenas gruesas' ?datos.goAreGru() :null;
                    value.toString() == 'Gravas' ?datos.goGra() :null;
                    value.toString() == 'Depositos Glaciales' ?datos.goDepGla() :null;
                    value.toString() == 'Lutitas Blandas' ?datos.goLutBla() :null;
                    value.toString() == 'Pizarras y Lutitas Duras' ?datos.goLutDur() :null;
                    value.toString() == 'Calizas' ?datos.goCal() :null;
                    value.toString() == 'Areniscas' ?datos.goAre() :null;
                    value.toString() == 'Granito y Basallto' ?datos.goGraBas() :null;
                    datos.esgua.add(value.toString()); //revise ese esgua que seria el mismo estra
                    //Añade los datos de entrada y los pasa al widget para que los conserve
                    temp.addAll(datos._datos);
                    setState(() {
                      initial = value.toString();
                      datos.estra = value.toString(); //mire si remplaza el intial aqui
                    });
                  }),
            ),
          ],
        ),
        DroplistAlf(temp)
      ],
    );
  }
}

class DroplistAlf extends StatefulWidget {
  // const dropdowBut({Key? key}) : super(key: key);
  // String initial2 =' ';
  List temp ;
  DroplistAlf(this.temp);

  @override
  _DroplistAlfState createState() => _DroplistAlfState();
}

class _DroplistAlfState extends State<DroplistAlf> {
  String _value = ' ';

  @override
  Widget build(BuildContext context) {
    final datos = Provider.of<Datos>(context,listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
            width:MediaQuery.of(context).size.width*.45,
            child:
            const Text('Coeficiente α ground to grout')
        ),
        Container(
          width:MediaQuery.of(context).size.width*.30,
          child: DropdownButton(
              value: _value,
              //Aca recibe los valores y los pasa al map
              items:
              widget.temp.map((value){ //datos se mete al list
                return DropdownMenuItem(
                  child: new Text(value),
                  value:value,
                );
              }).toList(),
              onChanged: (value) {
                datos.algua.add(double.parse((value.toString()))); //revise si este muere o ka
                datos.abond = double.parse(value.toString());
                setState(() {
                  _value = value.toString();
                });
              }),
        ),
      ],
    );
  }
}
//Revela resultados
//lo que debe de recibir
//Pc,Pt,tbar,Cu,Cy,Fyb,Fub,Ab,Es,OD,tw,Fyc,Ac,Lup,fc,Eg,D,Agc,Aguc,tlec,dp,db,a,A,A1,A2,abond,FS,estra

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
          this.db,this.a,this.ar,this.a1,this.a2,this.abond,this.fs,this.est,this.tp,this.nbro,this.dbro
      );

  @override
  Widget build(BuildContext context) {
    //Va despues del build para estar a la par de la jerarquia y usar el provider
    // final datos = Provider.of<Datos>(context);  //Este daña todo el widget
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
                            Container(
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
                                Container(
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
                                                  Text('          ${lup.toStringAsFixed(2)} m', style: TextStyle(fontFamily: 'cambri', fontSize: 14)),
                                                  const SizedBox(height: 90),
                                                  Text('${(lup+lb).toStringAsFixed(2)} m', style: TextStyle(fontFamily: 'cambri', fontSize: 14)),
                                                  const SizedBox(height: 113),
                                                  Text('          ${lb.toStringAsFixed(2)} m', style: TextStyle(fontFamily: 'cambri', fontSize: 14))
                                                ]
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('   Platina Cuadrada\n ${a.toStringAsFixed(0)} x ${a.toStringAsFixed(0)} x ${tp.toStringAsFixed(0)} mm', style: TextStyle(fontFamily: 'cambri', fontSize: 15)),
                                                  const SizedBox(height: 2),
                                                  Text('  Encamisado\n O.D. = $od mm\n tw = $tw mm', style: TextStyle(fontFamily: 'cambri', fontSize: 14.5)),
                                                  const SizedBox(height: 113),
                                                  Text(est, style: TextStyle(fontFamily: 'cambri', fontSize: 15)),
                                                  const SizedBox(height: 65),
                                                  Text('   Lechada $tlec', style: TextStyle(fontFamily: 'cambri', fontSize: 15)),
                                                  const SizedBox(height: 47),
                                                  Text('   Barra DSI $tbar', style: TextStyle(fontFamily: 'cambri', fontSize: 15)),
                                                  const SizedBox(height: 82),
                                                  Text('   Rosca $nbro', style: TextStyle(fontFamily: 'cambri', fontSize: 15))
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
                                              Text('  Barra DSI $tbar', style: TextStyle(fontFamily: 'cambri', fontSize: 15)),
                                              const SizedBox(height: 33),
                                              Text('  Grout  f\'c  $fc MPa\n  $tlec ', style: TextStyle(fontFamily: 'cambri', fontSize: 15)),
                                              const SizedBox(height: 30),
                                              Text('  Encamisado\n O.D. = $od mm\n tw = $tw mm', style: TextStyle(fontFamily: 'cambri', fontSize: 15))
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
                                              Text('  Barra DSI $tbar', style: TextStyle(fontFamily: 'cambri', fontSize: 15)),
                                              const SizedBox(height: 33),
                                              Text('  Grout  f\'c  $fc MPa\n  $tlec ', style: TextStyle(fontFamily: 'cambri', fontSize: 15)),
                                              const SizedBox(height: 50),
                                              Text('  Cuerpo Grout\n  D = $d mm', style: TextStyle(fontFamily: 'cambri', fontSize: 15))
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
                          style: ElevatedButton.styleFrom(primary: Color(0xFFA72026))
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
        Rect.fromLTWH(70, 35, 340, 450)
    );
    document.pages[4]..graphics.drawString(
        'Todos los valores calculados, deberán de estar encima de la gráfica'
        '\nfalla, dado el caso, de que la grafica calculada este contenida en la'
        '\ngráfica falla, se deberá volver a diseñar el micropilote o en su defecto,'
        '\ncontrolar sus parámetros para obtener los cálculos esperados.'
        '\nSe recomienda a criterio del diseñador, tomar la decisión más adecuada'
        '\nteniendo en cuenta las propiedades del suelo, el presupuesto y la '
        '\nexperiencia que respalde al diseñador.'
        ,
        PdfStandardFont(PdfFontFamily.timesRoman, 16, style: PdfFontStyle.italic),
        bounds :Rect.fromLTWH(0, 485, 600,600)
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
        Rect.fromLTWH(70, 35, 340, 450)
    );
    document.pages[6]..graphics.drawString(
        'Se estiman los valores de los asentamientos provocados por ambas zonas'
        '\ndel micropilote, ya que en cada zona, el comportamiento de los asentamientos'
        '\nserá diferente por las propiedades mécanicas de cada zona.'
        '\nEl asentamiento a evaluar, será el asentamiento total el cual no deberá '
        '\nsuperar 0.3 m según título H.4.9.2 de la NSR-10, en caso de que se los'
        '\nasentamientos superen este valor, se deberá garantizar que  las cargas'
        '\nno superen ese limite o se deberá replantear la longitud del micropilote.'
        ,
        PdfStandardFont(PdfFontFamily.timesRoman, 16, style: PdfFontStyle.italic),
        bounds :Rect.fromLTWH(0, 485, 600,600)
    );

    document.pages.add().graphics.drawString(
        'DETALLES DE DISEÑO',
        PdfStandardFont(PdfFontFamily.timesRoman, 16, style: PdfFontStyle.italic)
    );
    document.pages[7].graphics.drawImage(
        PdfBitmap(await _readImageData(_micro)),
        Rect.fromLTWH(70, 40, 340, 570)
    );

    document.pages.add().graphics.drawImage(
        PdfBitmap(await _readImageData(_secc1)),
        Rect.fromLTWH(0, 10, 520, 240)
    );
    document.pages[8].graphics.drawImage(
        PdfBitmap(await _readImageData(_secc2)),
        Rect.fromLTWH(0, 300, 510, 250)
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
        bounds: Rect.fromLTWH(0, 200, 600,600)
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
        Rect.fromLTWH(0, 20, 510, 592)
    );

    document.pages.add().graphics.drawImage(
        PdfBitmap(await _readImageTable('prosca1.png')),
        Rect.fromLTWH(0, 20, 510, 600)
    );

    document.pages.add().graphics.drawImage(
        PdfBitmap(await _readImageTable('prosca2.png')),
        Rect.fromLTWH(0, 20, 510, 600)
    );
    document.pages.add().graphics.drawImage(
        PdfBitmap(await _readImageTable('pplaca.png')),
        Rect.fromLTWH(0, 20, 510, 300)
    );
    document.pages.add().graphics.drawImage(
        PdfBitmap(await _readImageTable('gtga.png')),
        Rect.fromLTWH(0, 20, 510, 600)
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

// class ayuda extends StatelessWidget {
//   ayuda({Key? key}) : super(key: key);
//   final decora = BoxDecoration(color: Colors.white,
//       borderRadius: BorderRadius.circular(10),
//       border: Border.all(
//         color: Colors.black38,
//         width: 1,
//       )
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text ('Ayuda'),
//         ),
//         backgroundColor: const Color(0xFFE7E7E7),
//         body: Padding(
//           padding: const EdgeInsets.all(11.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Container(
//                   decoration: decora,
//                   width: MediaQuery.of(context).size.width*.95,
//                   height:MediaQuery.of(context).size.height*.85,
//                   child: Center(
//                     child: Text('Manual del usuario \n         en proceso'),
//                 ),
//               ),
//               ElevatedButton(onPressed: null, child: Text('PRUEBA'),style: ElevatedButton.styleFrom(primary: Color(0xFFA72026)))
//             ],
//           ),
//         )
//     );
//   }
// }



//Revise si esta tabla es util o muere despues
//Revela tabla de resultados
class TablaDatos extends StatefulWidget {
  // TablaDatos({Key? key}) : super(key: key);
  final List <String> nList = ['Indicador',"Carga kN/m²",'Condicion'];
  final List <String> nInd = ['Encamisado',"Sin Camisa",'A Tensión','Geotecnica'];
  List <double> res =[];
  TablaDatos(this.res);

  @override
  _TablaDatosState createState() => _TablaDatosState();
}

class _TablaDatosState extends State<TablaDatos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text ('Tabla Resultados'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Table(
                  border: TableBorder.all(),
                  defaultColumnWidth: FixedColumnWidth(120),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                        children: [
                          for (int i = 0; i!=widget.nList.length; i++)
                            Container(
                                height: 30,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(color: Colors.grey),
                                child: Text(widget.nList[i], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                            )
                        ]
                    )
                  ]
              ),
              //Generador de datos
              Table(
                border: TableBorder.all(),
                defaultColumnWidth: FixedColumnWidth(120),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  for (int i = 0; i!=widget.nInd.length; i++) TableRow(
                      decoration: BoxDecoration(color: Colors.white38),
                      children: [
                        // Center(child: Text('0')),
                        Center(child: Text(widget.nInd[i])),
                        Center(child: Text(widget.res[i].toString())),
                        Center(child: Text('CUMPLE'))
                      ]
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}

