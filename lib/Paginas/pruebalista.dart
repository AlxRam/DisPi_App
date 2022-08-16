import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Dependent DropDown',
//       theme: ThemeData(
//
//         primarySwatch: Colors.blue,
//       ),
//       home: PruebaListass(title: 'Flutter Dependent DropDown'),
//     );
//   }
// }

class PruebaListass extends StatefulWidget {
  PruebaListass({Key? key, required this.title}) : super(key: key);
  // PruebaListass({required this.title}); //: super(key: key);


  final String title;

  @override
  _PruebaListassState createState() => _PruebaListassState();
}

class _PruebaListassState extends State<PruebaListass> {
  String _selectedCountry=" ";
  //tipos de lechada
  var country={' ':'T','Tipo A':'TA','Tipo B':'TB','Tipo C':'TC', 'Tipo D':'TD'};

  List _countries=[];
  CountryDependentDropDown(){
    country.forEach((key, value) {
      _countries.add(key);
    });
  }

  String _selectedState="";
  //Tipos Suelo
  var state={' ':'TA','Arenas':'TA','Limos':'TA','Arcillas':'TA',
    'Arenasb':'TB','Limosb':'TB','Arcillasb':'TB',
    'Arenasc':'TC','Limosc':'TC','Arcillasc':'TC'};

  List _states=[];
  StateDependentDropDown(countryShortName){
    state.forEach((key, value) {
      if(countryShortName==value){
        _states.add(key);
      }

    });
    _selectedState= _states[0];
  }

  String _selectedCity="";
  var city={'1':'Arenas','1.5':'Arenas','2':'Limos','2.5':'Limos','3':'Arcillas','3.5':'Arcillas'};

  List _cities=[];
  CityDependentDropDown(stateShortName){
    city.forEach((key, value) {
      if(stateShortName==value){
        _cities.add(key);
      }

    });
    _selectedCity= _cities[0];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CountryDependentDropDown();
  }
  @override

  Widget build(BuildContext context) {
    //Agg por mi
    List<Estrato> estratos = [Estrato()];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:(){
          // print(_states);
          // print(_selectedState);
          estratos[0].alfa = _selectedCity;
          estratos[0].tipo = _selectedState;
          print(estratos[0].tipo);

        },
      ),
      body: Container(
        margin:EdgeInsets.all(15),

        child: ListView.builder(
          itemCount: estratos.length,
          itemBuilder: (BuildContext ctxt, int index){

          return Column(

            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 23,),
              Align(
                alignment: Alignment.centerLeft,
                child:Text("Country",  style: TextStyle(fontWeight:FontWeight.bold,fontSize: 18),),
              ),
              Container(
                width: 400,
                child: DropdownButton(
                  value: _selectedCountry,
                  // value: estratos[0].tipo, //si utiliza el string, si cambia, si utiliza el list, no lo hace
                  onChanged: (newValue){
                    setState(() {
                      print(estratos[0].tipo);
                      _cities=[];
                      _states=[];
                      StateDependentDropDown(country[newValue]);
                      _selectedCountry="$newValue";
                      // estratos[0].tipo="$newValue";
                      print(estratos[0].tipo);
                    });

                  },
                  items:_countries.map((country){
                    return DropdownMenuItem(
                      child: new Text(country),
                      value:country,
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 23,),

              Align(
                  alignment: Alignment.centerLeft,
                  child:Text("State", style: TextStyle(fontWeight:FontWeight.bold,fontSize: 18),)
              ),
              Container(
                width: 400,
                child: DropdownButton(
                  value: _selectedState,
                  onChanged: (newValue){
                    print(newValue);
                    setState(() {
                      print(newValue);
                      _cities=[];
                      CityDependentDropDown(newValue);

                      _selectedState="$newValue";
                    });

                  },
                  items:_states.map((state){
                    return DropdownMenuItem(
                      child: new Text(state),
                      value:state,
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 23,),

              Align(
                  alignment: Alignment.centerLeft,
                  child:Text("City", style: TextStyle(fontWeight:FontWeight.bold,fontSize: 18),)
              ),
              Container(
                width: 400,
                child: DropdownButton(
                  value: _selectedCity,
                  onChanged: (newValue){
                    setState(() {
                      _selectedCity="$newValue";
                    });

                  },
                  items:_cities.map((city){
                    return DropdownMenuItem(
                      child: new Text(city),
                      value:city,
                    );
                  }).toList(),
                ),
              )


            ],
          );}, //Se agg el listview
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Estrato {
  String tipo;
  String alfa;


  Estrato({this.tipo=' ',this.alfa=' '});
}

//Prueba menus
class MeSuelos extends StatefulWidget {
  // const MeSuelos({Key? key}) : super(key: key);
  Estrato est;
  MeSuelos({required this.est});

  @override
  _MeSuelosState createState() => _MeSuelosState();
}

class _MeSuelosState extends State<MeSuelos> {
  String _value ='';
  @override
  void initState() {
    super.initState();
    _value = widget.est.tipo;
  }

  @override
  void didUpdateWidget(MeSuelos oldWidget) {
    if (oldWidget.est.tipo != widget.est.tipo) {
      _value = widget.est.tipo;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
