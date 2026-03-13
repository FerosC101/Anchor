import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  StorageService({FirebaseStorage? storage})
      : _storage = storage ?? FirebaseStorage.instance;

  final FirebaseStorage _storage;

  Future<String> uploadContractFile({
    required String userId,
    required String contractId,
    String? filePath,
    Uint8List? fileBytes,
    required String fileName,
  }) async {
    final ext = _fileExtension(fileName);
    final normalizedName = fileName.replaceAll(RegExp(r'\s+'), '_');
    final ref = _storage
        .ref()
        .child('contracts')
        .child(userId)
        .child('$contractId-$normalizedName');

    final metadata = SettableMetadata(
      contentType: _contentTypeFromExtension(ext),
    );

    if (kIsWeb) {
      if (fileBytes == null) {
        throw const FormatException(
            'Missing selected file bytes for web upload.');
      }
      await ref.putData(fileBytes, metadata);
    } else {
      if (filePath == null || filePath.isEmpty) {
        throw const FormatException('Missing selected file path for upload.');
      }
      await ref.putFile(File(filePath), metadata);
    }

    return ref.getDownloadURL();
  }

  String _fileExtension(String fileName) {
    final dotIndex = fileName.lastIndexOf('.');
    if (dotIndex == -1 || dotIndex == fileName.length - 1) return '';
    return fileName.substring(dotIndex + 1).toLowerCase();
  }

  String _contentTypeFromExtension(String ext) {
    switch (ext) {
      case 'pdf':
        return 'application/pdf';
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'txt':
        return 'text/plain';
      default:
        return 'application/octet-stream';
    }
  }
}
