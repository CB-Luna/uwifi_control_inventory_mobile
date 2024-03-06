import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';
import 'package:uwifi_control_inventory_mobile/database/entitys.dart';
import 'package:uwifi_control_inventory_mobile/helpers/globals.dart';
import 'package:uwifi_control_inventory_mobile/models/gateway_batch.dart';
import 'package:uwifi_control_inventory_mobile/models/gateway_batch_temp.dart';
import 'package:uwifi_control_inventory_mobile/util/util.dart';

class BatchGatewayProvider extends ChangeNotifier {

  List<GatewayBatch> gatewaysBatch = [];
  List<GatewayBatchTemp> gatewaysBatchTemp = [];
  Uint8List? bytesExcel;
  final searchController = TextEditingController();

  bool validateCsvFormat(List<List<dynamic>> csvData) {
    // Aquí puedes realizar validaciones adicionales, como verificar
    // que el archivo tenga los encabezados esperados
    List<String> expectedHeaders = ['S/N', 'IMEI', 'MAC', 'Wi-Fi KEY'];
    List<dynamic> headers = csvData.first;

    //En caso de que la posición del header fuera aleatoria, 
    //crearíamos una función para recuperar el índice de cada header
    return headers.length == expectedHeaders.length &&
        List.generate(
            expectedHeaders.length,
            (index) => headers[index].toString().trim() == expectedHeaders[index])
            .every((element) => element == true);
  }

  Future<List<List<dynamic>>> uploadFileXLSX(File file) async {
    bytesExcel = await file.readAsBytes();
    var excel = SpreadsheetDecoder.decodeBytes(bytesExcel!);

    // Suponiendo que el archivo XLSX tiene una sola hoja de trabajo
    var hojaTrabajo = excel.tables.keys.first;
    var table = excel.tables[hojaTrabajo];

    if (table != null) {
      return table.rows;
    } else {
      return [];
    }
  }


  Future<String> uploadGatewaysBatch() async {
    try {
      gatewaysBatch.clear();
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx']
      );

      if (result != null) {
      
        final input = File(result.files.single.path!);
        final rows = await uploadFileXLSX(input);

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
              serialNo: row[0].toString(),
              imei: row[1].toString(), 
              mac: row[2].toString(), 
              wifiKey: row[3].toString()
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

  Future<bool> addGatewaysBatch(Users? currentUser) async {
    try {
      gatewaysBatchTemp.clear();
      final fecha = DateTime.now();
      if (bytesExcel != null && currentUser != null) {
        // Subir el documento al bucket de Supabase
        final storageResponse = await supabase.storage.from('batch_documents/gateways').uploadBinary(
          'CIG_${DateFormat('yyyy-MM-dd hh:mm:ss').format(fecha)}_${currentUser.sequentialId}.xlsx',
          bytesExcel!,
        );

        if (storageResponse.isNotEmpty) {
          // Insertar un nuevo registro en la tabla 'document'
          var idDocument = (await supabase.from('batch_document').insert(
            {
              "product_type_fk": 1,
              "user_name": "${currentUser.firstName} ${currentUser.lastName}",
              "document": 'CIG_${DateFormat('yyyy-MM-dd hh:mm:ss').format(fecha)}_${currentUser.sequentialId}.xlsx',
              "sequential_id": currentUser.sequentialId
            },
          ).select())[0]['batch_document_id'];

          if (idDocument != null) {
            //LLamado de API Batch
            var urlAPI = Uri.parse('https://data-analitic.cbluna-dev.com/apigateway/spark/uwifi_ci_batch_gateways');
            final headers = ({
              "Content-Type": "application/json",
            });
            var responseAPI = await post(
              urlAPI,
              headers: headers,
              body: json.encode(
                {
                  "body": {
                      "document_id": idDocument,
                      "sequential_id": currentUser.sequentialId
                  }
                },
              )
            );

            if (!responseAPI.body.contains('Failed')) {
              final res = await supabase
              .from('batch_gateway_temp')
              .select()
              .eq('batch_document_fk', idDocument);

              if (res == null) {
                print('Error en recover addBatchGateways()');
                return false;
              }

              gatewaysBatchTemp = (res as List<dynamic>).map((gatewayBatchTemp) => GatewayBatchTemp.fromMap(gatewayBatchTemp)).toList();
              notifyListeners();
              return true;

            } else {
              return false;
            }
          } else {
            return false;
          }
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
  
  // bool removeGateway(String serialNumber) {
  //   try {
  //     gatewaysBatch.removeWhere((element) => element.serialNo == serialNumber);
  //     notifyListeners();
  //     return true;
  //   } catch (e) {
  //     print('Error en removeGateway() - $e');
  //     return false;
  //   }
  // }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
