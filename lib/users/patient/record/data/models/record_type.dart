import 'package:canc_app/core/helpers/utils/app_assets.dart';

enum RecordType {
  scan('Scan', 'مسح', AppAssets.scan),
  labResult('Lab Result', 'نتائج التحاليل', AppAssets.labResult),
  prescription('Prescription', 'روشتة', AppAssets.prescription),
  documents('Documents', 'مستندات', AppAssets.documents);

  final String labelEn;
  final String labelAr;
  final String assetPath;

  const RecordType(
    this.labelEn,
    this.labelAr,
    this.assetPath,
  );
}
