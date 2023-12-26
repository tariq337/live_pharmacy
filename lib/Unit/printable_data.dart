import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

buildPrintableData(
        //image,
        List data,
        String total,
        pw.Font font,
        String reduction) =>
    pw.Padding(
      padding: const pw.EdgeInsets.all(10.00),
      child: pw.Column(children: [
        pw.Text("صيدلية لايف",
            textDirection: pw.TextDirection.rtl,
            style: pw.TextStyle(
                font: font, fontSize: 13.00, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 5.00),
        pw.Divider(),
        pw.Container(
          height: 70,
          alignment: pw.Alignment.center,
          child: pw.FlutterLogo(),
        ),
        pw.SizedBox(height: 5.00),
        pw.Column(
          children: [
            pw.Container(
              color: const PdfColor(0.5, 1, 0.5, 0.7),
              width: double.infinity,
              height: 36.00,
              child: pw.Center(
                child: pw.Text(
                  "مشترياتي",
                  textDirection: pw.TextDirection.rtl,
                  style: pw.TextStyle(
                      font: font,
                      color: const PdfColor(0.2, 0.6, 0.2, 0.7),
                      fontSize: 14.00,
                      fontWeight: pw.FontWeight.bold),
                ),
              ),
            ),
            for (var i = 0; i < data.length; i++)
              pw.Container(
                color: i % 2 != 0
                    ? const PdfColor(0.9, 0.9, 0.9, 0.6)
                    : const PdfColor(1, 1, 1, 0.1),
                width: double.infinity,
                height: 36.00,
                child: pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(horizontal: 25.0),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        "SD ${data[i][2]}",
                        textDirection: pw.TextDirection.rtl,
                        style: pw.TextStyle(
                            font: font,
                            fontSize: 11.00,
                            fontWeight: pw.FontWeight.normal),
                      ),
                      pw.Text(
                        "${data[i][0]} X${data[i][1]}",
                        textDirection: pw.TextDirection.rtl,
                        style: pw.TextStyle(
                            font: font,
                            fontSize: 11.00,
                            fontWeight: pw.FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            pw.Padding(
              padding: const pw.EdgeInsets.symmetric(horizontal: 25.0),
              child: pw.Container(
                width: double.infinity,
                height: 36.00,
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      "التخفيض $reduction%",
                      textDirection: pw.TextDirection.rtl,
                      style: pw.TextStyle(
                        font: font,
                        fontSize: 12.00,
                        fontWeight: pw.FontWeight.bold,
                        color: const PdfColor(0.2, 0.6, 0.2, 0.7),
                      ),
                    ),
                    pw.Text(
                      "SD $total",
                      textDirection: pw.TextDirection.rtl,
                      style: pw.TextStyle(
                        font: font,
                        fontSize: 12.00,
                        fontWeight: pw.FontWeight.bold,
                        color: const PdfColor(0.2, 0.6, 0.2, 0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            pw.SizedBox(height: 15.00),
            pw.Text("مع تمنياتنا بعاجل الشفاء",
                textDirection: pw.TextDirection.rtl,
                style: pw.TextStyle(
                    font: font,
                    fontSize: 13.00,
                    fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 15.00),
          ],
        )
      ]),
    );
