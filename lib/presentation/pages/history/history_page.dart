import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:ui_ibilling/data/models/classes.dart';
import '../../../data/models/invoice_data.dart';
import '../../../data/models/notifier.dart';
import '../contacts/invoice_card.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final DateFormat dateFormat = KDataFormat.dateFormat;
  DateTime? fromDate;
  DateTime? toDate;

  Future<void> _selectDate(BuildContext context, bool isFrom) async {
    final initialDate = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2200),
    );
    if (picked != null) {
      setState(() {
        if (isFrom) {
          fromDate = picked;
        } else {
          toDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.0),
            const Text(
              "Date",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                SizedBox(
                  width: 120,
                  child: InkWell(
                    onTap: () => _selectDate(context, true),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        focusColor: Color(0xFF2A2A2D),
                        suffix: SvgPicture.asset('assets/svg/calendar.svg'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                      child: Text(
                        fromDate != null
                            ? dateFormat.format(fromDate!)
                            : 'From',
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Icon(Icons.minimize_rounded, weight: 2, size: 8),
                const SizedBox(width: 12),
                SizedBox(
                  width: 120,
                  child: InkWell(
                    onTap: () => _selectDate(context, false),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        focusColor: Color(0xFF2A2A2D),
                        suffix: SvgPicture.asset('assets/svg/calendar.svg'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                      child: Text(
                        toDate != null ? dateFormat.format(toDate!) : 'To',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: ValueListenableBuilder<List<InvoiceData>>(
                valueListenable: allInvoicesNotifier,
                builder: (context, allInvoice, child) {
                  final filtered = allInvoice.where((invoice) {
                    final date = dateFormat.parse(invoice.date);

                    if (fromDate == null && toDate == null) return true;

                    if (fromDate != null && toDate != null) {
                      return (date.isAtSameMomentAs(fromDate!) ||
                              date.isAfter(fromDate!)) &&
                          (date.isAtSameMomentAs(toDate!) ||
                              date.isBefore(toDate!));
                    }

                    if (fromDate != null) {
                      return date.isAtSameMomentAs(fromDate!) ||
                          date.isAfter(fromDate!);
                    }

                    return date.isAtSameMomentAs(toDate!) ||
                        date.isBefore(toDate!);
                  }).toList();

                  if (filtered.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            'assets/svg/s_contacts.svg',
                            height: 88,
                            width: 88,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'No invoices found for the selected dates',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final invoice = filtered[index];
                      return InvoiceCard(
                        data: invoice,
                        onTap: () {
                          selectedInvoiceNotifier.value = invoice;
                          selectedPageNotifier.value =
                              lastMainTabNotifier.value;
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
