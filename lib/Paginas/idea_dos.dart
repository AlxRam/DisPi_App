import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Provider
class Datos with ChangeNotifier {
  //meter un string con el tipo lechada, y crear los void con go, ahi meter if que dependa la lechada
  //revisar como meter los fucking datos
  String tlec = 'Tipo A';
  List _datos = [' '];
  List guardado = [];
  List gg = [];
  List<String> esgua = [];
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
    notifyListeners();
  }
  void goVegan () {

    // _datos = [' ','Vegan 1', 'Vegan 2', 'Vegan 3'];
    _datos = [' ','1', '2', '3'];
    notifyListeners();
  }

  void goMeat () {
    _datos = [' ', '3 ', '4', '5'];
    notifyListeners();
  }

  void plus () {
    ne++;
    notifyListeners();
  }

}

class Inicializador extends StatelessWidget {
  const Inicializador({Key? key}) : super(key: key);
//Aca es importante que este inicializado el provider
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Datos>(
      create: (context) => Datos(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ensayo de 3 tomas'),
        ),
        body:Column(
          children: [
            Text('Toma pedido'),
            RowEstAlfaMts(),
          ],
        ),
      ),
    );
  }
}

class RowEstAlfaMts extends StatefulWidget {
  const RowEstAlfaMts({Key? key}) : super(key: key);

  @override
  State<RowEstAlfaMts> createState() => _RowEstAlfaMtsState();
}

class _RowEstAlfaMtsState extends State<RowEstAlfaMts> {

  @override
  Widget build(BuildContext context) {
    //Va despues del build para estar a la par de la jerarquia y usar el provider
    final datos = Provider.of<Datos>(context);
    return Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            itemCount: datos.ne,
            itemBuilder: (BuildContext context, int index) => DroplistDatos(),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                onPressed: (){
                  if(datos.ne==datos.esgua.length&&datos.ne==datos.algua.length&&datos.ne==datos.zgua.length&&datos.ne!=0){
                    print ('si se puede');
                    print(datos.algua);
                    print(datos.esgua);
                    print(datos.zgua);
                  }
                },
                child: Text('Print'),
                style: ElevatedButton.styleFrom(primary: const Color(0xFFA72026))
            ),
            ElevatedButton(
                onPressed: (){
                  setState(() {
                    datos.ne = 0;
                    datos.esgua.clear();
                    datos.algua.clear();
                    datos.zgua.clear();
                  });
                },
                child: Text('Reinicia'),
                style: ElevatedButton.styleFrom(primary: const Color(0xFFA72026))
            ),
            ElevatedButton(
                onPressed: (){
                  datos.plus();
                },
                child: Text('Add estrato'),
                style: ElevatedButton.styleFrom(primary: Color(0xFFA72026))
            ),
          ],
        )
      ],
    );
  }
}

class DroplistDatos extends StatefulWidget {
  const DroplistDatos({Key? key}) : super(key: key);

  @override
  _DroplistDatosState createState() => _DroplistDatosState();
}

class _DroplistDatosState extends State<DroplistDatos> {
  List selec = [' ','Limos y Arcillas Blandas','Limos y Arcillas Duras', 'Arenas finas',
  'Arenas gruesas', 'Gravas', 'Depositos Glaciales', 'Lutitas Blandas',
  'Pizarras y Lutitas Duras', 'Calizas', 'Areniscas', 'Granito y Basallto'];

  String initial = ' ';
  // String initial2 = ' ';
  List temp = [];
  List<double> eje = [];
  

  @override
  Widget build(BuildContext context) {
    final datos = Provider.of<Datos>(context,listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 200,
          // padding: EdgeInsets.all(8),
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
                datos.esgua.add(value.toString());
                //Añade los datos de entrada y los pasa al widget para que los conserve
                temp.addAll(datos._datos);
                setState(() {
                  initial = value.toString();
                });
              })
        ),
        Container(
          width: 85,
          padding: EdgeInsets.all(8),
          child: DroplistAlf(temp),
        ),
        Container(
          width: 70,
          padding: EdgeInsets.all(8),
          child: entrada('mts', datos),
        )
      ],
    );
  }
  //inputs de formatos
  entrada(String hint, Datos datos){
    return TextFormField(
      validator: (String? value) { //Esta valida que no este vacio
        if (value == null || value.isEmpty) {
          return 'Campo requerido'; //campo en caso de que este vacio
        }
        return null;
      },
      onSaved: (value) => eje.add(double.parse(value!)),//eje.add(double.parse(value!)), //Aca guarda el valor
      onFieldSubmitted: (value) => datos.zgua.add(double.parse((value.toString()))),
      // onChanged: (value)=> print(value),
      decoration: InputDecoration(
        hintText: hint,
        // icon: Icon(Icons.calendar_view_day_sharp, color: Color(0xFFB14246))
      ),
      keyboardType: TextInputType.number,
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
    return DropdownButton(
        // value: widget.initial2,
        value: _value,
        // hint: Text('hi'),
        //Aca recibe los valores y los pasa al map
        items:
        widget.temp.map((value){ //datos se mete al list
          return DropdownMenuItem(
            child: new Text(value),
            value:value,
          );
        }).toList(),
        onChanged: (value) {
          datos.algua.add(double.parse((value.toString())));
          setState(() {
            _value = value.toString();
          });
        });
  }
}

//convertir objeto a double
//datos.gg.add(double.parse((value.toString())));