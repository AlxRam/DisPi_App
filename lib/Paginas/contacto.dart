import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class Contacto extends StatefulWidget {
  const Contacto({Key? key}) : super(key: key);

  @override
  State<Contacto> createState() => _ContactoState();
}

class _ContactoState extends State<Contacto> {
  Future<void>? _launched;

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    final Uri twiter =
    Uri(scheme: 'https', host: 'shorturl.at', path: 'jwAFP');
    final Uri whasap =
    Uri(scheme: 'https', host: 'shorturl.at', path: 'nopBQ');
    return Scaffold(
        appBar: AppBar(
            title: const Text('Feedback')
        ),
        backgroundColor: const Color(0xFFE7E7E7),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: 250,
                  width: 180,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: AssetImage('imagenes/contacto/yo.jpg'))
                  )
                )
              ),
              const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                      'Soy Yerlin Alexis Astudillo Ramirez, el desarrollador de la aplicación DisPi, también soy estudiante de Ingeniería Civil,'
                      ' próximo a graduarse de no ser por la bendita tesis, por 2 años de pandemia, 2 paros totales, 3 paros parciales, un estallido social '
                      'por las injusticias de nuestro país y por otros por menores que se han presentado en este largo trayecto que lo denomino vida adulta autónoma, responsable y social.'
                  )
              ),
              const SizedBox(height: 3),
              const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    'Ánimo a la persona que se haya detenido a leer este mensaje a seguir sus sueños, y a prestar mi ayuda y mis indicaciones'
                    ' en la introducción al desarrollo de aplicaciones móviles, también a dejar al servicio de la comunidad la aplicación y a invitar'
                    ' a seguir la línea de desarrollo en la propia aplicación o en una diferente, sin nada más que agregar, dejo mis datos de contacto y links de referencia.'
                  )
              ),
              ElevatedButton.icon(
                  label: const Text('Twitter',style: TextStyle(fontSize: 30)),
                  onPressed: () => setState(() {
                    _launched = _launchInBrowser(twiter);
                  }),
                  icon: const Icon(Icons.telegram, color: Color(0xFFFFFFFF), size: 30),
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF3B89FF),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                      )
                  )
              ),
              ElevatedButton.icon(
                  label: const Text('WhatsApp',style: TextStyle(fontSize: 30)),
                  onPressed: () => setState(() {
                    _launched = _launchInBrowser(whasap);
                  }),
                  icon: const Icon(Icons.whatsapp, color: Color(0xFFFFFFFF), size: 30),
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF42DC1D),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                      )
                  )
              )
            ]
          )
        )
    );
  }
}

//usar acortadores url n9.cl o shorturl.at
// Archivo original manual
// https://drive.google.com/file/d/1VfhcO2pvhy5fuGISR5iwdT5BtLa4qVrw/view?usp=sharing
// shorturl.at/fUX47
// Contancto wasap
// https://api.whatsapp.com/send?phone=573045560529&text=Hola%20Alexis%2C%20mucho%20gusto%20soy%20tu%20fan%2C%20me%20podr%C3%ADas%20ayudar%20con%20tu%20aplicaci%C3%B3n%20por%20favor%3F
// shorturl.at/nopBQ
// Contacto twitter
// https://twitter.com/AlxRam_?t=n4PYAmQQq-simndf9Is1Gw&s=09
// shorturl.at/jwAFP