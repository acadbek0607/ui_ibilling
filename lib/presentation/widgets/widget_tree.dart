import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ui_ibilling/presentation/pages/new/new_invoice_page.dart';
import '../../data/models/invoice_data.dart';
import '../../data/models/notifier.dart';
import '../pages/contacts/contacts_page.dart';
import '../pages/contacts/detailed_contact_page.dart';
import '../pages/history/history_page.dart';
import '../pages/new/new_contact_page.dart';
import '../pages/new/new_page.dart';
import '../pages/profile/profile_page.dart';
import '../pages/saved/saved_page.dart';
import 'filter_widget.dart';
import 'navbar_widget.dart';
import 'search_widget.dart';

List<Widget> pages = [
  const ContactsPage(),
  const HistoryPage(),
  const NewPage(),
  const SavedPage(),
  const ProfilePage(),
  ValueListenableBuilder<List<InvoiceData>>(
    valueListenable: allInvoicesNotifier,
    builder: (context, allInvoices, _) {
      return ValueListenableBuilder(
        valueListenable: selectedInvoiceNotifier,
        builder: (context, selectedInvoice, _) {
          return selectedInvoice != null
              ? DetailedContactPage(
                  contact: selectedInvoice,
                  allInvoices: allInvoices,
                )
              : const SizedBox();
        },
      );
    },
  ),
  const NewContactPage(),
  const NewInvoicePage(),
];

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: selectedPageNotifier,
      builder: (context, selectedPage, _) {
        return ValueListenableBuilder<InvoiceData?>(
          valueListenable: selectedInvoiceNotifier,
          builder: (context, selectedInvoice, _) {
            final currentPage = getCurrentPage(selectedPage, selectedInvoice);
            final title = getAppBarTitle(selectedPage, selectedInvoice);
            final leading = getLeading(selectedPage, selectedInvoice);
            final actions = getActions(selectedPage, selectedInvoice);

            return Scaffold(
              appBar: selectedPage == 7
                  ? null
                  : AppBar(
                      centerTitle: selectedPage == 6,
                      title: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: 'Ubuntu',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      leading: leading,
                      actions: actions,
                    ),
              body: currentPage,
              bottomNavigationBar:
                  selectedPage <= 4 || selectedPage == 8 || selectedPage == 9
                  ? const NavbarWidget()
                  : null,
            );
          },
        );
      },
    );
  }

  Widget getCurrentPage(int selectedPage, InvoiceData? selectedInvoice) {
    switch (selectedPage) {
      case 6:
        return const FilterWidget();
      case 7:
        return SearchWidget();
      case 8:
        return NewContactPage();
      case 9:
        return const NewInvoicePage();
      default:
        if (selectedPage == lastMainTabNotifier.value &&
            selectedInvoice != null) {
          return DetailedContactPage(
            contact: selectedInvoice,
            allInvoices: allInvoicesNotifier.value,
          );
        } else {
          return pages[selectedPage];
        }
    }
  }

  String getAppBarTitle(int selectedPage, InvoiceData? selectedInvoice) {
    switch (selectedPage) {
      case 6:
        return 'Filter';
      case 7:
        return '';
      case 8:
        return 'New contact';
      case 9:
        return 'New invoice';
      default:
        if (selectedPage == lastMainTabNotifier.value &&
            selectedInvoice != null) {
          return '№ ${selectedInvoice.invoiceNumber}';
        } else {
          return NavbarWidget.getTitle(selectedPage);
        }
    }
  }

  Widget getLeading(int selectedPage, InvoiceData? selectedInvoice) {
    switch (selectedPage) {
      case 6:
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 0, 14),
          child: BackButton(
            onPressed: () =>
                selectedPageNotifier.value = lastMainTabNotifier.value,
          ),
        );
      default:
        if (selectedPage == lastMainTabNotifier.value &&
            selectedInvoice != null) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 0, 14),
            child: SvgPicture.asset(
              'assets/svg/invoice.svg',
              height: 24,
              width: 24,
            ),
          );
        } else {
          return Padding(
            padding: EdgeInsets.fromLTRB(20, 14, 0, 14),
            child: SvgPicture.asset(
              'assets/svg/appBar_icon.svg',
              height: 24,
              width: 24,
            ),
          );
        }
    }
  }

  List<Widget> getActions(int selectedPage, InvoiceData? selectedInvoice) {
    if (selectedPage >= 6 && selectedPage <= 9 || selectedPage == 4) {
      return [];
    } else if (selectedPage == lastMainTabNotifier.value &&
        selectedInvoice != null) {
      return [
        Icon(
          selectedInvoice.saved
              ? Icons.bookmark
              : Icons.bookmark_border_rounded,
        ),
        const SizedBox(width: 20),
      ];
    } else {
      return [
        IconButton(
          onPressed: () => selectedPageNotifier.value = 6,
          icon: SvgPicture.asset('assets/svg/filter.svg'),
        ),
        const SizedBox(width: 5),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset('assets/svg/divider.svg'),
        ),
        const SizedBox(width: 5),
        IconButton(
          onPressed: () => selectedPageNotifier.value = 7,
          icon: SvgPicture.asset('assets/svg/search.svg'),
        ),
        const SizedBox(width: 20),
      ];
    }
  }
}
