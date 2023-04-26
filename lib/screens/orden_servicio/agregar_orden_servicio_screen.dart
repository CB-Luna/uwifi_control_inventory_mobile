import 'package:auto_size_text/auto_size_text.dart';
import 'package:diacritic/diacritic.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:stepper_counter_swipe/stepper_counter_swipe.dart';
import 'package:taller_alex_app_asesor/database/entitys.dart';
import 'package:taller_alex_app_asesor/flutter_flow/flutter_flow_theme.dart';
import 'package:taller_alex_app_asesor/helpers/globals.dart';
import 'package:taller_alex_app_asesor/main.dart';
import 'package:taller_alex_app_asesor/providers/database_providers/orden_servicio_controller.dart';
import 'package:taller_alex_app_asesor/screens/orden_servicio/servicio_creado_screen.dart';
import 'package:taller_alex_app_asesor/screens/widgets/flutter_flow_widgets.dart';
import 'package:taller_alex_app_asesor/screens/widgets/get_image_widget.dart';
import 'package:taller_alex_app_asesor/util/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'servicio_no_creado_screen.dart';
export 'servicio_no_creado_screen.dart';

class AgregarOrdenServicioScreen extends StatefulWidget {
  final Vehiculo vehiculo;
  final OrdenTrabajo ordenTrabajo;
  const AgregarOrdenServicioScreen({
      Key? key, 
      required this.vehiculo, 
      required this.ordenTrabajo,
    }) : super(key: key);

  @override
  _AgregarOrdenServicioScreenState createState() =>
      _AgregarOrdenServicioScreenState();
}

class _AgregarOrdenServicioScreenState extends State<AgregarOrdenServicioScreen> {

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final ordenServicioFormKey = GlobalKey<FormState>();
  final _unfocusNode = FocusNode();
  List<String> listaServicios = [];
  List<String> listaProductos = [];

  @override
  void initState() {
    super.initState();
    listaServicios = [];
    for (var element in dataBase.tipoServicioBox.getAll().toList()) {
      listaServicios.add(element.tipoServicio);
    }
    listaServicios.sort((a, b) => removeDiacritics(a).compareTo(removeDiacritics(b)));
    listaProductos = [];
    for (var element in dataBase.tipoProductoBox.getAll().toList()) {
      listaProductos.add(element.tipoProducto);
    }
    listaProductos.sort((a, b) => removeDiacritics(a).compareTo(removeDiacritics(b)));
  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ordenServicioProvider = Provider.of<OrdenServicioController>(context);
    listaServicios.clear();
    listaProductos.clear();
    for (var element in dataBase.tipoServicioBox.getAll().toList()) {
      listaServicios.add(element.tipoServicio);
    }
    listaServicios.sort((a, b) => removeDiacritics(a).compareTo(removeDiacritics(b)));
    for (var element in dataBase.tipoProductoBox.getAll().toList()) {
      listaProductos.add(element.tipoProducto);
    }
    listaProductos.sort((a, b) => removeDiacritics(a).compareTo(removeDiacritics(b)));
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        automaticallyImplyLeading: false,
        title: Text(
          'Registro de Diagnóstico',
          style: FlutterFlowTheme.of(context).title2,
        ),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
            child: InkWell(
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (alertDialogContext) {
                    return AlertDialog(
                      title: const Text(
                          '¿Seguro que quieres abandonar esta pantalla?'),
                      content: const Text(
                          'La información ingresada se perderá.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            ordenServicioProvider.limpiarInformacion();
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child:
                              const Text('Abandonar'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child:
                              const Text('Cancelar'),
                        ),
                      ],
                    );
                  },
                );
                return;
              },
              child: Center(
                child:  Icon(
                  Icons.close_rounded,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
        centerTitle: false,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Form(
            key: ordenServicioFormKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional
                        .fromSTEB(24, 16, 24, 8),
                      child: ExpandableNotifier(
                        initialExpanded: false,
                        child: ExpandablePanel(
                          header: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional
                                    .fromSTEB(0, 0, 8, 0),
                                child: Icon(
                                  Icons.info_rounded,
                                  color: FlutterFlowTheme.of(context)
                                      .primaryColor,
                                  size: 24,
                                ),
                              ),
                              Text(
                                'Detalles del Vehículo',
                                style: FlutterFlowTheme.of(context)
                                    .title1
                                    .override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .title1Family,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      fontSize: 20,
                                    ),
                              ),
                            ],
                          ),
                          collapsed: const Divider(
                            thickness: 1.5,
                            color: Color(0xFF8B8B8B),
                          ),
                          expanded: Container(
                            width: MediaQuery.of(context).size.width *
                                0.9,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).grayLighter,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional
                                  .fromSTEB(5, 0, 5, 0),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional
                                            .fromSTEB(0, 5, 0, 0),
                                    child: Text(
                                      'Marca-Modelo Año',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            fontSize: 15,
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional
                                            .fromSTEB(0, 5, 0, 0),
                                    child: AutoSizeText(
                                      maybeHandleOverflow(
                                          "${widget.vehiculo.marca}-${widget.vehiculo.modelo} ${widget.vehiculo.anio}",
                                          100,
                                          "..."),
                                      textAlign: TextAlign.start,
                                      maxLines: 4,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: FlutterFlowTheme.of(context).tertiaryColor,
                                            fontWeight:
                                                FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional
                                            .fromSTEB(0, 5, 0, 0),
                                    child: Text(
                                      'Motor',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            fontSize: 15,
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional
                                            .fromSTEB(0, 5, 0, 0),
                                    child: Text(
                                      widget.vehiculo.motor,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: FlutterFlowTheme.of(context).tertiaryColor,
                                            fontWeight:
                                                FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional
                                            .fromSTEB(0, 5, 0, 0),
                                    child: Text(
                                      'Placas / VIN',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            fontSize: 15,
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional
                                            .fromSTEB(0, 5, 0, 0),
                                    child: Text(
                                      "${widget.vehiculo.placas} / ${widget.vehiculo.vin}",
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: FlutterFlowTheme.of(context).tertiaryColor,
                                            fontWeight:
                                                FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional
                                            .fromSTEB(0, 5, 0, 0),
                                    child: Text(
                                      'Cliente',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            fontSize: 15,
                                          ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional
                                            .fromSTEB(0, 5, 0, 5),
                                    child: AutoSizeText(
                                      "${widget.vehiculo.cliente.target!.nombre} ${
                                        widget.vehiculo.cliente.target!.apellidoP} ${
                                          widget.vehiculo.cliente.target!.apellidoM}",
                                      textAlign: TextAlign.start,
                                      maxLines: 1,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: FlutterFlowTheme.of(context).tertiaryColor,
                                            fontWeight:
                                                FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          theme: ExpandableThemeData(
                            tapHeaderToExpand: true,
                            tapBodyToExpand: false,
                            tapBodyToCollapse: false,
                            headerAlignment:
                                ExpandablePanelHeaderAlignment.center,
                            hasIcon: true,
                            iconColor:
                                FlutterFlowTheme.of(context).secondaryText,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(16, 6, 16, 16),
                      child: TextFormField(
                        controller: ordenServicioProvider.servicioController,
                        autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                        textCapitalization:
                            TextCapitalization.words,
                        onChanged: (value) {
                            print("Lista de servicios antes de enviar: $listaServicios");
                            ordenServicioProvider.enCambioServicio(value, listaServicios);
                        },
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Servicio*',
                          labelStyle: FlutterFlowTheme.of(context)
                              .title3
                              .override(
                                fontFamily: 'Montserrat',
                                color: FlutterFlowTheme.of(context).grayDark,
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                              ),
                          hintText: 'Ingrese el servicio del vehículo...',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  FlutterFlowTheme.of(context).grayDark,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  FlutterFlowTheme.of(context).primaryColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0x00000000),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0x00000000),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding:
                              const EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                        ),
                        style: FlutterFlowTheme.of(context).bodyText1,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                         validator: (val) {
                          if (val == "" ||
                              val == null) {
                            return 'El servicio del vehículo es requerido.';
                          }
                          return null;
                        },
                      ),
                    ),
                    Visibility(
                      visible: (ordenServicioProvider.servicioController.text.length >= 3 && ordenServicioProvider.opcionesServicios.isNotEmpty && ordenServicioProvider.servicioSeleccionado == "") ? true : false,
                      child: SizedBox(
                        height: 100,
                        child: Material(
                          child: ListView.builder(
                            controller: ScrollController(),
                            itemCount: ordenServicioProvider.opcionesServicios.length,
                            itemBuilder: (_, index) {
                              final servicio = ordenServicioProvider.opcionesServicios[index];
                              return ListTile(
                                leading: Icon(
                                  Icons.car_rental,
                                  color: FlutterFlowTheme.of(context).primaryColor,
                                ),
                                title: Text(servicio),
                                onTap: () {
                                  ordenServicioProvider.seleccionarServicio(servicio);
                                  
                                },
                                hoverColor: Colors.grey[200],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: (ordenServicioProvider.servicioSeleccionado == ordenServicioProvider.servicioController.text && ordenServicioProvider.servicioSeleccionado != ""),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: 200,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).grayLighter,
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 4,
                                    color: Color(0x32000000),
                                    offset: Offset(0, 2),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
                                child:
                                    getImageContainer(
                                      ordenServicioProvider.tipoServicio?.path,
                                      height: 200
                                    ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).grayLighter,
                                    boxShadow: const [
                                      BoxShadow(
                                        blurRadius: 4,
                                        color: Color(0x43000000),
                                        offset: Offset(-4, 8),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional
                                              .all(8),
                                      child: Column(
                                        mainAxisSize:
                                            MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets
                                                    .symmetric(
                                                vertical: 5),
                                            child: Text(
                                              maybeHandleOverflow(
                                                  "${ordenServicioProvider
                                                    .tipoServicio?.tipoServicio}",
                                                  40,
                                                  "..."),
                                              style:
                                                  FlutterFlowTheme.of(
                                                          context)
                                                      .subtitle1
                                                      .override(
                                                        fontFamily: FlutterFlowTheme.of(
                                                                context)
                                                            .subtitle1Family,
                                                        color: FlutterFlowTheme.of(
                                                                context)
                                                            .primaryText,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight
                                                                .w600,
                                                      ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets
                                                    .symmetric(
                                                vertical: 5),
                                            child: Text(
                                              "Costo del Servicio: \$${ordenServicioProvider
                                              .tipoServicio?.costo.toString()}",
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .subtitle1
                                                  .override(
                                                    fontFamily: FlutterFlowTheme.of(
                                                            context)
                                                        .subtitle1Family,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight
                                                            .w600,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsetsDirectional.fromSTEB(10, 12, 5, 12),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Productos requeridos',
                                      style: FlutterFlowTheme.of(context).bodyText2.override(
                                        fontFamily: 'Outfit',
                                        color: FlutterFlowTheme.of(context).primaryText,
                                        fontSize: 20,
                                      ),
                                    ),
                                    FFButtonWidget(
                                      onPressed: () async {
                                        await showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (BuildContext context) {
                                            final ordenServicioProvider = Provider.of<OrdenServicioController>(context);
                                            return AlertDialog(
                                              backgroundColor: FlutterFlowTheme.of(context).grayLighter,
                                              title: const Text("Agregar Producto"),
                                              content: SizedBox( // Need to use container to add size constraint.
                                                width: 300,
                                                height: 400,
                                                child: SingleChildScrollView(
                                                  controller: ScrollController(),
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsetsDirectional.fromSTEB(16, 6, 16, 16),
                                                        child: TextFormField(
                                                          controller: ordenServicioProvider.productoController,
                                                          autovalidateMode:
                                                              AutovalidateMode.onUserInteraction,
                                                          textCapitalization:
                                                              TextCapitalization.words,
                                                          onChanged: (value) {
                                                              ordenServicioProvider.enCambioProducto(value, listaProductos);
                                                          },
                                                          obscureText: false,
                                                          decoration: InputDecoration(
                                                            labelText: 'Producto*',
                                                            labelStyle: FlutterFlowTheme.of(context)
                                                                .title3
                                                                .override(
                                                                  fontFamily: 'Montserrat',
                                                                  color: FlutterFlowTheme.of(context).grayDark,
                                                                  fontSize: 15,
                                                                  fontWeight: FontWeight.normal,
                                                                ),
                                                            enabledBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                color:
                                                                    FlutterFlowTheme.of(context).grayDark,
                                                                width: 2,
                                                              ),
                                                              borderRadius: BorderRadius.circular(8),
                                                            ),
                                                            focusedBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                color:
                                                                    FlutterFlowTheme.of(context).primaryColor,
                                                                width: 2,
                                                              ),
                                                              borderRadius: BorderRadius.circular(8),
                                                            ),
                                                            errorBorder: OutlineInputBorder(
                                                              borderSide: const BorderSide(
                                                                color: Color(0x00000000),
                                                                width: 2,
                                                              ),
                                                              borderRadius: BorderRadius.circular(8),
                                                            ),
                                                            focusedErrorBorder: OutlineInputBorder(
                                                              borderSide: const BorderSide(
                                                                color: Color(0x00000000),
                                                                width: 2,
                                                              ),
                                                              borderRadius: BorderRadius.circular(8),
                                                            ),
                                                            contentPadding:
                                                                const EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                                                          ),
                                                          style: FlutterFlowTheme.of(context).bodyText1,
                                                          textAlign: TextAlign.start,
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                      Visibility(
                                                        visible: (ordenServicioProvider.productoController.text.length >= 3 && ordenServicioProvider.opcionesProductos.isNotEmpty && ordenServicioProvider.productoSeleccionado == "") ? true : false,
                                                        child: SizedBox(
                                                          height: 100,
                                                          child: Material(
                                                            child: ListView.builder(
                                                              controller: ScrollController(),
                                                              itemCount: ordenServicioProvider.opcionesProductos.length,
                                                              itemBuilder: (_, index) {
                                                                final producto = ordenServicioProvider.opcionesProductos[index];
                                                                return ListTile(
                                                                  leading: Icon(
                                                                    Icons.car_rental,
                                                                    color: FlutterFlowTheme.of(context).primaryColor,
                                                                  ),
                                                                  title: Text(producto),
                                                                  onTap: () {
                                                                    ordenServicioProvider.seleccionarProducto(producto);
                                                                  },
                                                                  hoverColor: Colors.grey[200],
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        'Cantidad',
                                                        style: FlutterFlowTheme.of(context).bodyText2.override(
                                                          fontFamily: 'Outfit',
                                                          color: FlutterFlowTheme.of(context).primaryText,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                                                        child: StepperSwipe(
                                                          withPlusMinus: true,
                                                          iconsColor: FlutterFlowTheme.of(context).primaryColor,
                                                          initialValue: ordenServicioProvider.cantidad,
                                                          speedTransitionLimitCount: 3, //Trigger count for fast counting
                                                          onChanged: (int value) {
                                                            ordenServicioProvider.enCambioCantidadProducto(value);
                                                          },
                                                          firstIncrementDuration: const Duration(milliseconds: 250), //Unit time before fast counting
                                                          secondIncrementDuration: const Duration(milliseconds: 100), //Unit time during fast counting
                                                          direction: Axis.horizontal,
                                                          dragButtonColor: FlutterFlowTheme.of(context).primaryColor,
                                                        maxValue: 100,
                                                        minValue: 1, 
                                                        stepperValue: ordenServicioProvider.cantidad,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                                                        child: FFButtonWidget(
                                                          onPressed: () async {
                                                            if (ordenServicioProvider.productoSeleccionado != "") {
                                                              // ordenServicioProvider.productosTemp.add(prod)
                                                              ordenServicioProvider.agregarProductoTemporal();    
                                                              ordenServicioProvider.limpiarInformacionProductos();
                                                              Navigator.pop(context);
                                                            } else {
                                                              snackbarKey.currentState?.showSnackBar(const SnackBar(
                                                                content: Text("Ingresa un producto existente para continuar."),
                                                              ));
                                                            }
                                                          },
                                                          text: 'Aceptar',
                                                          options: FFButtonOptions(
                                                            width: 200,
                                                            height: 50,
                                                            color: ordenServicioProvider.productoSeleccionado != "" ?
                                                              FlutterFlowTheme.of(context).primaryColor
                                                              :
                                                              FlutterFlowTheme.of(context).primaryColor.withOpacity(0.1)
                                                              ,
                                                            textStyle:
                                                                FlutterFlowTheme.of(context).subtitle1.override(
                                                                      fontFamily: 'Lexend Deca',
                                                                      color: Colors.white,
                                                                      fontSize: 18,
                                                                      fontWeight: FontWeight.bold,
                                                                    ),
                                                            elevation: 3,
                                                            borderSide: const BorderSide(
                                                              color: Colors.transparent,
                                                              width: 1,
                                                            ),
                                                            borderRadius: BorderRadius.circular(50),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                                                        child: FFButtonWidget(
                                                          onPressed: () async {   
                                                            ordenServicioProvider.limpiarInformacionProductos();
                                                            Navigator.pop(context);
                                                          },
                                                          text: 'Cancelar',
                                                          options: FFButtonOptions(
                                                            width: 200,
                                                            height: 50,
                                                            color: FlutterFlowTheme
                                                              .of(context).primaryColor,
                                                            textStyle:
                                                                FlutterFlowTheme.of(context).subtitle1.override(
                                                                      fontFamily: 'Lexend Deca',
                                                                      color: Colors.white,
                                                                      fontSize: 18,
                                                                      fontWeight: FontWeight.bold,
                                                                    ),
                                                            elevation: 3,
                                                            borderSide: const BorderSide(
                                                              color: Colors.transparent,
                                                              width: 1,
                                                            ),
                                                            borderRadius: BorderRadius.circular(50),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      text: 'Agregar',
                                      icon: const Icon(
                                        Icons.add,
                                        size: 15,
                                      ),
                                      options: FFButtonOptions(
                                        width: 150,
                                        height: 35,
                                        color: FlutterFlowTheme.of(context).primaryColor,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .subtitle2
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context).subtitle2Family,
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                        borderSide: const BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Builder(
                                builder: (context) {
                                  return ListView.builder(
                                    controller: ScrollController(),
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: ordenServicioProvider.productosTemp.length,
                                    itemBuilder: (context, index) {
                                      final productoTemp = ordenServicioProvider.productosTemp[index];
                                      return InkWell(
                                        onTap: () async {
                                        },
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 16),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsetsDirectional.fromSTEB(
                                                        0, 0, 0, 8),
                                                child: Container(
                                                  width:
                                                      MediaQuery.of(context).size.width *
                                                          0.92,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(context).grayLighter,
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        blurRadius: 4,
                                                        color: Color(0x43000000),
                                                        offset: Offset(-4, 8),
                                                      )
                                                    ],
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(15, 0, 0, 0),
                                                        child: Container(
                                                          width: 35,
                                                          height: 35,
                                                          decoration: BoxDecoration(
                                                            color: FlutterFlowTheme.of(context)
                                                                .secondaryBackground,
                                                            shape: BoxShape.circle,
                                                          ),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize.max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment.center,
                                                            children: [
                                                              Text(
                                                                (index + 1).toString(),
                                                                style:
                                                                    FlutterFlowTheme.of(context)
                                                                        .bodyText1
                                                                        .override(
                                                                          fontFamily: FlutterFlowTheme.of(
                                                                                  context)
                                                                              .bodyText1Family,
                                                                          fontSize: 20,
                                                                        ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .all(8),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Column(
                                                                mainAxisSize:
                                                                    MainAxisSize.max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment.center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment.start,
                                                                children: [
                                                                  Text(
                                                                    maybeHandleOverflow(
                                                                        productoTemp.producto,
                                                                        25,
                                                                        "..."),
                                                                    style:
                                                                        FlutterFlowTheme.of(
                                                                                context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily:
                                                                                  FlutterFlowTheme.of(context)
                                                                                      .bodyText1Family,
                                                                              color: FlutterFlowTheme.of(
                                                                                      context)
                                                                                  .primaryText,
                                                                              fontWeight: FontWeight.w700
                                                                            ),
                                                                  ),
                                                                  Text(
                                                                    "Cantidad: ${productoTemp.cantidad}",
                                                                    style:
                                                                        FlutterFlowTheme.of(
                                                                                context)
                                                                            .bodyText1
                                                                            .override(
                                                                              fontFamily:
                                                                                  FlutterFlowTheme.of(context)
                                                                                      .bodyText1Family,
                                                                              color: FlutterFlowTheme.of(
                                                                                      context)
                                                                                  .secondaryText,
                                                                            ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Text(
                                                                maybeHandleOverflow(
                                                                "\$ ${productoTemp.costo.toStringAsFixed(2)}",
                                                                20,
                                                                "..."),
                                                                style:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyText1
                                                                        .override(
                                                                          fontFamily:
                                                                              FlutterFlowTheme.of(context)
                                                                                  .bodyText1Family,
                                                                          color: FlutterFlowTheme.of(
                                                                                  context)
                                                                              .primaryText,
                                                                          fontWeight: FontWeight.w700
                                                                        ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              onChanged: (value) {
                                ordenServicioProvider.comentarios = value;
                              },
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Comentarios',
                                labelStyle: FlutterFlowTheme.of(context)
                                    .title3
                                    .override(
                                      fontFamily: 'Montserrat',
                                      color: FlutterFlowTheme.of(context).grayDark,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                    ),
                                hintText: 'Ingrese los comentarios del diagnóstico...',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        FlutterFlowTheme.of(context).grayDark,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        FlutterFlowTheme.of(context).primaryColor,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0x00000000),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color(0x00000000),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                contentPadding:
                                    const EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                              ),
                              style: FlutterFlowTheme.of(context).bodyText1,
                              textAlign: TextAlign.start,
                              maxLines: 4,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                            child: TextFormField(
                              controller: ordenServicioProvider.fechaEntregaController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              onTap: () async {
                                await DatePicker.showDatePicker(
                                  context,
                                  locale: LocaleType.es,
                                  showTitleActions: true,
                                  onConfirm: (date) {
                                    setState(() {
                                      ordenServicioProvider.fechaEntrega = date;
                                      ordenServicioProvider.fechaEntregaController = TextEditingController(text: dateTimeFormat('d/MMMM/y', date));
                                    });
                                  },
                                  currentTime: getCurrentTimestamp,
                                );
                              },
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: 'Ingrese la Fecha de Entrega...',
                                enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      FlutterFlowTheme.of(context).lineColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).primaryColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).primaryColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding:
                                  const EdgeInsetsDirectional.fromSTEB(20, 32, 20, 12),
                              suffixIcon: Icon(
                                  Icons.date_range_outlined,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 24,
                                ),
                              ),
                              style: FlutterFlowTheme.of(context).bodyText1,
                              textAlign: TextAlign.start,
                              keyboardType: TextInputType.none,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'La Fecha de Entrega es requerida.';
                                }
                                return null;
                              }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      if (ordenServicioProvider
                              .validateForm(ordenServicioFormKey)) {
                        if (widget.ordenTrabajo.ordenServicio.target == null) {
                          if (ordenServicioProvider.addOrdenServicio(widget.ordenTrabajo)) {
                            ordenServicioProvider.limpiarInformacion();
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ServicioCreadoScreen(ordenTrabajo: widget.ordenTrabajo,),
                              ),
                            );
                          } else {
                            ordenServicioProvider.limpiarInformacion();
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ServicioNoCreadoScreen(ordenTrabajo: widget.ordenTrabajo,),
                              ),
                            );
                          }
                        } else {
                          if (ordenServicioProvider.addServicio(widget.ordenTrabajo.ordenServicio.target!)) {
                            ordenServicioProvider.limpiarInformacion();
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ServicioCreadoScreen(ordenTrabajo: widget.ordenTrabajo,),
                              ),
                            );
                          } else {
                            ordenServicioProvider.limpiarInformacion();
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ServicioNoCreadoScreen(ordenTrabajo: widget.ordenTrabajo,),
                              ),
                            );
                          }
                        }        
                      } else {
                        await showDialog(
                          context: context,
                          builder: (alertDialogContext) {
                            return AlertDialog(
                              title:
                                  const Text('Campos vacíos'),
                              content: const Text(
                                  'Para continuar, debe llenar todos los campos requeridos.'),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(
                                          alertDialogContext),
                                  child: const Text('Bien'),
                                ),
                              ],
                            );
                          },
                        );
                        return;
                      }
                    },
                    text: 'Registrar',
                    options: FFButtonOptions(
                      width: 200,
                      height: 50,
                      color: FlutterFlowTheme.of(context).primaryColor,
                      textStyle:
                        FlutterFlowTheme.of(context).subtitle1.override(
                              fontFamily: 'Lexend Deca',
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                      elevation: 3,
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
