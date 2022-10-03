import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Manual extends StatelessWidget {
  Manual({Key? key}) : super(key: key);
  Future<void>? _launched;
  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
//Para contactarme a mi
  @override
  Widget build(BuildContext context) {
    final Uri manual =
    Uri(scheme: 'https', host: 'shorturl.at', path: 'fUX47');
    return Scaffold(
        appBar: AppBar(
          title: const Text ('Manual del usuario'),
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
                      width: 1
                    )
                ),
                width: MediaQuery.of(context).size.width*.95,
                height:MediaQuery.of(context).size.height*.75,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => _launched = _launchInBrowser(manual),
                      child: Container(
                          width: MediaQuery.of(context).size.width*.85,
                          height:MediaQuery.of(context).size.height*.70,
                          decoration: const BoxDecoration(
                              image: DecorationImage(image: AssetImage('imagenes/contacto/mientras.png'))
                          )
                      ),
                    )
                  ]
                )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.touch_app_rounded),
                  Text(' para ingresar al manual'),
                ]
              )
            ]
          )
        )
    );
  }
}
