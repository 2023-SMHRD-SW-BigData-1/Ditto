// ignore: depend_on_referenced_packages
import 'package:syncfusion_flutter_pdf/pdf.dart';

//Local imports
import 'save_file_mobile.dart' if (dart.library.html) 'save_file_web.dart';

Future<void> generateInvoice() async {
  final pdf = PdfDocument();
  final page = pdf.pages.add();

  // PDF 저장 또는 공유
  final data = await pdf.save();
}
