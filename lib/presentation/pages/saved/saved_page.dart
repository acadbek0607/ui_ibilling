import 'package:flutter/material.dart';
import 'package:ui_ibilling/presentation/pages/contacts/invoice_card.dart';
import '../../../data/models/invoice_data.dart';
import '../../../data/models/notifier.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<InvoiceData>>(
      valueListenable: allInvoicesNotifier,
      builder: (context, invoices, _) {
        final savedInvoices = invoices.where((inv) => inv.saved).toList();
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
          child: ListView.builder(
            itemCount: savedInvoices.length,
            itemBuilder: (context, index) {
              final invoice = savedInvoices[index];
              return InvoiceCard(
                data: invoice,
                onTap: () {
                  selectedInvoiceNotifier.value = invoice;
                  selectedPageNotifier.value = lastMainTabNotifier.value;
                },
              );
            },
          ),
        );
      },
    );
  }
}
