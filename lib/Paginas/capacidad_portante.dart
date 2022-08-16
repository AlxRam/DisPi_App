// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'dart:math';
// import 'package:flutter/rendering.dart';

class CalculoPortante extends StatefulWidget {
  const CalculoPortante({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => Porta();
}

class Porta extends State<CalculoPortante> {
  final GlobalKey<FormState> lakey = GlobalKey<FormState>();
  int a=1;
  List<String> tpil = ['Perforado o Hincado con chorro agua','Hincado de bajo desplazamiento','Hincado de alto desplazamiento'];
  String npil =  'Tipo Pilote';
  List<double> eje = [];
  @override
  Widget build(BuildContext context) {
    return Form(
      key: lakey,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Calculo Capacidad Portante Pilote')
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                duplica(context),
                Padding(
                  padding: const EdgeInsets.all(50),
                  child: entrada('Longitud'),
                ),
                //Lista desplegable
                DropdownButton(
                  onChanged: (value) {
                    setState(() {
                      npil = value as String;
                    });
                  },
                  items: tpil.map((String a) {
                    return DropdownMenuItem(
                      value: a,
                      child: Text(a));
                  }).toList(),
                  hint: Text(npil),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(onPressed: _suma, child: Icon(Icons.add),heroTag: 'suma',),
            SizedBox.fromSize(size: Size.fromRadius(5),),
            FloatingActionButton(onPressed: _resta, child: Icon(Icons.remove),heroTag: 'resta',),
          ],
        ),
      ),
    );
  }

  Row duplica(BuildContext context) {
    return Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('imagenes/portante/d.png')),
                  ),
                  height: 220,
                  width: 180,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(85,0,20,0),
                    child: entrada('Diametro')
                  )
                ),
                Container(
                    // margin: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage('imagenes/portante/l.png')),
                    ),
                    height: 220,
                    width: 180,
                    child: null//entrada()
                )
              ]
            );
  }
  // Este valida el key anterior
  void _valida() {
    final form = lakey.currentState!;
    if (form.validate()) {
      setState(() => form.save()
      );
    }
  }
  void _suma() {
    final form = lakey.currentState!;
    // if (form.validate()) {
    //   setState(() => a++
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => TablaDatos())
      );


  }

  void _resta() {
    final form = lakey.currentState!;
    if (a>1) {
      setState(() => a--
      );
    }

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
      onSaved: (value) => eje.add(double.parse(value!)), //Aca guarda el valor
      decoration: InputDecoration(
        hintText: hint,
        // icon: Icon(Icons.calendar_view_day_sharp, color: Color(0xFFB14246))
      ),
      keyboardType: TextInputType.number,
    );
  }

}

class TablaDatos extends StatefulWidget {
   TablaDatos({Key? key}) : super(key: key);
  final List <String> nList = ['Prof',"0'","d'"];

  @override
  _TablaDatosState createState() => _TablaDatosState();
}

class _TablaDatosState extends State<TablaDatos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text ('Tabla datos'),
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
                          for (int i = 0; i<3; i++)
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
                  for (int i = 0; i<3; i++) TableRow(
                      decoration: BoxDecoration(color: Colors.white38),
                      children: [
                        Center(child: Text('0')),
                        Center(child: Text('0')),
                        //generar un list para este
                        Center(child: Text('0'))
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


//REALIZE AQUI TODAS LAS PRUEBAS

class eje2 extends StatelessWidget {
int i =0;
List<String> nLis =['Espesor(m)','γh(kN/m³)',"σ'v(kPa)"];
var list2 = [{'id':"123123","date":"20/08/2016"},{'id':"123124","date":"26/08/2016"},{'id':"123125","date":"26/08/2016"}];
@override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Table(
                border: TableBorder.all(),
                defaultColumnWidth: FixedColumnWidth(120),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  // for(var item in list2 )  TableRow(children: [
                  //   Text('id'),
                  //   Text('date'),
                  // //Titulos

                  TableRow(children: [
                    for (i = 0; i < 3; i++)
                      Container(
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(color: Colors.grey),
                          child: Text(nLis[i],
                              style:
                                  TextStyle(fontSize: 20, fontWeight: FontWeight.bold)))
                  ]),
                  //Datos

                  // for (i = 0; i < 3; i++)
                  //   TableRow(decoration: BoxDecoration(color: Colors.white38), children: [
                  //     for (i = 0; i < 3; i++) Center(child: Text('holab $i'))
                  //   ]
                  //   ),
                ],
              ),
              Table(
                border: TableBorder.all(),
                defaultColumnWidth: FixedColumnWidth(120),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  for(i=0;i<5;i++ )  TableRow(children: [
                    Text('id'),
                    Text('date'),
                    Text('date'),

              ],)
            ],
          ),]
        ),
      ),)
    );
  }
}


