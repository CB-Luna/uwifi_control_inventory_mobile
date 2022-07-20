import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SelectImageProvider extends ChangeNotifier {


  //Image data
  bool fileSelected = false;
  String fileName = "";
  // late Uint8List fileBytes;


  void pickFiles() async {
    FilePickerResult? result;
    result = await FilePicker.platform.pickFiles(
      allowMultiple: false, 
      type: FileType.custom, 
      allowedExtensions: ['jpg', 'png', 'jpeg'] );
      checkFileName(result);
  }

  void checkFileName(result) {
    if (result != null) {
      fileSelected = true;
      fileName = result.files.first.name;
      // fileBytes = result.files.first.bytes; 
      // Upload file
      //await FirebaseStorage.instance.ref('uploads/$fileName').putData(fileBytes);
      }
    else{
      fileSelected = false;
      fileName = '';
    }
    notifyListeners();
  }

  void cleanLastBillFile() {
    fileSelected = false;
    // fileBytes.clear();
    fileName = "";
    notifyListeners();
  }

  void changeLastBillFile(String xFileName, Uint8List bytes) {
    fileSelected = true;
    // fileBytes = bytes;
    fileName = "LastBillPicture.jpeg";
    notifyListeners();
  }

    uploadFileLastBill(){
    // print("+++FileName: $fileName");
    // print("+++FileBytes: $fileBytes");
    // Map<String, String> headers = {};
    // var postUri = Uri.parse('/planbuilder/port/upload/$fileName');
    // var request = http.MultipartRequest("POST", postUri);
    // //add file to request
    // request.files.add(http.MultipartFile.fromBytes('file', fileBytes));
    // //add headers
    // request.headers.addAll(headers);
    // //send request
    // request.send().then((response) {
    // if (response.statusCode == 200) print("Uploaded!");
    
    // print("****** Status Code:  ${response.statusCode} *********");
    
    // });

}

}