import 'package:bizpro_app/screens/widgets/flutter_flow_widgets.dart';
import 'package:bizpro_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CustomDateTime extends StatefulWidget {
  DateTime fecha;

  CustomDateTime({
    Key? key,
    required this.fecha,
  }) : super(key: key);

  @override
  CustomDateTimeState createState() => CustomDateTimeState();
}

class CustomDateTimeState extends State<CustomDateTime> {
  DateTime? selectedDate;
  DateTime dateNow = DateTime.now();
  String formattedDate = '';

  @override
  Widget build(BuildContext context) {
    final dateCharacters = RegExp(
        r'^(((0[13-9]|1[012])[-/]?(0[1-9]|[12][0-9]|30)|(0[13578]|1[02])[-/]?31|02[-/]?(0[1-9]|1[0-9]|2[0-8]))[-/]?[0-9]{4}|02[-/]?29[-/]?([0-9]{2}(([2468][048]|[02468][48])|[13579][26])|([13579][26]|[02468][048]|0[0-9]|1[0-6])00))$');
    return TextFormField(
      obscureText: false,
      focusNode: FocusNode(), //Only tap event available
      enableInteractiveSelection: false, //Disable on change event
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Próxima visita',
        labelStyle: AppTheme.of(context).title3.override(
              fontFamily: 'Montserrat',
              color: AppTheme.of(context).secondaryText,
              fontSize: 15,
              fontWeight: FontWeight.normal,
            ),
        hintText: 'Selecciona fecha de la próxima visita...',
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
      validator: (value) {
        return dateCharacters.hasMatch(value ?? '')
            ? null
            : 'Para continuar, ingrese una fecha MM/dd/yyyy';
      },
      onTap: () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
              ),
              clipBehavior: Clip.antiAlias,
              contentPadding: const EdgeInsets.all(0),
              content: SizedBox(
                width: 400,
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Seleccione una fecha disponible",
                      style: GoogleFonts.workSans(
                          color: const Color(0xff2E5899),
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                    ),
                    SfDateRangePicker(
                      showNavigationArrow: true,
                      onSelectionChanged: _onSelectionChanged,
                      initialSelectedDate: dateNow.add(const Duration(days: 1)),
                      enablePastDates: false,
                      maxDate: dateNow.add(const Duration(days: 100)),
                      selectionMode: DateRangePickerSelectionMode.single,
                      selectableDayPredicate: (DateTime dateTime) {
                        return dateTime.weekday == 6 || dateTime.weekday == 7
                            ? false
                            : true;
                      },
                    ),
                    FFButtonWidget(
                      onPressed: () {
                        if (selectedDate != null) {
                          widget.fecha = selectedDate!;
                          formattedDate =
                              DateFormat("MM/dd/yyyy").format(selectedDate!);
                          Navigator.of(context).pop();
                        }
                      },
                      text: 'Aceptar',
                      options: FFButtonOptions(
                        width: 150,
                        height: 40,
                        color: AppTheme.of(context).primaryColor,
                        textStyle: AppTheme.of(context).subtitle2.override(
                              fontFamily: 'Poppins',
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
            );
          },
        );
      },
    );
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
      } else if (args.value is DateTime) {
        selectedDate = args.value;
      } else if (args.value is List<DateTime>) {
      } else {
      }
    });
  }
}
