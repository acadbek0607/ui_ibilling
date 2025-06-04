import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ui_ibilling/presentation/pages/profile/language_dialog.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String selectedLanguage = 'English (USA)';
  String selectedFlag = 'assets/svg/f_usa.svg';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
            color: Color(0xFF2A2A2D),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: SvgPicture.asset(
                          'assets/svg/avatar.svg',
                          width: 48,
                          height: 48,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Asadbek Mamutov",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16.0,
                              color: Color(0XFF00A795),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "Graphic designer • IQ Education",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12.0,
                              color: Color(0XFFE7E7E7),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: [
                      Text(
                        "Date of birth:",
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          fontSize: 14.0,
                          color: Color(0XFFE7E7E7),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        "06.07.2000",
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          fontSize: 14.0,
                          color: Color(0XFF999999),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Phone number:",
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          fontSize: 14.0,
                          color: Color(0XFFE7E7E7),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        "+998 90 662 07 06",
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          fontSize: 14.0,
                          color: Color(0XFF999999),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "E-mail:",
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          fontSize: 14.0,
                          color: Color(0XFFE7E7E7),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        "vecious@outlook.com",
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          fontSize: 14.0,
                          color: Color(0XFF999999),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12.0),
          GestureDetector(
            onTap: () async {
              final res = await showDialog<String>(
                context: context,
                builder: (_) => LanguageDialog(),
                barrierDismissible: true,
                barrierColor: Colors.black.withAlpha(125),
              );

              if (res != null) {
                setState(() {
                  selectedLanguage = res;
                  selectedFlag = {
                    'O‘zbek (Latin)': 'assets/svg/f_uzb.svg',
                    'Русский': 'assets/svg/f_russia.svg',
                    'English (USA)': 'assets/svg/f_usa.svg',
                  }[res]!;
                });
              }
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Color(0xff2a2a2d),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedLanguage,
                    style: TextStyle(
                      color: Color(0xffe7e7e7),
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  SvgPicture.asset(selectedFlag, height: 48.0, width: 48.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
