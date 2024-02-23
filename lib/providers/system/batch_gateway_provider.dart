import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:uwifi_control_inventory_mobile/models/gateway_batch.dart';

class BatchGatewayProvider extends ChangeNotifier {

  List<GatewayBatch> gatewaysBatch = [];

  final searchController = TextEditingController();

  bool validateCsvFormat(List<List<dynamic>> csvData) {
    // Aquí puedes realizar validaciones adicionales, como verificar
    // que el archivo tenga los encabezados esperados
    List<String> expectedHeaders = ['Wi-Fi KEY', 'IMEI', 'MAC', "S/N"];
    List<dynamic> headers = csvData.first;

    //En caso de que la posición del header fuera aleatoria, 
    //crearíamos una función para recuperar el índice de cada header
    return headers.length == expectedHeaders.length &&
        List.generate(
            expectedHeaders.length,
            (index) => headers[index].toString().trim() == expectedHeaders[index])
            .every((element) => element == true);
  }


  Future<String> uploadGatewaysBatch() async {
    try {
      gatewaysBatch.clear();
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
      );

      if (result != null) {
        PlatformFile file = result.files.first;
      
        final input = File(file.path!).openRead();
        final rows = await input
              .transform(utf8.decoder)
              .transform(const CsvToListConverter())
            .toList();

        if (rows.first.isEmpty || rows.first.length == 1) {
          return 'Not Rows Data';
        } 
        if (!validateCsvFormat(rows)) {
          return 'Not Valid Format';
        } else {
          //Se quitan los headers
          rows.removeAt(0);
          for (var row in rows) {
            final GatewayBatch gatewayBatch = GatewayBatch(
              wifiKey: row[0].toString(),
              imei: row[1].toString(), 
              mac: row[2].toString(), 
              serialNo: row[3].toString(), 
            );
            gatewaysBatch.add(gatewayBatch);
          }
          notifyListeners();
          return 'Succesfull Upload';
        }  
      } else {
        return 'Not Content';
      }
    } catch (e) {
      print("Error at uploadGatewayBatch: $e");
      return 'Failed Upload Proccess';
    }
  }
  
  bool removeGateway(String serialNumber) {
    try {
      gatewaysBatch.removeWhere((element) => element.serialNo == serialNumber);
      notifyListeners();
      return true;
    } catch (e) {
      print('Error en removeGateway() - $e');
      return false;
    }
  }
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
