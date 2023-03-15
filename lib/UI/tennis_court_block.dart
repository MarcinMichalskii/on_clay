import 'package:flutter/material.dart';
import 'package:on_clay/UI/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class TennisCourtBlock extends StatelessWidget {
  final String clubPath;
  final String courtName;
  final String courtTime;

  TennisCourtBlock(
      {required this.courtName,
      required this.courtTime,
      required this.clubPath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launchUrl(Uri.parse('https://www.twojtenis.pl/pl/kluby/$clubPath.html'),
            mode: LaunchMode.externalApplication);
      },
      child: Container(
        margin: EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: CustomColors.orange,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                courtName,
                style: const TextStyle(
                    fontSize: 14,
                    color: CustomColors.superLightGray,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 4),
              Text(
                courtTime,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: CustomColors.superLightGray,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
