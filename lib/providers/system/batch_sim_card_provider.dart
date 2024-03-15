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
import 'package:uwifi_control_inventory_mobile/models/sims_card_batch.dart';
import 'package:uwifi_control_inventory_mobile/models/sims_card_batch_temp.dart';
import 'package:uwifi_control_inventory_mobile/util/util.dart';

class BatchSimCardProvider extends ChangeNotifier {

  List<SimsCardBatch> simsCardBatch = [];
  List<SimCardBatchTemp> simsCardBatchTemp = [];
  Uint8List? bytesExcel;

  final searchController = TextEditingController();
  final noRecordsController = TextEditingController();

  bool validateKeyForm(GlobalKey<FormState> formKey) {
    return formKey.currentState!.validate() ? true : false;
  }

  bool validateXLSXFormat(List<List<dynamic>> xlsxData) {
    // Aquí puedes realizar validaciones adicionales, como verificar
    // que el archivo tenga los encabezados esperados
    List<String> expectedHeaders = ['IMEI', 'SAP ID', 'PUK CODE', 'PROVIDER'];
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
      // Eliminar la primera fila vacía
      return table.rows;
    } else {
      return [];
    }
  }

  Future<String> uploadSimsCardBatch() async {
    try {
      simsCardBatch.clear();
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
        if (!validateXLSXFormat(rows)) {
          return 'Not Valid Format';
        } else {
          //Se quitan los headers
          rows.removeAt(0);
          if (rows.length != int.parse(noRecordsController.text)) {
            return 'Not Same No. Records';
          } 
          for (var row in rows) {
            final SimsCardBatch simCardBatch = SimsCardBatch(
              imei: row[0].toString(), 
              sapId: row[1].toString(),
              pukCode: row[2].toString(),
              provider: row[3].toString()
            );
            simsCardBatch.add(simCardBatch);
          }
          notifyListeners();
          return 'Succesfull Upload';
        }  
      } else {
        return 'Not Content';
      }
    } catch (e) {
      print("Error at uploadSimsCardBatch: $e");
      return 'Failed Upload Proccess';
    }
  }

  Future<bool> addSimsCardBatchUploaded(Users? currentUser) async {
    try {
      simsCardBatchTemp.clear();
      final fecha = DateTime.now();
      if (bytesExcel != null && currentUser != null) {
        // Subir el documento al bucket de Supabase
        final storageResponse = await supabase.storage.from('batch_documents/sims_card').uploadBinary(
          'CIG_${DateFormat('yyyy-MM-dd hh:mm:ss').format(fecha)}_${currentUser.sequentialId}.xlsx',
          bytesExcel!,
        );

        if (storageResponse.isNotEmpty) {
          // Insertar un nuevo registro en la tabla 'document'
          var idDocument = (await supabase.from('batch_document').insert(
            {
              "product_type_fk": 2,
              "user_name": "${currentUser.firstName} ${currentUser.lastName}",
              "document": 'CIG_${DateFormat('yyyy-MM-dd hh:mm:ss').format(fecha)}_${currentUser.sequentialId}.xlsx',
              "sequential_id": currentUser.sequentialId
            },
          ).select())[0]['batch_document_id'];

          if (idDocument != null) {
            //LLamado de API Batch
            var urlAPI = Uri.parse('https://data-analitic.cbluna-dev.com/apigateway/spark/uwifi_ci_batch_sims_card');
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
              .from('batch_sim_card_temp')
              .select()
              .eq('batch_document_fk', idDocument);

              if (res == null) {
                print('Error en recover addBatchSimsCard()');
                return false;
              }

              simsCardBatchTemp = (res as List<dynamic>).map((simCardTemp) => SimCardBatchTemp.fromMap(simCardTemp)).toList();
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
  
  Future<bool> addSimsCardBatchCreated(Users? currentUser) async {
    try {
      bytesExcel = null;
      simsCardBatchTemp.clear();
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
      cellT1.value = const TextCellValue("IMEI");
      cellT1.cellStyle = titulo;

      var cellT2 = sheet.cell(CellIndex.indexByString("B1"));
      cellT2.value = const TextCellValue("SAP ID");
      cellT2.cellStyle = titulo;

      var cellT3 = sheet.cell(CellIndex.indexByString("C1"));
      cellT3.value = const TextCellValue("PUK CODE");
      cellT3.cellStyle = titulo;

      var cellT4 = sheet.cell(CellIndex.indexByString("D1"));
      cellT4.value = const TextCellValue("PROVIDER");
      cellT4.cellStyle = titulo;

      //Agregar primera linea
      sheet.appendRow([]);

      //Agregar datos
      for (int i = 0; i < simsCardBatch.length; i++) {
        //Sortear por Compania

        SimsCardBatch simCardBatch = simsCardBatch[i];

        final List<CellValue> row = [
          TextCellValue(simCardBatch.imei),
          TextCellValue(simCardBatch.sapId ?? ""),
          TextCellValue(simCardBatch.pukCode ?? ""),
          TextCellValue(simCardBatch.provider)
        ];
        sheet.appendRow(row);
      }

      // Codificar el archivo Excel
      final fileBytes = excel.encode();
      // Convertir a Uint8List?
      bytesExcel = fileBytes != null ? Uint8List.fromList(fileBytes) : null;

      if (bytesExcel != null && currentUser != null) {
        // Subir el documento al bucket de Supabase
        final storageResponse = await supabase.storage.from('batch_documents/sims_card').uploadBinary(
          'CIG_${DateFormat('yyyy-MM-dd hh:mm:ss').format(fecha)}_${currentUser.sequentialId}.xlsx',
          bytesExcel!,
        );

        if (storageResponse.isNotEmpty) {
          // Insertar un nuevo registro en la tabla 'document'
          var idDocument = (await supabase.from('batch_document').insert(
            {
              "product_type_fk": 2,
              "user_name": "${currentUser.firstName} ${currentUser.lastName}",
              "document": 'CIG_${DateFormat('yyyy-MM-dd hh:mm:ss').format(fecha)}_${currentUser.sequentialId}.xlsx',
              "sequential_id": currentUser.sequentialId
            },
          ).select())[0]['batch_document_id'];

          if (idDocument != null) {
            //LLamado de API Batch
            var urlAPI = Uri.parse('https://data-analitic.cbluna-dev.com/apigateway/spark/uwifi_ci_batch_sims_card');
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
              .from('batch_sim_card_temp')
              .select()
              .eq('batch_document_fk', idDocument);

              if (res == null) {
                print('Error en recover addBatchSimsCardCreated()');
                return false;
              }

              simsCardBatchTemp = (res as List<dynamic>).map((simCardBatchTemp) => SimCardBatchTemp.fromMap(simCardBatchTemp)).toList();
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

  String addNewSimsCardBatch(SimsCardBatch? simCardBatch) {
    try {
      if (simCardBatch != null) {
        // Verificar si el objeto ya existe en la lista
        final exists = simsCardBatch.any((element) => element.imei == simCardBatch.imei);
        if (exists) {
          return "Duplicate";
        }
        simsCardBatch.add(simCardBatch);
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
    simsCardBatch.clear();
    simsCardBatchTemp.clear();
    searchController.clear();
  }

  void clearNoRecordController() {
    noRecordsController.clear();
  }

  bool removeSimCardBatch(String imei) {
    try {
      simsCardBatch.removeWhere((element) => element.imei == imei);
      notifyListeners();
      return true;
    } catch (e) {
      print('Error en removeSimCard() - $e');
      return false;
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
