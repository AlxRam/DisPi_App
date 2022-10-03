import 'package:esfuerzos/Paginas/graficas.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart'; //Para sumar listas
import 'package:screenshot/screenshot.dart'; //Para tomar capturas
import 'package:syncfusion_flutter_pdf/pdf.dart'; //Para pdf
import 'dart:typed_data';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

//se crea clase para visulisar, se debe usar statefulwidget, de lo contrario no recarga
class CalculoEsfuerzos extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Calesf();
}
//Aqui se trabaja para visulizar el widget
class Calesf extends State<CalculoEsfuerzos> {
  //esto se encarga de resolveer unos problemitas
  @override
  void initState() {
    super.initState();
  }
  //Declaracion variables
  double esff = 0;
  List<double> prof = [], esfe=[0], gam = [], profa=[0];
  double profn = 0;
  double proff = 0;//revisar si se usa
  int nEst = 1;
  int img = 0;
  //Para comprobar que los campos no esten vacios
  final myFormKey = GlobalKey<FormState>();
  //aca se mete to-do el lio del widget
  //se mete el setState (), para informar que hubo un cambio
  @override
  Widget build(BuildContext context) {
    return Form( //si no va este Form, los TextFormField no reciben
      key: myFormKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Calculo Esfuerzos verticales'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                ListView.builder(
                shrinkWrap: true,
                itemCount: nEst ,
                itemBuilder: (BuildContext context,int index){
                  return ingresaProfGama(context);
                }
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    botonRes(),
                    const SizedBox(height: 12),
                    botonAgg()
                  ]
                ),
                ingresaNivelF(),
                // ingresaProfFinal(),
              ],
            ),
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            botonSup(),
            botonCal()
          ],
        ),
      ),
    );
  }

  //Inputs de valores
  Row ingresaProfGama(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
            margin: const EdgeInsets.only(left: 60),
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('imagenes/estratos/n.png')),
            ),
            height: 100,
            width: 200,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(80,32,70,0),
              child: TextFormField(
                validator: (String? value) { //Esta valida que no este vacio
                  if (value == null || value.isEmpty) {
                    return 'Campo requerido'; //campo en caso de que este vacio
                  }
                  return null;
                },
                onSaved: (value) => gam.add(double.parse(value!)), //Aca guarda el valor
                decoration: const InputDecoration(
                  hintText: "kN/m³",
                  ),
                keyboardType: TextInputType.number,
              ),
            )
        ),
        Container(
            margin: const EdgeInsets.only(left: 1),
            width: MediaQuery.of(context).size.width*0.20,
            child: TextFormField(
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Campo requerido';
                }
                return null;
              },
              onSaved: (value) => prof.add(double.parse(value!)),
              decoration: const InputDecoration(
                hintText: "mts",
                ),
              keyboardType: TextInputType.number,
            )
        )
      ],
    );
  }

  ingresaNivelF() {
    return TextFormField(
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Campo requerido';
        }
        return null;
      },
      onSaved: (value) => profn = double.parse(value!),
      // onSaved: (value)  { //para que no pida freatico, pero no sirve
      //   if (value == null || value.isEmpty){
      //     profn = 100;
      //   }
      // },
      decoration: const InputDecoration(
        hintText: "Nivel Freatico",
        icon: Icon(Icons.water, color: Color(0xFFB14246))),
      keyboardType: TextInputType.number,
    );
  }

  ingresaProfFinal() { //revisar si se usa
    return TextFormField(
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Campo requerido';
        }
        return null;
      },
      onSaved: (value) => proff = double.parse(value!),
      decoration: const InputDecoration(
        hintText: "Profundidad Objetivo",
        icon: Icon(Icons.arrow_downward, color: Color(0xFFB14246))),
      keyboardType: TextInputType.number,
    );
  }

//Botones

  botonAgg() {
    return FloatingActionButton(
        onPressed: () => _suma(),
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xFF590E11), //Color fondo
        foregroundColor: const Color(0xFFD9CEA1), //Color letra
        heroTag: 'Agregar'
    );
  }

  botonRes() {
    return FloatingActionButton.small(
        onPressed: () => _resta(),
        child: const Icon(Icons.remove),
        backgroundColor: const Color(0xFF590E11), //Color fondo
        foregroundColor: const Color(0xFFD9CEA1), //Color letra
        heroTag: 'Restar'
    );
  }

  botonCal() {
    return Container(
      margin: const EdgeInsets.only(left: 300.0, top: 13.0),
      child: FloatingActionButton(
          onPressed: () => _valida(),
          child: const Icon(Icons.calculate),
          backgroundColor: const Color(0xFF590E11), //Color fondo
          foregroundColor: const Color(0xFFD9CEA1), //Color letra
          heroTag: 'Calcular'
      ),
    );
  }

  botonSup() {
    return Container(
      margin: const EdgeInsets.only(left: 300.0, top: 13.0),
      child: FloatingActionButton(
          onPressed: () {
            myFormKey.currentState!.reset();
            setState(() {
              prof.clear();
              gam.clear();
              esff=0;
              nEst=1;
              }
            );
          },
          child: const Icon(Icons.clear),
          backgroundColor: const Color(0xFF590E11), //Color fondo
          foregroundColor: const Color(0xFFD9CEA1), //Color letra
          heroTag: 'Suprimir'
      ),
    );
  }
//Accionadores
  void _valida() {
    final form = myFormKey.currentState!;
    if (nEst>5) { //Para que no metan mas de 5 estratos
      showDialog(
        context: context,
        builder: (context)=>const AlertDialog(
          title: Text('ALERTA !'),
          content: Text('Excediste la cantidad máxima de estratos que son 5, no consideres uno.'),
        )
      );
    } else if (!form.validate()) { //Para que se entere que no lleno un campo
      showDialog(
        context: context,
        builder: (context)=>const AlertDialog(
          title: Text('ALERTA !'),
          content: Text('No llenastes todos los campos'),
        )
      );
    }
    else {
      setState(() => {
        form.save(),
        calesf(),
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Resultados(profa,gam,esfe,proff)))
      }
      );
    }
  }

  void _suma() {
    setState(() => nEst++
    );
  }

  void _resta() {
    if (nEst>1) {//Para que no borre el unico que haya
      setState(() => nEst--
      );
    }
  }

//Realiza el calculo de esfuerzos
  /*Esfuerzos verticales, recibe, prof, gam, proff, profn.
  Entra un ciclo while, donde no dejará de evaluar hasta que la profundidad evaluada sea cero,
  explicando el código, se evalua en cada estrato donde estará el excedente de la
  profundidad evaluada, esto no sucederá cuando el esfuerzo llega a limite de estrato, y cuando
  el esfuerzo se necesita en x parte del estrato, se aplica la formula con el prof evaluado
  valido solo con mts y kN/m³*/

  calesf() {
    int j = 0;
    double up = 0, proft = 0;
    List <double> esfa=[0], esft=[];
    //calculo esfuerzo efectivo y esfuerzos totales
    for (j=0;j<(prof.length);j++ ){
      esfa.add(prof[j]*gam[j]);
      esft.add(esfa.sum);
      proft=proft+prof[j];
      profa.add(proft);
      if (proft>=profn){
        up=9.81*(proft-profn);
        esfe.add(esft[j]-up);
      }else{
        esfe.add(esft[j]);
      }
    }
    esft.add(0);gam.add(0);
    esft.sort();gam.sort();
    return esfe;
  }
}

class Resultados extends StatelessWidget {
  // const ({Key? key}) : super(key: key);
  ScreenshotController salva = ScreenshotController();//para capturar imagen
  late Uint8List _imageFile; //para salvarla ojo con el ?
  List<double> prof=[], gam=[], esfe=[];
  double proff=0; // mire si este lo usa despues
  int i=0;
  //Para recibir y el this para renombrar las variables
  Resultados(this.prof,this.gam,this.esfe,this.proff, {Key? key}) : super(key: key);
  //Lista
  List<String> nLis =['z(m)','γh(kN/m³)',"σ'v(kPa)"];
  List<String> nLis2 =['z(m)','yh(kN/m)',"o'v(kPa)"];
  //Declaracion lista imagenes
  dynamic nImg = [
    'imagenes/estratos/1.png',
    'imagenes/estratos/2.png',
    'imagenes/estratos/3.png',
    'imagenes/estratos/4.png',
    'imagenes/estratos/5.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultados')
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Screenshot(
                controller: salva,
                child: Container(
                  width: 370,
                  height: 500,
                  child: GraficaLinea(
                      ejX: prof,
                      ejY: esfe,
                      titulo: 'GRAFICA ESFUERZOS EFECTIVOS',
                      tiEjX: 'Profundidad (m)',
                      tiEjY: 'Esfuerzo (kN/m²)'
                  ),
                ),
              ),
              const Center(
                  child: Text('Tabla de resultados', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
              ),
              const SizedBox(height: 10),
              //Titulos
              Table(
                border: TableBorder.all(),
                defaultColumnWidth: const FixedColumnWidth(120),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    children: [
                      for (i = 0; i<3; i++)
                        Container(
                          height: 30,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(color: Colors.grey),
                          child: Text(nLis[i], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                        )
                    ]
                  )
                ]
              ),
              //Generador de datos
              Table(
                border: TableBorder.all(),
                defaultColumnWidth: const FixedColumnWidth(120),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  for (i = 0; i<prof.length; i++) TableRow(
                    decoration: const BoxDecoration(color: Colors.white38),
                    children: [
                      Center(child: Text('${prof[i]}')),
                      Center(child: Text('${gam[i]}')),
                      //generar un list para este
                      Center(child: Text('${esfe[i]}'))
                    ]
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Center(
                  child: Text('Esquema Planteado', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
              ),
              const SizedBox(height: 10),
              for (i = 0; i<(prof.length-1); i++)
                Center(
                    child: SizedBox(
                        height: 80,
                        child: Image.asset(nImg[i])
                    )
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: (){
                    salva.capture().then((value) async {
                    _imageFile = value!;
                    _createPDF();
                    });
                  },
                  child: const Text('Generar PDF'),
                  style: ElevatedButton.styleFrom(primary: const Color(0xFFA72026))
              ),
            ],
          ),
        ),
      ),
    );
  }

//Metodo para crear el pdf
  Future<void>_createPDF() async {
    PdfDocument document = PdfDocument();
    final page = document.pages.add();

    //Agg de pie de pagina y cabeza
    //Create the header with specific bounds
    PdfPageTemplateElement header = PdfPageTemplateElement(
        Rect.fromLTWH(0, 0, document.pageSettings.size.width, 100));

    //Create the date and time field
    PdfDateTimeField dateAndTimeField = PdfDateTimeField(
        font: PdfStandardFont(PdfFontFamily.timesRoman, 12),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)));
    dateAndTimeField.date = DateTime.now();
    dateAndTimeField.dateFormatString = 'MM.dd.yyyy';

    //Create the composite field with date field
    PdfCompositeField compositefields = PdfCompositeField(
        font: PdfStandardFont(PdfFontFamily.timesRoman, 12),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        text: '    Date: {0}                            DISEÑO DE MICROPILOTES                             Project: 0001\n__________________________________________________________________________________ ',
        fields: <PdfAutomaticField>[dateAndTimeField]);

    //Add composite field in header
    compositefields.draw(header.graphics,
        Offset(0, 50 - PdfStandardFont(PdfFontFamily.timesRoman, 11).height));

    //Add the header at top of the document
    document.template.top = header;

    //Create the footer with specific bounds
    PdfPageTemplateElement footer = PdfPageTemplateElement(
        Rect.fromLTWH(0, 0, document.pageSettings.size.width, 50));

    //Create the page number field
    PdfPageNumberField pageNumber = PdfPageNumberField(
        font: PdfStandardFont(PdfFontFamily.timesRoman, 12),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)));

    //Sets the number style for page number
    pageNumber.numberStyle = PdfNumberStyle.upperRoman;

    //Create the page count field
    PdfPageCountField count = PdfPageCountField(
        font: PdfStandardFont(PdfFontFamily.timesRoman, 12),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)));

    //set the number style for page count
    count.numberStyle = PdfNumberStyle.upperRoman;

    //Create the composite field with page number page count
    PdfCompositeField compositeField = PdfCompositeField(
        font: PdfStandardFont(PdfFontFamily.timesRoman, 12),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        text: 'Page {0} of {1}, by DisPi',
        fields: <PdfAutomaticField>[pageNumber, count]);
    compositeField.bounds = footer.bounds;

    //Add the composite field in footer
    compositeField.draw(footer.graphics,
        Offset(400, 50 - PdfStandardFont(PdfFontFamily.timesRoman, 12).height));

    //Add the footer at the bottom of the document
    document.template.bottom = footer;

    //Agg de pie de pagina y cabeza

    page.graphics.drawString('REPORTE DE RESULTADOS',
        PdfStandardFont(PdfFontFamily.helvetica, 30));

    page.graphics.drawImage(
        PdfBitmap(await _readImageData(_imageFile)),
        const Rect.fromLTWH(30, 70, 440, 550));

    PdfGrid grid = PdfGrid();
    grid.style = PdfGridStyle(
      // backgroundBrush: PdfBrushes.lightGray, //para colocar color
        font: PdfStandardFont(PdfFontFamily.helvetica, 30),
        cellPadding: PdfPaddings(left: 5, right: 2, top: 2, bottom: 2));

    grid.columns.add(count: 3);
    grid.headers.add(1);

    PdfGridRow header1 = grid.headers[0];
    for(i=0;i<nLis2.length;i++){
      header1.cells[i].value = nLis2[i];
    }
    header1.style = PdfGridRowStyle(backgroundBrush: PdfBrushes.lightGray);//para colocar color

    PdfGridRow row;
    for (i = 0; i < prof.length; i++) {
      row = grid.rows.add();//Para añadir filas
      //Despues de cada value meter la list a graficar
      row.cells[0].value = prof[i].toString(); //Toca usar el tostring, no acepta numeros
      row.cells[1].value = gam[i].toString();
      row.cells[2].value = esfe[i].toString();
    }
    grid.draw(
        page: document.pages.add(), bounds: const Rect.fromLTWH(0, 0, 0, 0));
    //agg para pruebas
    document.pages.add().graphics.drawString(
        'Hello World!!!', PdfStandardFont(PdfFontFamily.helvetica, 20),
        brush: PdfBrushes.black, bounds: const Rect.fromLTWH(10, 10, 300, 50));

    List<int> bytes = await document.save(); //cuidado que aca metio esta mmada del await
    document.dispose();

    saveAndLaunchFile(bytes, '${dateAndTimeField.date}.pdf');
  }

}

//Este class convierte los datos de la captura para que los lea el pdf
Future<Uint8List> _readImageData(Uint8List name) async {
  final data = name;
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}
//esta class guarda y lanza el archivo
Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
  final path = (await getExternalStorageDirectory())!.path;
  final file = File('$path/$fileName');
  await file.writeAsBytes(bytes, flush: true);
  OpenFile.open('$path/$fileName');
}
//NOTAS ADICIONALES
//se separan los botones para tener mayor orden

//Texto resultado
// Container(
// width: 370,
// height: 70,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.all(Radius.circular(20)),
// gradient: LinearGradient(
// begin: Alignment.topCenter,
// end: Alignment.bottomCenter,
// colors: const [Color(0xFFD0CAB6), Color(0xFFF5E8E8)]
// ) ,
// ),
// child: Center(
// child: Text(
// 'El esfuerzo vertical efectivo obtenido                   '
// 'sobre los $proff mts sera de $proff kN/m² ', //revise aca
// textAlign: TextAlign.center,
// style: TextStyle(
// fontSize: 20,
// fontWeight: FontWeight.bold,
// color: Color(0xFF590E11)
// )
// )
// )
// ),