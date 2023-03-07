import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

enum Group { all, krakow, krakowAndSurroundings, relaks, smart }

extension GroupName on Group {
  String get groupName {
    switch (this) {
      case Group.all:
        return "Wszystkie kluby";
      case Group.krakow:
        return "Kraków";
      case Group.krakowAndSurroundings:
        return "Kraków i okolice";
      case Group.relaks:
        return "Relaksmisja Tennis League";
      case Group.smart:
        return "Smart liga";
    }
  }
}

extension GroupIds on Group {
  List<String> get groupIds {
    switch (this) {
      case Group.all:
        return [];
      case Group.krakow:
        return [
          'korty_piaski_nowe',
          'awf_hala_tenisowa',
          'blonia_sport',
          'centrum_sportowe_czyzyny',
          'centrum_tenisowe_pk',
          'fame_sport_club',
          'forehand_krakowska_szkola_tenisa',
          'katenis__korty_olsza',
          'klub_sportowy_grzegorzecki',
          'klub_sportowy_grzegorzecki_flex',
          'klub_tenisowy_blonia_krakow',
          'korty_bialopradnicka',
          'korty_dabskie',
          'korty_tenisowe_piast',
          'krakowska_szkola_tenisa_tenis24',
          'krakowski_klub_sportowy_olsza',
          'ks_nadwislan_krakow',
          'magic_sports',
          'wola_park',
          'wks_wawel'
        ];
      case Group.krakowAndSurroundings:
        return [
          'korty_piaski_nowe',
          'awf_hala_tenisowa',
          'blonia_sport',
          'centrum_sportowe_czyzyny',
          'centrum_tenisowe_pk',
          'fame_sport_club',
          'forehand_krakowska_szkola_tenisa',
          'katenis__korty_olsza',
          'klub_sportowy_grzegorzecki',
          'klub_sportowy_grzegorzecki_flex',
          'klub_tenisowy_blonia_krakow',
          'korty_bialopradnicka',
          'korty_dabskie',
          'korty_tenisowe_piast',
          'krakowska_szkola_tenisa_tenis24',
          'krakowski_klub_sportowy_olsza',
          'ks_nadwislan_krakow',
          'magic_sports',
          'wola_park',
          'wks_wawel',
          'tennis__country_club',
          'panta_rei',
          'nlf_tenis',
          'sport_klub_kryspinow',
        ];
      case Group.relaks:
        return [
          'klub_sportowy_grzegorzecki_flex',
          'fame_sport_club',
          'klub_sportowy_grzegorzecki'
        ];
      case Group.smart:
        return [
          'blonia_sport',
          'centrum_sportowe_czyzyny',
          'forehand_krakowska_szkola_tenisa',
          'katenis__korty_olsza',
          'krakowski_klub_sportowy_olsza',
          'klub_tenisowy_blonia_krakow',
          'korty_dabskie',
          'korty_tenisowe_piast',
          'ks_nadwislan_krakow',
          'tennis__country_club',
          'magic_sports',
        ];
    }
  }
}

class SelectGroup extends HookWidget {
  const SelectGroup(
      {required this.selectedGroup, required this.onGroupSelected});
  final Group selectedGroup;
  final ValueSetter<Group> onGroupSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
        children: Group.values
            .map((e) => SelectGroupButton(
                  isSelected: e == selectedGroup,
                  title: e.groupName,
                  onPressed: () {
                    onGroupSelected(e);
                  },
                ))
            .toList());
  }
}

class SelectGroupButton extends StatelessWidget {
  final bool isSelected;
  final String title;
  final VoidCallback onPressed;
  const SelectGroupButton(
      {Key? key,
      required this.title,
      required this.onPressed,
      required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: TextButton(
          onPressed: onPressed,
          child: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(
                  isSelected ? Colors.green : Colors.blue))),
    );
  }
}
