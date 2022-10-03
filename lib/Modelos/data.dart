import 'package:flutter/cupertino.dart';

//Provider
class Datos with ChangeNotifier {
  String tlec = 'Tipo Grout';
  String nbar = 'Tipo barra';
  String nbro = '';
  String dbro = '';
  String estra = '';
  double fs = 0;
  double abond = 0;
  List datas = [' '];
  List<String> esgua = []; //revisar si no  mueren
  List<double> algua = [];
  List<double> zgua = [];
  int ne = 0;

  List get datos => datas;

  set datos(List value){
    datas = value;
    notifyListeners();
  }
  //espacios en numeros repetidos para no dañar la seleccion
  // siempre debe ir el ' '
  //Limos y arcillas blandas
  void goLimBla () {
    switch (tlec) {
      case 'Tipo A':
        datas = [' ', '35', '52.5', '70'];
        break;
      case 'Tipo B':
        datas = [' ', '35', '65', '95'];
        break;
      case 'Tipo C':
        datas = [' ', '50', '85', '120'];
        break;
      case 'Tipo D':
        datas = [' ', '50', '97.5', '145'];
        break;
    }
    nbro = 'CD-D-HD';
    dbro = 'Apto para arenas sueltas o incluso gravas';
    notifyListeners();
  }
  //Limos y Arcillas Duras
  void goLimDur () {
    switch (tlec) {
      case 'Tipo A':
        datas = [' ', '50', '85', '120'];
        break;
      case 'Tipo B':
        datas = [' ', '70', '130', '190'];
        break;
      case 'Tipo C':
        datas = [' ', '95', '142.5', '190'];
        break;
      case 'Tipo D':
        datas = [' ', '95', '142.5', '190'];
        break;
    }
    nbro = 'CD-D-HD';
    dbro = 'Apto para arenas sueltas o incluso gravas';
    notifyListeners();
  }
  //Arenas Finas
  void goAreFin () {
    switch (tlec) {
      case 'Tipo A':
        datas = [' ', '70 ', '107.5', '145'];
        break;
      case 'Tipo B':
        datas = [' ', '70 ', '130 ', '190 '];
        break;
      case 'Tipo C':
        datas = [' ', '95 ', '142.5 ', '190 '];
        break;
      case 'Tipo D':
        datas = [' ', '95 ', '167.5', '240'];
        break;
    }
    nbro = 'TSB-D-R';
    dbro = 'Apto para suelos gruesos y rellenos';
    notifyListeners();
  }
  //Arenas Gruesas
  void goAreGru () {
    switch (tlec) {
      case 'Tipo A':
        datas = [' ', '95', '155', '215'];
        break;
      case 'Tipo B':
        datas = [' ', '120', '240', '360'];
        break;
      case 'Tipo C':
        datas = [' ', '145', '252.5', '360'];
        break;
      case 'Tipo D':
        datas = [' ', '145', '265', '385'];
        break;
    }
    nbro = 'TSB-D-R';
    dbro = 'Apto para suelos gruesos y rellenos';
    notifyListeners();
  }
  //Gravas
  void goGra () {
    switch (tlec) {
      case 'Tipo A':
        datas = [' ', '95 ', '180', '265'];
        break;
      case 'Tipo B':
        datas = [' ', '120 ', '240 ', '360 '];
        break;
      case 'Tipo C':
        datas = [' ', '145 ', '252.5 ', '360 '];
        break;
      case 'Tipo D':
        datas = [' ', '145 ', '265 ', '385 '];
        break;
    }
    nbro = 'AR-D-HD';
    dbro = 'Apto para rellenos, gravas y suelos fracturados';
    notifyListeners();
  }
  //Depositos Glaciales
  void goDepGla () {
    switch (tlec) {
      case 'Tipo A':
        datas = [' ', '95  ', '142.5', '190'];
        break;
      case 'Tipo B':
        datas = [' ', '95 ', '202.5', '310'];
        break;
      case 'Tipo C':
        datas = [' ', '120 ', '215', '310'];
        break;
      case 'Tipo D':
        datas = [' ', '120', '227.5', '335'];
        break;
    }
    nbro = 'AR-D-HD';
    dbro = 'Apto para rellenos, gravas y suelos fracturados';
    notifyListeners();
  }
  //Lutitas Blandas
  void goLutBla () {
    switch (tlec) {
      case 'Tipo A':
        datas = [' ', '205', '377.5', '550'];
        break;
      default:
        datas = [' '];
        break;
    }
    nbro = 'AR-D-HD';
    dbro = 'Apto para rellenos, gravas y suelos fracturados';
    notifyListeners();
  }
  //Pizarras y Lutitas Duras
  void goLutDur () {
    switch (tlec) {
      case 'Tipo A':
        datas = [' ', '515', '947.5', '1380'];
        break;
      default:
        datas = [' '];
        break;
    }
    nbro = 'BB-D-HD';
    dbro = 'Apto para suelos fracturados, calizas y areniscas';
    notifyListeners();
  }
  //Calizas
  void goCal () {
    switch (tlec) {
      case 'Tipo A':
        datas = [' ', '1035', '1552.5', '2070'];
        break;
      default:
        datas = [' '];
        break;
    }
    nbro = 'BB-D-HD';
    dbro = 'Apto para suelos fracturados, calizas y areniscas';
    notifyListeners();
  }
  //Areniscas
  void goAre () {
    switch (tlec) {
      case 'Tipo A':
        datas = [' ', '520', '1122.5', '1725'];
        break;
      default:
        datas = [' '];
        break;
    }
    nbro = 'AB-D-HD';
    dbro = 'Apto para suelos fracturados, calizas y areniscas';
    notifyListeners();
  }
  //Granito y Basalto
  void goGraBas () {
    switch (tlec) {
      case 'Tipo A':
        datas = [' ', '1380 ', '2790', '4200'];
        break;
      default:
        datas = [' '];
        break;
    }
    nbro = 'AB-D-HD';
    dbro = 'Apto para suelos fracturados, calizas y areniscas';
    notifyListeners();
  }
}