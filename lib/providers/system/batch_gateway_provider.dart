import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:excel/excel.dart';
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
  final noRecordsController = TextEditingController();

  bool validateKeyForm(GlobalKey<FormState> formKey) {
    return formKey.currentState!.validate() ? true : false;
  }

  bool validateXLSXFormat(List<List<dynamic>> xlsxData) {
    // Aquí puedes realizar validaciones adicionales, como verificar
    // que el archivo tenga los encabezados esperados
    List<String> expectedHeaders = ['S/N', 'IMEI', 'MAC', 'Wi-Fi KEY'];
    List<dynamic> headers = xlsxData.first;

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

        if (!validateXLSXFormat(rows)) {
          return 'Not Valid Format';
        } else {
          //Se quitan los headers
          rows.removeAt(0);
          if (rows.length != int.parse(noRecordsController.text)) {
            return 'Not Same No. Records';
          } 
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

  Future<bool> addGatewaysBatchUploaded(Users? currentUser) async {
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

    Future<bool> addGatewaysBatchCreated(Users? currentUser) async {
    try {
      bytesExcel = null;
      gatewaysBatchTemp.clear();
      final fecha = DateTime.now();
      //Crear excel
      Excel excel = Excel.createExcel();
      Sheet? sheet = excel.sheets[excel.getDefaultSheet()];

      if (sheet == null) return false;

      //Ajusta ancho de columnas

      // sheet.setColumnWidth(1, 30);
      // sheet.setColumnWidth(2, 30);

      // Agregar encabezados
      CellStyle titulo = CellStyle(
        fontFamily: getFontFamily(FontFamily.Calibri),
        fontSize: 16,
        bold: true,
        horizontalAlign: HorizontalAlign.Center,
        verticalAlign: VerticalAlign.Center,
      );
      var cellT1 = sheet.cell(CellIndex.indexByString("A1"));
      cellT1.value = const TextCellValue("S/N");
      cellT1.cellStyle = titulo;

      var cellT2 = sheet.cell(CellIndex.indexByString("B1"));
      cellT2.value = const TextCellValue("IMEI");
      cellT2.cellStyle = titulo;

      var cellT3 = sheet.cell(CellIndex.indexByString("C1"));
      cellT3.value = const TextCellValue("MAC");
      cellT3.cellStyle = titulo;

      var cellT4 = sheet.cell(CellIndex.indexByString("D1"));
      cellT4.value = const TextCellValue("Wi-Fi KEY");
      cellT4.cellStyle = titulo;

      //Agregar primera linea
      sheet.appendRow([]);

      //Agregar datos
      for (int i = 0; i < gatewaysBatch.length; i++) {
        //Sortear por Compania

        GatewayBatch gatewayBatch = gatewaysBatch[i];

        final List<CellValue> row = [
          TextCellValue(gatewayBatch.serialNo),
          TextCellValue(gatewayBatch.imei),
          TextCellValue(gatewayBatch.mac),
          TextCellValue(gatewayBatch.wifiKey)
        ];
        sheet.appendRow(row);
      }

      // Codificar el archivo Excel
      final fileBytes = excel.encode();
      // Convertir a Uint8List?
      bytesExcel = fileBytes != null ? Uint8List.fromList(fileBytes) : null;

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

  String addNewGatewayBatch(GatewayBatch? gatewayBatch) {
    try {
      if (gatewayBatch != null) {
        // Verificar si el objeto ya existe en la lista
        final exists = gatewaysBatch.any((element) => element.serialNo == gatewayBatch.serialNo);
        if (exists) {
          return "Duplicate";
        }
        gatewaysBatch.add(gatewayBatch);
        return "True";
      } else {
        return "False";
      }
    } catch (e) {
      return "$e";
    }
  }

  void clearData() {
    bytesExcel == null;
    gatewaysBatch.clear();
    gatewaysBatchTemp.clear();
    searchController.clear();
  }

  void clearNoRecordController() {
    noRecordsController.clear();
  }
  
  bool removeGatewayBatch(String serialNumber) {
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
