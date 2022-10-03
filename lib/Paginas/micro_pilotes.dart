import 'dart:ui';
import 'package:esfuerzos/Paginas/resultados_micropilotes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import 'package:esfuerzos/Modelos/data.dart';


class IniciaCalMicro extends StatelessWidget {
  const IniciaCalMicro({Key? key}) : super(key: key);
//Aca es importante que este inicializado el provider
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Datos>(
      create: (context) => Datos(),
      child: const CalMicropilote(),
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
  List <String> tipoBar = ['R32-210','R32-250','R32-280','R32-320','R32-360','R32-400','R38-420',
    'R38-500','R38-550','R51-550','R51-660','R51-800','T76-1200','T76-1600','T76-1900'];
  List <String> fs = ['2', '2.5', '3'];
  String nbar =  'Tipo Barra'; //revisar si permanece
  List <String> tipoLec = ['Tipo A', 'Tipo B', 'Tipo C', 'Tipo D'];
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
    final decora = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.black38, width: 1)
    );
    return Form(
      key: kkey,
      child: Scaffold(
        appBar: AppBar(
            actions: [IconButton(
                icon: const Icon(Icons.help_outline, size: 35, color: Color(0xFF590E11)),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ayudaOculta()))
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
                           const Text('  -Cargas en Micropilote', style: TextStyle(fontSize: 23.5, fontFamily: 'ubuntub')),
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
                              const Text('  -Acero de Refuerzo', style: TextStyle(fontSize: 23.5, fontFamily: 'ubuntub')),
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
                              const Text('  -Lechada', style: TextStyle(fontSize: 23.5, fontFamily: 'ubuntub')),
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
                              const Text('  -Platina', style: TextStyle(fontSize: 23.5, fontFamily: 'ubuntub')),
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
                              const Text('  -Suelo', style: TextStyle(fontSize: 23.5, fontFamily: 'ubuntub')),
                              jelp(5)
                            ]
                          ),
                          DroplistDatos('Tipo suelo'),
                          nfsegu('Factor de Seguridad', fs)
                        ]
                    )
                ),
                const SizedBox(height: 13),
                ElevatedButton.icon(
                    onPressed: _call,
                    label: const Text('Calcular', style: TextStyle(fontSize: 18)),
                    icon: const Icon(Icons.calculate_outlined, size: 30),
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFA72026))
                )
              ]
            )
          )
        )
      )
    );
  }

//Metodos para que el programa funcione mejor
//Nombre y form
  Row nform(String nombe, String hin){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width:MediaQuery.of(context).size.width*.45,
          child: Text(nombe)
        ),
        SizedBox(
          width:MediaQuery.of(context).size.width*.30,
          child: entrada(hin),
        )
      ]
    );
  }
//listas tipo barras
  Row nbarras(String nombe, List<String> lista ){
    final datos = Provider.of<Datos>(context);
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
            width:MediaQuery.of(context).size.width*.45,
            child: Text(nombe)
        ),
        SizedBox(
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
        SizedBox(
            width:MediaQuery.of(context).size.width*.45,
            child: Text(nombe)
        ),
        SizedBox(
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
        SizedBox(
            width:MediaQuery.of(context).size.width*.45,
            child: Text(nombe)
        ),
        SizedBox(
          width:MediaQuery.of(context).size.width*.30,
          child: DropdownButton(
            isExpanded: true,
            onChanged: (value) {
              setState(() {
                datos.fs = double.parse(value.toString()); //mire perro trucazo jaja
              });
            },
            items: lista.map((String a) {
              return DropdownMenuItem(
                  value: a,
                  child: Text(a));
            }).toList(),
            hint: Text(datos.fs.toString()),
          )
        )
      ]
    );
  }

  //Se encarga de obtener algunos calculos previos al diseño y pasarlos al widget que los printea
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
      Navigator.of(context).push(MaterialPageRoute(
          //receptor de datos si sirve
          builder: (context) => ResultadosMic(val[0],val[1],datos.nbar,cu[i],cy[i],fy[i],fu[i],ab[i],200000,val[2],
              val[3],val[4],ac,val[5],val[6],eg,val[7],agc,aguc,datos.tlec,dp,db,val[8],ar,a1,a2,datos.abond,datos.fs,datos.estra,tp,datos.nbro,datos.dbro)));
    });
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
                width: MediaQuery.of(context).size.width*.95,
                height:MediaQuery.of(context).size.height*.75,
                decoration:BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black38, width: 1)
                ),
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
              ElevatedButton(
                  onPressed: prueba,
                  child: const Text('Ejemplo de diseño'),
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFA72026))
              )
            ]
          )
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
        )
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
}
//Droplist de los estratos y alfa
class DroplistDatos extends StatefulWidget {
  String nombe;
  DroplistDatos(this.nombe, {Key? key}) : super(key: key);

  @override
  _DroplistDatosState createState() => _DroplistDatosState();
}

class _DroplistDatosState extends State<DroplistDatos> {
  String initial = ' ';
  List temp = [];
  List selec = [' ','Limos y Arcillas Blandas','Limos y Arcillas Duras', 'Arenas finas',
    'Arenas gruesas', 'Gravas', 'Depositos Glaciales', 'Lutitas Blandas',
    'Pizarras y Lutitas Duras', 'Calizas', 'Areniscas', 'Granito y Basallto'];

  @override
  Widget build(BuildContext context) {
    final datos = Provider.of<Datos>(context,listen: false);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width:MediaQuery.of(context).size.width*.45,
              child: Text(widget.nombe)
            ),
            SizedBox(
              width:MediaQuery.of(context).size.width*.30,
              child: DropdownButton(
                  isExpanded: true,//sin esto no se acomoda en la lista
                  value: initial,
                  //Aca recibe los valores y los pasa al map
                  items: selec.map((value){ //datos se mete al list
                    return DropdownMenuItem(
                      child: Text(value),
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
                    temp.addAll(datos.datas);
                    setState(() {
                      initial = value.toString();
                      datos.estra = value.toString(); //mire si remplaza el intial aqui
                    });
                  })
            )
          ]
        ),
        DroplistAlf(temp)
      ]
    );
  }
}

class DroplistAlf extends StatefulWidget {
  List temp ;
  DroplistAlf(this.temp, {Key? key}) : super(key: key);

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
        SizedBox(
            width:MediaQuery.of(context).size.width*.45,
            child:
            const Text('Coeficiente α ground to grout')
        ),
        SizedBox(
          width:MediaQuery.of(context).size.width*.30,
          child: DropdownButton(
              value: _value,
              //Aca recibe los valores y los pasa al map
              items:
              widget.temp.map((value){ //datos se mete al list
                return DropdownMenuItem(
                  child: Text(value),
                  value:value,
                );
              }).toList(),
              onChanged: (value) {
                datos.algua.add(double.parse((value.toString()))); //revise si este muere o ka
                datos.abond = double.parse(value.toString());
                setState(() {
                  _value = value.toString();
                });
              })
        )
      ]
    );
  }
}

