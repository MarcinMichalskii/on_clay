import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:on_clay/UI/colors.dart';

class AllClubsLoader extends StatelessWidget {
  const AllClubsLoader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            constraints: BoxConstraints(maxHeight: 100),
            margin: EdgeInsets.only(bottom: 128),
            child: const LoadingIndicator(
              indicatorType: Indicator.orbit,
              colors: [CustomColors.orange],
              strokeWidth: 2,
            ),
          ),
        ],
      ),
    );
  }
}
