import 'package:flutter/material.dart';

class Inicio extends StatelessWidget {
  const Inicio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Image.asset('imagenes/logo.png', fit: BoxFit.scaleDown)
        )
      ),
      backgroundColor: const Color(0xFF590E11),
      body: SafeArea(
        child: GridView.count(
          childAspectRatio: 1.3,
          crossAxisCount: 2,
          children: [
            BotoneInicio(
                name: 'ESFUERZOS',
                icono: Icons.wrap_text,
                route: '/dos'
            ),
            BotoneInicio(
                name: 'CAP. PORTANTE',
                icono: Icons.approval,
                route: '/cuatro'
            ),
            BotoneInicio(
                name: 'ASENTAMIENTOS',
                icono: Icons.view_in_ar,
                route: '/tres'
            ),
            BotoneInicio(
                name: 'GRUPO PILOTES',
                icono: Icons.view_week,
                route: '/tres'
            ),
            BotoneInicio(
                name: 'MICROPILOTES',
                icono: Icons.architecture,
                route: '/cinco'
            ),
            BotoneInicio(
                name: 'FAQ',
                icono: Icons.textsms_outlined,
                route: '/seis'
            )
          ]
        )
      )
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
            child: Image.asset('imagenes/logo.png', fit: BoxFit.scaleDown)
          )
        ),
        backgroundColor: const Color(0xFF590E11),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BotonesReinicio(
                  name: 'MICROPILOTES',
                  icono: Icons.create_rounded,
                  route: '/cinco'
              ),
              const SizedBox(height: 20),
              BotonesReinicio(
                  name: '  FUNCIONES',
                  icono: Icons.add,
                  route: '/uno'
              ),
              const SizedBox(height: 20),
              BotonesReinicio(
                name: '    MANUAL ',
                icono: Icons.quiz_outlined,
                route: '/siete'
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left:200),
                child: FloatingActionButton.large(
                    onPressed: ()=>Navigator.of(context).pushNamed('/seis'),
                    backgroundColor: const Color(0xFFA72026),
                    child: const Icon(
                        Icons.feedback_outlined,
                        color: Color(0xFFD9CEA1),
                        size: 50,
                        shadows:<Shadow>[
                          Shadow(
                              offset: Offset(5.0, 5.0),
                              blurRadius: 15.0,
                              color: Colors.black
                          )
                        ]
                    )
                ),
              )
            ]
          )
        )
    );
  }
}

class BotonesReinicio extends StatelessWidget {
  String name;
  IconData icono;
  String route;
  BotonesReinicio({
    Key? key,
    required this.name,
    required this.icono,
    required this.route
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: ()=>Navigator.of(context).pushNamed(route),
        icon: Icon(
            icono,
            size: 50,
            color: const Color(0xFFD9CEA1),
            shadows:const <Shadow>[
              Shadow(
                  offset: Offset(5.0, 5.0),
                  blurRadius: 15.0,
                  color: Colors.black
              )
            ]
        ),
        label: Text(
            name,
            style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0xFFD9CEA1),
                shadows:<Shadow>[
                  Shadow(
                      offset: Offset(5.0, 5.0),
                      blurRadius: 15.0,
                      color: Colors.black
                  )
                ]
            )
        ),
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFA72026),
            fixedSize: const Size(300, 80),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50)
            )
        )
    );
  }
}

class BotoneInicio extends StatelessWidget {
  String name;
  IconData icono;
  String route;
  BotoneInicio({
    Key? key,
    required this.name,
    required this.icono,
    required this.route
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(height: 5),
        FloatingActionButton.large(
            onPressed: ()=>Navigator.of(context).pushNamed(route),
            heroTag: name,
            backgroundColor: const Color(0xFFA72026),
            foregroundColor: const Color(0xFFD9CEA1),
            child: Icon(icono)
        ),
        Text(
          name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFFD9CEA1),
            shadows:<Shadow>[
              Shadow(
                offset: Offset(5.0, 5.0),
                blurRadius: 15.0,
                color: Colors.black
              )
            ]
          )
        )
      ]
    );
  }
}
