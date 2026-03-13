import 'package:cloud_functions/cloud_functions.dart';

import '../../models/contract_model.dart';

class FunctionsService {
  FunctionsService({FirebaseFunctions? functions})
      : _functions = functions ?? FirebaseFunctions.instance;

  final FirebaseFunctions _functions;

  Future<ContractAnalysisResult> analyzeContractUpload({
    required String contractId,
    required String fileUrl,
    required String fileName,
    required String extractedText,
  }) async {
    final callable = _functions.httpsCallable('analyzeContractUpload');

    final response = await callable.call(<String, dynamic>{
      'contractId': contractId,
      'fileUrl': fileUrl,
      'fileName': fileName,
      'text': extractedText,
    });

    final data = response.data;
    if (data is! Map) {
      throw const FormatException('Invalid contract analysis response.');
    }

    return ContractAnalysisResult.fromMap(
      Map<String, dynamic>.from(data.cast<String, dynamic>()),
    );
  }
}
