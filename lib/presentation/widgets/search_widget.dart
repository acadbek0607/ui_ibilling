import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../data/models/invoice_data.dart';
import '../../data/models/notifier.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController controller = TextEditingController();
  String query = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 44, 16, 10),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => selectedPageNotifier.value = 0,
                ),
                Expanded(
                  child: TextField(
                    controller: controller,
                    onChanged: (value) {
                      setState(() {
                        query = value.trim();
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: "Search by name...",
                      border: InputBorder.none,
                    ),
                    autofocus: true,
                  ),
                ),
                if (query.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      controller.clear();
                      setState(() => query = '');
                    },
                  ),
              ],
            ),
          ),

          // Search results
          Expanded(
            child: ValueListenableBuilder<List<InvoiceData>>(
              valueListenable: allInvoicesNotifier,
              builder: (context, allInvoices, _) {
                final filtered = allInvoices
                    .where(
                      (invoice) => invoice.fullName.toLowerCase().contains(
                        query.toLowerCase(),
                      ),
                    )
                    .toList();

                if (query.isEmpty) {
                  return const Center(child: Text("Start typing to search..."));
                } else if (filtered.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/svg/empty.svg',
                        width: 64,
                        height: 64,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "No contacts match your search",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  );
                }

                return ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final invoice = filtered[index];
                    return ListTile(
                      title: Text(invoice.fullName),
                      subtitle: Text("Invoice № ${invoice.invoiceNumber}"),
                      onTap: () {
                        selectedInvoiceNotifier.value = invoice;
                        selectedPageNotifier.value = 0;
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
