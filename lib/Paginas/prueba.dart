import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


//comienza acca
class MenuSuelos extends StatefulWidget {
  CartItem cartItem;

  MenuSuelos({required this.cartItem});
  @override
  _MenuSuelosState createState() => _MenuSuelosState();
}

class _MenuSuelosState extends State<MenuSuelos> {
  String _value = "";

  @override
  void initState() {
    super.initState();
    _value = widget.cartItem.itemName;
  }

  @override
  void didUpdateWidget(MenuSuelos oldWidget) {
    if (oldWidget.cartItem.itemName != widget.cartItem.itemName) {
      _value = widget.cartItem.itemName;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    List<CartItem> cart = [CartItem(
        itemName: "Trae los datos",
        typeName: "Tipo A")];
    return Container(
      child: DropdownButton(
          isExpanded: true,
          value: _value,
          items: [
            DropdownMenuItem(child: Text(cart[0].desSuel[0]), value: cart[0].desSuel[0]),
            DropdownMenuItem(child: Text(cart[0].desSuel[1]), value: cart[0].desSuel[1]),
            DropdownMenuItem(child: Text(cart[0].desSuel[2]), value: cart[0].desSuel[2]),
            DropdownMenuItem(child: Text(cart[0].desSuel[3]), value: cart[0].desSuel[3]),
            DropdownMenuItem(child: Text(cart[0].desSuel[4]), value: cart[0].desSuel[4]),
            DropdownMenuItem(child: Text(cart[0].desSuel[5]), value: cart[0].desSuel[5]),
            DropdownMenuItem(child: Text(cart[0].desSuel[6]), value: cart[0].desSuel[6]),
            DropdownMenuItem(child: Text(cart[0].desSuel[7]), value: cart[0].desSuel[7]),
            DropdownMenuItem(child: Text(cart[0].desSuel[8]), value: cart[0].desSuel[8]),
            DropdownMenuItem(child: Text(cart[0].desSuel[9]), value: cart[0].desSuel[9]),
            DropdownMenuItem(child: Text(cart[0].desSuel[10]), value: cart[0].desSuel[10]),
            DropdownMenuItem(child: Text(cart[0].desSuel[11]), value: cart[0].desSuel[11])
          ],
          onChanged: (value) {
            setState(() {
              _value = value.toString();
              widget.cartItem.itemName = value.toString();
            });
          }),
    );
  }
}

//PARA EL ALFA
class MenuAlfa extends StatefulWidget {
  // const MenuAlfa({Key? key}) : super(key: key);
  CartItem cartItem;
  MenuAlfa({required this.cartItem});

  @override
  _MenuAlfaState createState() => _MenuAlfaState();
}

class _MenuAlfaState extends State<MenuAlfa> {
  List<CartItem> cart = [CartItem(
      itemName: "Trae los datos",
      typeName: "Tipo A")]; //Modificar esto no afecta
  List<String> reslecha= [' ','Tipo B','Tipo C','Tipo D'];
  Map reslech = {
    'Tipo' : 2,
  };
  List<Map<double,dynamic>> rest = [
    /*Tipo A*/ {0: ' ', 1: 35,	2: 65,	3: 95,	4: 70,	5: 130,	6: 190,	7: 70,	8: 130,	9: 190,	10: 120,	11: 240,	12: 360,	13: 120,	14: 240,	15: 360,	16: 95,	17: 202.5,	18: 310},
    /*Tipo B*/ // {'min':1,'max':11},
    /*Tipo C*/ // {'min':2,'max':12},
    /*Tipo D*/ // {'min':3,'max':13}
  ];
  int j = 0;
  int d = 0;
  String _value = '35';

  @override
  void initState() {
    super.initState();
    _value = widget.cartItem.typeName;
  }

  @override
  void didUpdateWidget(MenuAlfa oldWidget) {
    if (oldWidget.cartItem.typeName != widget.cartItem.typeName) {
      _value = widget.cartItem.typeName;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButton(
        value: _value,
        items: [
          //revise que aca el value se daña
          DropdownMenuItem(child: Text(rest[0][0].toString()),value:rest[0][0]),
          DropdownMenuItem(child: Text(rest[d][(j*3)+1].toString()),value:rest[d][(j*3)+1]),
          DropdownMenuItem(child: Text(rest[d][(j*3)+2].toString()),value:rest[d][(j*3)+2]),
          DropdownMenuItem(child: Text(rest[d][(j*3)+3].toString()),value:rest[d][(j*3)+3]),

          // DropdownMenuItem(child: Text(' '),value:''),


        ],
          onChanged: (value) {
            setState(() {
              _value = value.toString();
              // _value = '35';
              widget.cartItem.typeName = value.toString();
            });
          }

      ),
    );
  }
}

//PARA EL ALFA

//Recibe y comunica el mensaje
class CartItem {
  List <String> desSuel = [' Tipo de suelo','1.Limos y arcillo Blandas', '2.Limos y arcillas Duras', '3.Arenas finas',
    '4.Arenas gruesas', '5.Gravas', '6.Depositos Glaciales', '7.Lutitas Blandas',
    '8.Pizarras y lutitas Duras', '9.Calizas', '10.Areniscas', '11.Granito y Basallto'];
  String itemName;
  String typeName;
  CartItem({required this.itemName, required this.typeName});
}

class CartWidget extends StatefulWidget {
  List<CartItem> cart;
  int index;
  VoidCallback callback;

  CartWidget({required this.cart, required this.index, required this.callback});
  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  List<double> eje = []; //mirar si se utiliza
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: MenuSuelos(cartItem: widget.cart[widget.index])),
        // Expanded(child: entrada('α')),
        Expanded(child: MenuAlfa(cartItem: widget.cart[widget.index])),
        Expanded(
          child: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              setState(() {
                print(widget.index);
                widget.cart.removeAt(widget.index);
                widget.callback();
              });
            },
          ),
        )
      ],
    );
  }
  entrada(String hint){
    return TextFormField(
      validator: (String? value) { //Esta valida que no este vacio
        if (value == null || value.isEmpty) {
          return 'Campo requerido'; //campo en caso de que este vacio
        }
        return null;
      },
      // textInputAction: TextInputAction.,
      onSaved: (value) => eje.add(double.parse(value!)), //Aca guarda el valor
      decoration: InputDecoration(
        hintText: hint,
        // icon: Icon(Icons.calendar_view_day_sharp, color: Color(0xFFB14246))
      ),
      keyboardType: TextInputType.number,
    );
  }
}

//Widget prueba
class PruebaListas extends StatefulWidget {
  PruebaListas({ Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _PruebaListasState createState() => _PruebaListasState();
}

class _PruebaListasState extends State<PruebaListas> {
  List<CartItem> cart = [CartItem(
      itemName: " Tipo de suelo",
      typeName: " ")]; //en el cart, se necesitan estos valores en null o no serviran
  //ensayo de tipo lechada
  List <String> tipoLec = ['Tipo A', 'Tipo B', 'Tipo C', 'Tipo D'];
  String nlec =  'Tipo Lechada';
  Map<String,double> tipoa = {
    'max': 0
  };
  Map<String,double> tipob = {
    'max': 1
  };

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          DropdownButton(
          isExpanded: true,
          onChanged: (value) {
            setState(() {
              nlec = value as String;
            });
          },
          items: [
            DropdownMenuItem(child: Text('Tipo A'),value:'tipoa'),
            DropdownMenuItem(child: Text('Tipo B'),value:'tipob'),
            DropdownMenuItem(child: Text('Tipo C'),value:'tipoc'),
            DropdownMenuItem(child: Text('Tipo D'),value:'tipod'),],
          hint: Text(nlec),
        ),
            Expanded(
              child: ListView.builder(
                  key: UniqueKey(),
                  itemCount: cart.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return CartWidget(
                        cart: cart, index: index, callback: refresh);
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    cart.add(CartItem(
                        itemName: " Tipo de suelo",
                        typeName: " ")); //Aca sucede igaul
                    setState(() {});
                  },
                  child: Text("add Estrato"),
                ),
                ElevatedButton(
                  onPressed: () {
                    for (int i = 0; i < cart.length; i++) {
                      print(cart[i].itemName);
                      print(cart[i].desSuel.indexWhere((element) => element == cart[i].itemName));

                    }
                  },
                  child: Text("Print Result"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}