import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:on_clay/API/clubs_controller.dart';
import 'package:on_clay/Models/clubs_data.dart';
import 'package:on_clay/UI/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ClubsList extends HookConsumerWidget {
  const ClubsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final clubsList = ref.watch(ClubsController.provider).clubs;
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            child: Text(
              'Lista klubów',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
            ),
          ),
          Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: clubsList.length,
              itemBuilder: (context, index) {
                return ClubTile(club: clubsList[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ClubTile extends StatelessWidget {
  final ClubData club;

  ClubTile({required this.club});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 8,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
          color: CustomColors.mainBackground,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            alignment: Alignment.center,
            constraints: const BoxConstraints(
              maxHeight: 80,
            ),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: double.infinity,
                  child: Image.network(
                    'https://www.parkpowsin.pl/wp-content/uploads/2016/12/korty-ceglane-e1543277411472.jpg',
                    fit: BoxFit.fitHeight, // stretch to fit width
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                            child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text(club.clubName,
                                    style: TextStyle(fontSize: 14)))),
                        Flexible(
                            child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text(club.street,
                                    style: TextStyle(fontSize: 8)))),
                        Flexible(
                            child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text(club.addressDetails,
                                    style: TextStyle(fontSize: 8)))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
