import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bizpro_app/theme/theme.dart';

import 'package:bizpro_app/helpers/constants.dart';
import 'package:bizpro_app/util/flutter_flow_util.dart';
import 'package:bizpro_app/screens/jornadas/jornada_creada.dart';
import 'package:bizpro_app/providers/database_providers/jornada_controller.dart';
import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AgregarJornadaScreen extends StatefulWidget {
  final int idEmprendimiento;
  final String nombreEmprendimiento;

  const AgregarJornadaScreen(
      {Key? key,
      required this.idEmprendimiento,
      required this.nombreEmprendimiento})
      : super(key: key);

  @override
  _AgregarJornadaScreenState createState() => _AgregarJornadaScreenState();
}

class _AgregarJornadaScreenState extends State<AgregarJornadaScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final jornadaKey = GlobalKey<FormState>();
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';
  DateTime? selectedDate;
  DateTime dateNow = DateTime.now();
  TextEditingController textControllerFecha = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
            // ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        selectedDate = args.value;
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final jornadaProvider = Provider.of<JornadaController>(context);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color(0xFF008DD4),
        automaticallyImplyLeading: true,
        title: Text(
          'Registrar Jornada',
          style: AppTheme.of(context).bodyText1.override(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontSize: 22,
              ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: const Color(0xFFD9EEF9),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Form(
              key: jornadaKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(20, 15, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Registro de Jornadas',
                          style: AppTheme.of(context).bodyText1.override(
                                fontFamily: 'Poppins',
                                color: const Color(0xFF0D0E0F),
                                fontSize: 16,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(15, 16, 15, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
                          child: TextFormField(
                            readOnly: true,
                            enabled: false,
                            initialValue: widget.nombreEmprendimiento,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Emprendimiento',
                              labelStyle: AppTheme.of(context).title3.override(
                                    fontFamily: 'Montserrat',
                                    color: AppTheme.of(context).secondaryText,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            style: AppTheme.of(context).title3.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
                          child: TextFormField(
                            onChanged: (value) {
                              jornadaProvider.numJornada = value;
                            },
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Número de jornada',
                              labelStyle: AppTheme.of(context).title3.override(
                                    fontFamily: 'Montserrat',
                                    color: AppTheme.of(context).secondaryText,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                              hintText: 'Ingresa el número de jornada...',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFF060606),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFF060606),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: const Color(0xFFF3F2F2),
                            ),
                            style: AppTheme.of(context).title3.override(
                                  fontFamily: 'Poppins',
                                  color: const Color(0xFF060606),
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Para continuar, ingrese el número de jornada.';
                              }
                              return null;
                            },
                          ),
                        ),
                        // Row(
                        //   mainAxisSize: MainAxisSize.max,
                        //   children: [
                        //     Expanded(
                        //       child: Checkbox(
                        //         value: false,
                        //         onChanged: (value) {
                        //           value = value;
                        //         },
                        //         activeColor:
                        //             AppTheme.of(context).primaryColor,
                        //         checkColor: Colors.white,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 10),
                          child: TextFormField(
                            controller: textControllerFecha,
                            obscureText: false,
                            focusNode: FocusNode(), //Only tap event available
                            enableInteractiveSelection:
                                false, //Disable on change event
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Próxima visita',
                              labelStyle: AppTheme.of(context).title3.override(
                                    fontFamily: 'Montserrat',
                                    color: AppTheme.of(context).secondaryText,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                  ),
                              hintText:
                                  'Selecciona fecha de la próxima visita...',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFF060606),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: const Color(0xFF060606),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: const Color(0xFFF3F2F2),
                            ),
                            style: AppTheme.of(context).title3.override(
                                  fontFamily: 'Poppins',
                                  color: const Color(0xFF060606),
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                            validator: (value) {
                              return fechaCharacters.hasMatch(value ?? '')
                                  ? null
                                  : 'Para continuar, ingrese una fecha dd/MM/yyyy';
                            },
                            onTap: () {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (_) {
                                  return AlertDialog(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(32.0)),
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    contentPadding: const EdgeInsets.all(0),
                                    content: SizedBox(
                                      width: 400,
                                      height: 400,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            "Seleccione una fecha disponible",
                                            style: AppTheme.of(context)
                                                .title3
                                                .override(
                                                  fontFamily: 'Poppins',
                                                  color:
                                                      const Color(0xFF060606),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                          ),
                                          SfDateRangePicker(
                                            showNavigationArrow: true,
                                            onSelectionChanged:
                                                _onSelectionChanged,
                                            initialSelectedDate: dateNow
                                                .add(const Duration(days: 1)),
                                            enablePastDates: false,
                                            maxDate: dateNow
                                                .add(const Duration(days: 100)),
                                            selectionMode:
                                                DateRangePickerSelectionMode
                                                    .single,
                                            selectableDayPredicate:
                                                (DateTime dateTime) {
                                              return dateTime.weekday == 6 ||
                                                      dateTime.weekday == 7
                                                  ? false
                                                  : true;
                                            },
                                          ),
                                          FFButtonWidget(
                                            onPressed: () {
                                              if (selectedDate != null) {
                                                jornadaProvider.proximaVisita =
                                                    selectedDate!;
                                                textControllerFecha.text =
                                                    DateFormat("dd/MM/yyyy")
                                                        .format(selectedDate!);
                                                Navigator.of(context).pop();
                                              }
                                            },
                                            text: 'Aceptar',
                                            options: FFButtonOptions(
                                              width: 150,
                                              height: 40,
                                              color: AppTheme.of(context)
                                                  .primaryColor,
                                              textStyle: AppTheme.of(context)
                                                  .subtitle2
                                                  .override(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                  ),
                                              borderSide: const BorderSide(
                                                color: Colors.transparent,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
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
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FFButtonWidget(
                          onPressed: () async {
                            if (jornadaProvider.validateForm(jornadaKey)) {
                              jornadaProvider.add(widget.idEmprendimiento);
                              // emprendimientoProvider.updateEmprendedores(widget.idEmprendimiento, emprendedorProvider.emprendedores[emprendedorProvider.emprendedores.length - 1]);
                              jornadaProvider.clearInformation();
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const JornadaCreada(),
                                ),
                              );
                            } else {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: const Text('Campos vacíos'),
                                    content: const Text(
                                        'Para continuar, debe llenar todos los campos'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: const Text('Bien'),
                                      ),
                                    ],
                                  );
                                },
                              );
                              return;
                            }
                          },
                          text: 'Agregar Jornada',
                          icon: const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 15,
                          ),
                          options: FFButtonOptions(
                            width: 290,
                            height: 50,
                            color: const Color(0xFF2CC3F4),
                            textStyle: AppTheme.of(context).title3.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                ),
                            elevation: 3,
                            borderSide: const BorderSide(
                              color: Color(0xFF2CC3F4),
                              width: 0,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
