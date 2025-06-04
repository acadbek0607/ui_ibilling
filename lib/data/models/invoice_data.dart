import '../../presentation/pages/contacts/invoice_card.dart';

class InvoiceData {
  final int invoiceNumber;
  final String fullName;
  final String amount;
  final int lastInvoiceNumber;
  final int invoiceCount;
  final String date;
  final InvoiceStatus status;
  final String address;
  final String itn;
  final String createdAt;
  final bool saved;

  InvoiceData({
    required this.invoiceNumber,
    required this.fullName,
    required this.amount,
    required this.lastInvoiceNumber,
    required this.invoiceCount,
    required this.date,
    required this.status,
    required this.address,
    required this.itn,
    required this.createdAt,
    required this.saved,
  });

  factory InvoiceData.fromJson(Map<String, dynamic> json) {
    return InvoiceData(
      invoiceNumber: json['invoiceNumber'],
      fullName: json['fullName'],
      amount: json['amount'],
      lastInvoiceNumber: json['lastInvoiceNumber'],
      invoiceCount: json['invoiceCount'],
      date: json['date'],
      status: InvoiceStatus.values.firstWhere(
        (e) => e.toString() == 'InvoiceStatus.${json['status']}',
        orElse: () => InvoiceStatus.inProcess,
      ),
      address: json['address'],
      itn: json['itn'],
      createdAt: json['createdAt'],
      saved: json['saved'] ?? false,
    );
  }
}
