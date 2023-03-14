import 'package:freezed_annotation/freezed_annotation.dart';
part 'clubs_groups.g.dart';

@JsonSerializable()
class ClubsGroup {
  final String name;
  final List<String> ids;

  ClubsGroup(this.name, this.ids);

  factory ClubsGroup.fromJson(Map<String, dynamic> json) =>
      _$ClubsGroupFromJson(json);
  Map<String, dynamic> toJson() => _$ClubsGroupToJson(this);
}

List<ClubsGroup> defaultGroups = [
  ClubsGroup("Wszystkie kluby", []),
  ClubsGroup("Kraków", [
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
  ]),
  ClubsGroup("Kraków i okolice", [
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
  ]),
  ClubsGroup("Relaksmisja Tennis League", [
    'klub_sportowy_grzegorzecki_flex',
    'fame_sport_club',
    'klub_sportowy_grzegorzecki'
  ]),
  ClubsGroup("Smart liga", [
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
  ])
];
