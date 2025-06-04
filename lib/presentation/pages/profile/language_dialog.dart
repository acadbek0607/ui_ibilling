import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LanguageDialog extends StatefulWidget {
  const LanguageDialog({super.key});

  @override
  _LanguageDialogState createState() => _LanguageDialogState();
}

class _LanguageDialogState extends State<LanguageDialog> {
  String _selected = 'O‘zbek (Latin)';

  final languages = [
    {'label': 'O‘zbek (Latin)', 'flag': 'assets/svg/f_uzb.svg'},
    {'label': 'Русский', 'flag': 'assets/svg/f_russia.svg'},
    {'label': 'English (USA)', 'flag': 'assets/svg/f_usa.svg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color.fromARGB(44, 0, 0, 0),
      insetPadding: EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 24.0),
              padding: const EdgeInsets.fromLTRB(28, 16, 28, 28),
              decoration: BoxDecoration(
                color: Color(0xff2a2a2d),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Choose a language',
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...languages.map((lang) {
                    return RadioListTile<String>(
                      controlAffinity: ListTileControlAffinity.trailing,
                      title: Row(
                        children: [
                          SvgPicture.asset(
                            lang['flag']!,
                            width: 48.0,
                            height: 48.0,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            lang['label']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                        ],
                      ),
                      value: lang['label']!,
                      groupValue: _selected,
                      onChanged: (value) {
                        setState(() {
                          _selected = value!;
                        });
                      },
                      activeColor: Color(0xff008F7F),
                    );
                  }),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal.withAlpha(125),
                          minimumSize: (Size(125, 40)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                        ),
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(
                            context,
                          ).pop(_selected); // return selected language
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          minimumSize: (Size(125, 40)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                        ),
                        child: const Text('Done'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
