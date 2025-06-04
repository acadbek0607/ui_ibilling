import 'package:flutter/material.dart';
import 'package:ui_ibilling/data/models/classes.dart';
import '../../../data/models/invoice_data.dart';
import '../../../data/models/notifier.dart';
import 'invoice_card.dart';

class DetailedContactPage extends StatelessWidget {
  final InvoiceData contact;
  final List<InvoiceData> allInvoices;

  const DetailedContactPage({
    super.key,
    required this.contact,
    required this.allInvoices,
  });

  @override
  Widget build(BuildContext context) {
    final List<InvoiceData> relatedInvoices = allInvoices
        .where((invoice) => invoice.fullName == contact.fullName)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
          child: Column(
            children: [
              Card(
                color: Color(0xFF1E1E20),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Fisher’s full name:  ${contact.fullName}"),
                      Text("Status of the contract:  ${contact.status}"),
                      Text("Amount:  ${contact.amount}"),
                      Text("Last invoice:  № ${contact.lastInvoiceNumber}"),
                      Text("Number of invoices:  ${contact.invoiceCount}"),
                      Text("Address of the organization: ${contact.address}"),
                      Text("ITN/IEC of the organization:  ${contact.itn}"),
                      Text("Created at:  ${contact.createdAt}"),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          backgroundColor: Colors.red.withAlpha(60),
                          elevation: 0,
                        ),
                        child: Text(
                          style: Kstyle.tStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Color(0xffFF426D),
                          ),
                          'Delete contract',
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          backgroundColor: Color(0xff008F7F),
                        ),
                        child: Text(
                          style: Kstyle.tStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          'Create contract',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
          child: Text(
            'Other contracts with ${contact.fullName}',
            style: Kstyle.tStyle.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView.builder(
              itemCount: relatedInvoices.length,
              itemBuilder: (context, index) {
                final invoice = relatedInvoices[index];
                return GestureDetector(
                  onTap: () {
                    selectedInvoiceNotifier.value = invoice;
                  },
                  child: InvoiceCard(data: invoice),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
