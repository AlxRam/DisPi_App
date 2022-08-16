import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: pruebaPizza(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

//Provider
class Datos with ChangeNotifier {
  List _datos = ['Flavor 1'];

  List get datos => _datos;

  set datos(List value){
    _datos = value;
    notifyListeners();
  }

  void goVegan () {
    _datos = ['Flavor 1','Vegan 1', 'Vegan 2', 'Vegan 3'];
    notifyListeners();
  }

  void goMeat () {
    _datos = ['Flavor 1', 'Meat 1', 'Meat 2', 'Meat 3'];
    notifyListeners();
  }

}

class Flavor extends StatefulWidget {
  CartItem cartItem;

  Flavor({required this.cartItem});
  @override
  _FlavorState createState() => _FlavorState();
}

class _FlavorState extends State<Flavor> {
  String _value = "Flavor 1";
  List<String> sabores = ['Flavor 1','',' ','  '];//Los valores no pueden repetirse, se separan con espacios
  List<String> _saboresveg = ['Flavor 1','Vegan 1', 'Vegan 2', 'Vegan 3']; //se pueso _
  List<String> saborescar = ['Flavor 1', 'Meat 1', 'Meat 2', 'Meat 3'];
  List<String> vacio = [];


  @override
  void initState() {
    super.initState();
    _value = widget.cartItem.flavor;
  }

  @override
  void didUpdateWidget(Flavor oldWidget) {
    if (oldWidget.cartItem.flavor != widget.cartItem.flavor) {
      _value = widget.cartItem.flavor;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    //Para inicializar el provider
    final datos = Provider.of<Datos>(context,listen: false);
    return Container(
      child: DropdownButton(
          value: _value,
          //Aca recibe los valores y los pasa al map
          items: datos.datos.map((value){ //datos se mete al list
            return DropdownMenuItem(
              child: new Text(value),
              value:value,
            );
          }).toList(),
            //[
            // DropdownMenuItem(
            //   child: Text("Flavor 1"),
            //   value: "Flavor 1",
            // ),
            // DropdownMenuItem(
            //   child: Text("Flavor 2"),
            //   value: "Flavor 2",
            // ),
            // DropdownMenuItem(child: Text("Flavor 3"), value: "Flavor 3"),
            // DropdownMenuItem(child: Text("Flavor 4"), value: "Flavor 4"),
            //Revisar como hacer para que de aca dependa un valor
          //   DropdownMenuItem(child: Text(sabores[0]), value: sabores[0]),
          //   DropdownMenuItem(child: Text(sabores[1]), value: sabores[1]),
          //   DropdownMenuItem(child: Text(sabores[2]), value: sabores[2]),
          //   DropdownMenuItem(child: Text(sabores[3]), value: sabores[3]),
          // ],

          onChanged: (value) {
            setState(() {
              _value = value.toString();
              widget.cartItem.flavor = value.toString();
              // sabores.add('hi modefucker'); no reconoce nuevos despues de metidos
              sabores.clear(); //Al cambiar, si se usa un valor diferente al primero, se daña
              // _saboresveg.add('hi');
              print(sabores);
            });
          }),
    );
  }
}

class Pizza extends StatefulWidget {
  CartItem cartItem;
  List<String> pizzas = ['Pizza 1', 'Pizza Vegan', 'Pizza Meat', 'Pizza Omni'];
  // List<String> pizzasbz = ['Pizza 1', 'Pizza 2bz', 'Pizza 3bz', 'Pizza 4bz'];
  // List<String> pizzasaz = ['Pizza 1', 'Pizza 2az', 'Pizza 3az', 'Pizza 4az'];

  Pizza({required this.cartItem});
  @override
  _PizzaState createState() => _PizzaState();
}

class _PizzaState extends State<Pizza> {
  String _value = "";


  @override
  void initState() {
    super.initState();
    _value = widget.cartItem.itemName;
  }

  @override
  void didUpdateWidget(Pizza oldWidget) {
    if (oldWidget.cartItem.itemName != widget.cartItem.itemName) {
      _value = widget.cartItem.itemName;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    //Para inicializar el provider
    final datos = Provider.of<Datos>(context,listen: false);
    return Container(
      child: DropdownButton(
          value: _value,
          items: //[
            // DropdownMenuItem(
            //   child: Text("Pizza 1"),
            //   value: "Pizza 1",
            // ),
            // DropdownMenuItem(
            //   child: Text("Pizza 2"),
            //   value: "Pizza 2",
            // ),
            // DropdownMenuItem(child: Text("Pizza 3"), value: "Pizza 3"),
            // DropdownMenuItem(child: Text("Pizza 4"), value: "Pizza 4"),
            // DropdownMenuItem(child: Text(widget.pizzas[0]), value: widget.pizzas[0]),
            // DropdownMenuItem(child: Text(widget.pizzas[1]), value: widget.pizzas[1]),
            // DropdownMenuItem(child: Text(widget.pizzas[2]), value: widget.pizzas[2]),
            // DropdownMenuItem(child: Text(widget.pizzas[3]), value: widget.pizzas[3])
          // ],
          widget.pizzas.map((value){
            return DropdownMenuItem(
              child: new Text(value),
              value:value,
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _value = value.toString();
              widget.cartItem.itemName = value.toString();
              if (value.toString()=='Pizza Vegan'){
                  print('meter fuckingmenu vegano');
                  datos.goVegan();



              }
              value.toString()=='Pizza Meat'?datos.goMeat():null;

            });
          }),
    );
  }
}

class pruebaPizza extends StatefulWidget {
  pruebaPizza({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _pruebaPizzaState createState() => _pruebaPizzaState();
}

class CartItem {
  String productType;
  String itemName;
  String flavor;
  CartItem({required this.productType, required this.itemName, required this.flavor});
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
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Pizza(cartItem: widget.cart[widget.index])),
        Expanded(child: Flavor(cartItem: widget.cart[widget.index])),
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
}

class _pruebaPizzaState extends State<pruebaPizza> {
  List<CartItem> cart = [CartItem(
      productType: "pizza",
      itemName: "Pizza 1",
      flavor: "Flavor 1")];//Para agg un item

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Datos>(
      create: (context) => Datos(),
      // builder: (context) => Datos(), //creo que quedo en desuso
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.access_time),
          onPressed: (){
            refresh();

          } ,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
                          productType: "pizza",
                          itemName: "Pizza 1",
                          flavor: "Flavor 1"));
                      setState(() {});
                    },
                    child: Text("add Pizza"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      for (int i = 0; i < cart.length; i++) {
                        print(cart[i].itemName);
                      }
                    },
                    child: Text("Print Pizza"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}