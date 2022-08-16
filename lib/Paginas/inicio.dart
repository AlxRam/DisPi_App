// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

class Inicio extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        flexibleSpace: SafeArea(
          child: Image.asset(
            'imagenes/logo.png',
            fit: BoxFit.scaleDown
          ),
        ),
      ),
      backgroundColor: Color(0xFF590E11),
      body: SafeArea(
        child: GridView.count(
          // padding: EdgeInsets.fromLTRB(20.0,100.0,20,20),
          childAspectRatio: 1.3,
          crossAxisCount: 2,
          children: [
            Column(
              children: [
                Container(padding: EdgeInsets.all(20),
                  child: Center(
                    child: FloatingActionButton.large(
                      onPressed: ()=>Navigator.of(context).pushNamed('/dos'),
                        child: Icon(Icons.wrap_text),
                        backgroundColor: Color(0xFFA72026),
                        foregroundColor: Color(0xFFD9CEA1),
                        heroTag: 'Esfuerzos'
                    ),
                  ),
                ),
                Text(
                  'ESFUERZOS',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD9CEA1),
                    shadows:const <Shadow>[
                      Shadow(
                        offset: Offset(5.0, 5.0),
                        blurRadius: 15.0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(padding: EdgeInsets.all(20),
                  child: Center(
                    child: FloatingActionButton.large(
                        onPressed: ()=>Navigator.of(context).pushNamed('/cuatro'),
                        child: Icon(Icons.approval),
                        backgroundColor: Color(0xFFA72026),
                        foregroundColor: Color(0xFFD9CEA1),
                        heroTag: 'Capacidad'
                    ),
                  ),
                ),
                Text(
                  'CAP. PORTANTE',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD9CEA1),
                    shadows:const <Shadow>[
                      Shadow(
                        offset: Offset(5.0, 5.0),
                        blurRadius: 15.0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(padding: EdgeInsets.all(20),
                  child: Center(
                    child: FloatingActionButton.large(
                        onPressed: ()=>Navigator.of(context).pushNamed('/tres'),
                        child: Icon(Icons.view_in_ar),
                        backgroundColor: Color(0xFFA72026),
                        foregroundColor: Color(0xFFD9CEA1),
                        heroTag: 'Asentamientos'
                    ),
                  ),
                ),
                Text(
                  'ASENTAMIENTOS',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD9CEA1),
                    shadows:const <Shadow>[
                      Shadow(
                        offset: Offset(5.0, 5.0),
                        blurRadius: 15.0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(padding: EdgeInsets.all(20),
                  child: Center(
                    child: FloatingActionButton.large(
                        onPressed: ()=>Navigator.of(context).pushNamed('/tres'),
                        child: Icon(Icons.view_week),
                        backgroundColor: Color(0xFFA72026),
                        foregroundColor: Color(0xFFD9CEA1),
                        heroTag: 'Grupo pilotes'
                    ),
                  ),
                ),
                Text(
                  'GRUPO PILOTES',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD9CEA1),
                    shadows:const <Shadow>[
                      Shadow(
                        offset: Offset(5.0, 5.0),
                        blurRadius: 15.0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(padding: EdgeInsets.all(20),
                  child: Center(
                    child: FloatingActionButton.large(
                        onPressed: ()=>Navigator.of(context).pushNamed('/cinco'),
                        child: Icon(Icons.architecture),
                        backgroundColor: Color(0xFFA72026),
                        foregroundColor: Color(0xFFD9CEA1),
                        heroTag: 'Pilotes'
                    ),
                  ),
                ),
                Text(
                  'MICROPILOTES',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD9CEA1),
                    shadows:const <Shadow>[
                      Shadow(
                        offset: Offset(5.0, 5.0),
                        blurRadius: 15.0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(padding: EdgeInsets.all(20),
                  child: Center(
                    child: FloatingActionButton.large(
                        onPressed: ()=>Navigator.of(context).pushNamed('/seis'),
                        child: Icon(Icons.textsms_outlined),
                        backgroundColor: Color(0xFFA72026),
                        foregroundColor: Color(0xFFD9CEA1),
                        heroTag: 'Preguntas'
                    ),
                  ),
                ),
                Text(
                  'FAQ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD9CEA1),
                    shadows:const <Shadow>[
                      Shadow(
                        offset: Offset(5.0, 5.0),
                        blurRadius: 15.0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Reinicio extends StatelessWidget {
  const Reinicio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 150,
          backgroundColor: Colors.transparent,
          bottomOpacity: 0.0,
          elevation: 0.0,
          flexibleSpace: SafeArea(
            child: Image.asset(
                'imagenes/logo.png',
                fit: BoxFit.scaleDown
            ),
          ),
        ),
        backgroundColor: Color(0xFF590E11),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                  onPressed: ()=>Navigator.of(context).pushNamed('/cinco'),
                  icon: Icon(
                      Icons.create_rounded,
                      color: Color(0xFFD9CEA1),
                      size: 50,
                      shadows:const <Shadow>[
                        Shadow(
                          offset: Offset(5.0, 5.0),
                          blurRadius: 15.0,
                          color: Colors.black
                    )
                  ]),
                  label: Text(
                    'MICROPILOTES',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD9CEA1),
                      shadows:const <Shadow>[
                        Shadow(
                          offset: Offset(5.0, 5.0),
                          blurRadius: 15.0,
                          color: Colors.black
                        )
                      ]
                    )
                  ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFA72026),
                      fixedSize: const Size(300, 80),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)
                      )
                    )
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                  onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) => Inicio())),
                  icon: Icon(
                      Icons.add,
                      color: Color(0xFFD9CEA1),
                      size: 50,
                      shadows:const <Shadow>[
                        Shadow(
                            offset: Offset(5.0, 5.0),
                            blurRadius: 15.0,
                            color: Colors.black
                        )
                      ]),
                  label: Text(
                      '  FUNCIONES',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFD9CEA1),
                          shadows:const <Shadow>[
                            Shadow(
                                offset: Offset(5.0, 5.0),
                                blurRadius: 15.0,
                                color: Colors.black
                            )
                          ]
                      )
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xFFA72026),
                      fixedSize: const Size(300, 80),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                      )
                  )
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                //meta aca el tema del manual nativo desde la aplicacion, no se ponda con mmdas compa
                  onPressed: ()=>Navigator.of(context).pushNamed('/siete'),
                  icon: Icon(
                      Icons.quiz_outlined,
                      color: Color(0xFFD9CEA1),
                      size: 50,
                      shadows:const <Shadow>[
                        Shadow(
                            offset: Offset(5.0, 5.0),
                            blurRadius: 15.0,
                            color: Colors.black
                        )
                      ]),
                  label: Text(
                      '    MANUAL ',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFD9CEA1),
                          shadows:const <Shadow>[
                            Shadow(
                                offset: Offset(5.0, 5.0),
                                blurRadius: 15.0,
                                color: Colors.black
                            )
                          ]
                      )
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xFFA72026),
                      fixedSize: const Size(300, 80),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                      )
                  )
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left:200),
                child: FloatingActionButton.large(
                  onPressed: ()=>Navigator.of(context).pushNamed('/seis'),
                  backgroundColor: Color(0xFFA72026),
                  child: Icon(
                    Icons.feedback_outlined,
                    color: Color(0xFFD9CEA1),
                    size: 50,
                    shadows:const <Shadow>[
                      Shadow(
                          offset: Offset(5.0, 5.0),
                          blurRadius: 15.0,
                          color: Colors.black
                      )
                    ]),
                ),
              )
            ]
          )
        )
    );
  }
}



//Aca no se aplican los botones por el tema del context
//el context por fuera del build no sirve