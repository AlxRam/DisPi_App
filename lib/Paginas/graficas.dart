import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

//GRAFICA PARA ESFUERZOS
class GraficaLinea extends StatefulWidget {
  GraficaLinea({required this.ejX, required this.ejY, required this.titulo, required this.tiEjX, required this.tiEjY});
  final List<double> ejX, ejY;
  final String titulo, tiEjX, tiEjY;

  @override
  _GraficaLineaState createState() => _GraficaLineaState();
}

class _GraficaLineaState extends State<GraficaLinea> {
  int i = 0;
  late List<SalesData> _chartData;
  late TooltipBehavior _tooltipBehavior;
  late CrosshairBehavior _crosshairBehavior;
  late ZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    _crosshairBehavior = CrosshairBehavior(enable:true,hideDelay: 3000);
    _zoomPanBehavior = ZoomPanBehavior(enablePinching: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SfCartesianChart(
              // legend: Legend(isVisible: true), //para meter la leyenda
                title: ChartTitle(text: widget.titulo),
                zoomPanBehavior: _zoomPanBehavior,
                crosshairBehavior: _crosshairBehavior,
                tooltipBehavior: _tooltipBehavior,
                series: <ChartSeries>[
                  LineSeries<SalesData, double>(
                      name: 'Grafica Lineal',
                      dataSource: _chartData,
                      xValueMapper: (SalesData sales, _) => sales.ejeX,
                      yValueMapper: (SalesData sales, _) => sales.ejeY,
                      //Para poner los puntos
                      markerSettings: const MarkerSettings(
                          isVisible: true,
                          color: Colors.blueAccent
                      ),
                      dataLabelSettings: const DataLabelSettings(
                          isVisible: true,
                          showZeroValue: false,
                          labelAlignment: ChartDataLabelAlignment.top,
                          offset: Offset(0, 10)
                      ),
                      enableTooltip: true)
                ],
                primaryXAxis: NumericAxis(
                  title: AxisTitle(text: widget.tiEjX),
                  interactiveTooltip: const InteractiveTooltip(enable: true),
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                ),
                primaryYAxis: NumericAxis(
                  title: AxisTitle(text: widget.tiEjY),
                  interactiveTooltip: const InteractiveTooltip(enable: true),
                )
            )
        )
    );
  }
// Con esto recibe los datos a graficar
  List<SalesData> getChartData() {
    List<SalesData> chartData = [
      for(i=0;i<(widget.ejX.length);i++)
        SalesData(widget.ejX[i], widget.ejY[i]),
    ];
    return chartData;
  }
}
//este comunica los datos con el widget
class SalesData {
  SalesData(this.ejeX, this.ejeY);
  final double ejeX;
  final double ejeY;
}


//GRAFICA PARA DISEÑO ESTRUCTURAL
class GraficaArea extends StatefulWidget {
  GraficaArea(this.pc,this.pt,this.pce,this.pcs,this.pte,this.pts,this.pg,this.on,this.ou,{Key? key}) : super(key: key);
  double pc = 0, pt = 0, pce = 0, pcs = 0, pte = 0, pts = 0, pg = 0, on = 0, ou = 0;
  @override
  _GraficaAreaState createState() => _GraficaAreaState();
}

class _GraficaAreaState extends State<GraficaArea> {
  late List<_ChartData> falla;
  late List<_ChartData> calculados;
  late TooltipBehavior _tooltip;
  late ZoomPanBehavior _zoomPanBehavior;


  @override
  void initState() {
    falla = [ //calulado la otra sera estado limite o permitido
      _ChartData('Pc\n(Enc.)', widget.pc),
      _ChartData('Pc\n(S.C.)', widget.pc),
      _ChartData('Pt\n(Enc.)', widget.pt),
      _ChartData('Pt\n(S.C.)', widget.pt),
      _ChartData('Pg', widget.pc),
      _ChartData('σ', widget.ou)
    ];
    calculados = [ //calulado la otra sera estado limite o permitido
      _ChartData('Pc\n(Enc.)', widget.pce),
      _ChartData('Pc\n(S.C.)', widget.pcs),
      _ChartData('Pt\n(Enc.)', widget.pte),
      _ChartData('Pt\n(S.C.)', widget.pts),
      _ChartData('Pg', widget.pg),
      _ChartData('σ', widget.on)
    ];
    _tooltip = TooltipBehavior(enable: true);
    _zoomPanBehavior = ZoomPanBehavior(enablePinching: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
            primaryXAxis: CategoryAxis(title: AxisTitle(text: 'Chequeos')),
            primaryYAxis: NumericAxis(title: AxisTitle(text: 'Capacidad (kN)'), minimum: 0, maximum: widget.pce*1.20, interval: 100),
            tooltipBehavior: _tooltip,
            zoomPanBehavior: _zoomPanBehavior,
            legend: Legend(
                isVisible: true,
                position: LegendPosition.top,
                offset: Offset(110,0),
                width: '50%',
                borderWidth: 1.5,
                borderColor: Colors.black,
                backgroundColor: Colors.white,
                overflowMode: LegendItemOverflowMode.wrap
            ),
            series: <ChartSeries<_ChartData, String>>[
              AreaSeries<_ChartData, String>(
                  dataSource: falla,
                  xValueMapper: (_ChartData data, _) => data.x,
                  yValueMapper: (_ChartData data, _) => data.y,
                  name: 'Falla',
                  opacity: 0.5,
                  borderColor: Color(0xFFA72026),
                  borderWidth: 2.25,
                  color: Color(0xFFA72026),//Color(0xFF6ABCFF),
                  markerSettings: const MarkerSettings(
                      isVisible: true,
                      color: Color(0xFF770508)
                  ),
              ),
              AreaSeries<_ChartData, String>(
                  dataSource: calculados,
                  xValueMapper: (_ChartData data, _) => data.x,
                  yValueMapper: (_ChartData data, _) => data.y,
                  name: 'Calculado',
                  opacity: 0.5,
                  borderColor: Color(0xFF29A3FF),
                  borderWidth: 2.25,
                  color: Color(0xFF6ABCFF),//Color(0xFF6ABCFF), //defina si azul o verde
                  markerSettings: const MarkerSettings(
                      isVisible: true,
                      color: Color(0xFF0F8DFC)
                  ),
              ),
            ],
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}

//GRAFICA PARA ASENTAMIENTOS
class GraficaAsenta extends StatefulWidget {
  GraficaAsenta(this.eac, this.eas, this.pc, this.lup, this.lb);
  double eac = 0, eas = 0, pc = 0, lup = 0, lb = 0, atc = 0, ats = 0;

  @override
  _GraficaAsentaState createState() => _GraficaAsentaState();
}

class _GraficaAsentaState extends State<GraficaAsenta> {
  late TooltipBehavior _tooltipBehavior;
  late CrosshairBehavior _crosshairBehavior;
  late ZoomPanBehavior _zoomPanBehavior;
  late List<AseData> encami;
  late List<AseData> sincami;
  late List<AseData> total;

  @override
  void initState() {
    double calculo(double pc){
      widget.atc = pc*widget.pc*widget.lup/widget.eac*-1000;
      return widget.atc;
    }
    double calcu(double pc){
      widget.ats = pc*widget.pc*widget.lb/widget.eas*-1000;
      return widget.ats;
    }
    encami = [
      AseData(0, 0),
      AseData(widget.pc*0.1, calculo(0.1)),
      AseData(widget.pc*0.2, calculo(0.2)),
      AseData(widget.pc*0.3, calculo(0.3)),
      AseData(widget.pc*0.4, calculo(0.4)),
      AseData(widget.pc*0.5, calculo(0.5)),
      AseData(widget.pc*0.6, calculo(0.6)),
      AseData(widget.pc*0.7, calculo(0.7)),
      AseData(widget.pc*0.8, calculo(0.8)),
      AseData(widget.pc*0.9, calculo(0.9)),
      AseData(widget.pc, calculo(1)),
    ];
    sincami = [
      AseData(0, 0),
      AseData(widget.pc*0.1, calcu(0.1)),
      AseData(widget.pc*0.2, calcu(0.2)),
      AseData(widget.pc*0.3, calcu(0.3)),
      AseData(widget.pc*0.4, calcu(0.4)),
      AseData(widget.pc*0.5, calcu(0.5)),
      AseData(widget.pc*0.6, calcu(0.6)),
      AseData(widget.pc*0.7, calcu(0.7)),
      AseData(widget.pc*0.8, calcu(0.8)),
      AseData(widget.pc*0.9, calcu(0.9)),
      AseData(widget.pc, calcu(1)),
    ];
    total = [
      AseData(0, 0),
      AseData(widget.pc*0.1, calcu(0.1)+calculo(0.1)),
      AseData(widget.pc*0.2, calcu(0.2)+calculo(0.2)),
      AseData(widget.pc*0.3, calcu(0.3)+calculo(0.3)),
      AseData(widget.pc*0.4, calcu(0.4)+calculo(0.4)),
      AseData(widget.pc*0.5, calcu(0.5)+calculo(0.5)),
      AseData(widget.pc*0.6, calcu(0.6)+calculo(0.6)),
      AseData(widget.pc*0.7, calcu(0.7)+calculo(0.7)),
      AseData(widget.pc*0.8, calcu(0.8)+calculo(0.8)),
      AseData(widget.pc*0.9, calcu(0.9)+calculo(0.9)),
      AseData(widget.pc, calcu(1)+calculo(1)),
    ];
    _tooltipBehavior = TooltipBehavior(enable: true);
    _crosshairBehavior = CrosshairBehavior(enable:true,hideDelay: 3000);
    _zoomPanBehavior = ZoomPanBehavior(enablePinching: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
            zoomPanBehavior: _zoomPanBehavior,
            crosshairBehavior: _crosshairBehavior,
            tooltipBehavior: _tooltipBehavior,
            primaryXAxis: NumericAxis(
              title: AxisTitle(text: 'Carga (kN)'),
              interactiveTooltip: const InteractiveTooltip(enable: true),
              edgeLabelPlacement: EdgeLabelPlacement.shift,
              opposedPosition: true,
              minimum: 0,
              maximum: widget.pc*1.1,
              interval: 150,
            ),
            primaryYAxis: NumericAxis(
              title: AxisTitle(text: 'Asentamiento (mm)'),
              interactiveTooltip: const InteractiveTooltip(enable: true),
            ),
            legend: Legend(
                isVisible: true,
                position: LegendPosition.top,
                offset: const Offset(-40,250),
                width: '50%',
                borderWidth: 1.5,
                borderColor: Colors.black,
                backgroundColor: Colors.white,
                overflowMode: LegendItemOverflowMode.wrap
            ),
            series: <ChartSeries>[
              LineSeries<AseData, double>(
                  name: 'Δt Enc.',
                  dataSource: encami,
                  xValueMapper: (AseData data, _) => data.ejeX,
                  yValueMapper: (AseData data, _) => data.ejeY,
                  enableTooltip: true,
                  color: Color(0xFF177BE0),
                  markerSettings: const MarkerSettings(
                      width: 5,
                      height: 5,
                      isVisible: true,
                      color: Colors.blueAccent
                  )
              ),
              LineSeries<AseData, double>(
                  name: 'Δt S.C.',
                  dataSource: sincami,
                  xValueMapper: (AseData data, _) => data.ejeX,
                  yValueMapper: (AseData data, _) => data.ejeY,
                  enableTooltip: true,
                  color: Color(0xFFDC0000),
                  markerSettings: const MarkerSettings(
                      width: 5,
                      height: 5,
                      isVisible: true,
                      color: Color(0xFFE13030)
                  )
              ),
              LineSeries<AseData, double>(
                  name: 'Δt Total',
                  dataSource: total,
                  xValueMapper: (AseData data, _) => data.ejeX,
                  yValueMapper: (AseData data, _) => data.ejeY,
                  enableTooltip: true,
                  color: Color(0xFF4A1AAB),
                  markerSettings: const MarkerSettings(
                      width: 5,
                      height: 5,
                      isVisible: true,
                      color: Color(0xFF5F25FF)
                  )
              )
            ]

    );
  }
}
//este comunica los datos con el widget
class AseData {
  AseData(this.ejeX, this.ejeY);
  final double ejeX;
  final double ejeY;
}