import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ui_ibilling/data/models/classes.dart';
import 'package:ui_ibilling/data/models/invoice_data.dart';

class InvoiceCard extends StatelessWidget {
  final VoidCallback? onTap;
  final InvoiceData data;

  const InvoiceCard({super.key, this.onTap, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: const Color(0xFF2C2C2E),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svg/invoice.svg',
                      height: 18,
                      width: 18,
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      '№ ${data.invoiceNumber}',
                      style: Kstyle.tStyle.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    //status
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 2.0,
                    ),
                    decoration: BoxDecoration(
                      color: data.status.textColor.withAlpha(39),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      data.status.label,
                      style: TextStyle(
                        color: data.status.textColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.0),
            RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.white),
                children: [
                  TextSpan(text: 'F.I.Sh: ', style: Kstyle.tStyle),
                  TextSpan(
                    text: data.fullName,
                    style: Kstyle.tStyle.copyWith(color: Color(0xFF999999)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.0),
            RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.white),
                children: [
                  TextSpan(text: 'Amount: ', style: Kstyle.tStyle),
                  TextSpan(
                    text: data.amount,
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.0),
            RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.white),
                children: [
                  TextSpan(text: 'Last invoice: ', style: Kstyle.tStyle),
                  TextSpan(
                    text: '№ ${data.lastInvoiceNumber}',
                    style: Kstyle.tStyle.copyWith(color: Color(0xFF999999)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.white),
                    children: [
                      const TextSpan(
                        text: 'Number of invoices:  ',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      TextSpan(
                        text: '${data.invoiceCount}',
                        style: TextStyle(color: Color(0xFF999999)),
                      ),
                    ],
                  ),
                ),
                Text(
                  data.date,
                  style: const TextStyle(color: Color(0xFF999999)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

enum InvoiceStatus {
  paid,
  inProcess,
  rejected;

  Color get textColor {
    switch (this) {
      case InvoiceStatus.paid:
        return Color(0xFF49B7A5);
      case InvoiceStatus.inProcess:
        return Color(0xFFFDAB2A);
      case InvoiceStatus.rejected:
        return Color(0xFFFF426D);
    }
  }

  String get label {
    switch (this) {
      case InvoiceStatus.paid:
        return 'Paid';
      case InvoiceStatus.inProcess:
        return 'In process';
      case InvoiceStatus.rejected:
        return 'Rejected';
    }
  }
}
