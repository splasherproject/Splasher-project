import 'package:fluent_ui/fluent_ui.dart' hide FluentIcons;
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:splasher/src/widget/message/onboard.dart';
import 'package:splasher/src/page/page.dart';
import 'package:splasher/src/page/page_type.dart';
import 'package:splasher/src/util/translations.dart';
import 'package:splasher/src/widget/fluent/setting_tile.dart';
import 'package:url_launcher/url_launcher_string.dart';

class InfoPage extends SplasherPage {
  const InfoPage({Key? key}) : super(key: key);

  @override
  SplasherPageState<InfoPage> createState() => _InfoPageState();

  @override
  String get name => translations.infoName;

  @override
  IconData get iconData => FluentIcons.info_24_regular;

  @override
  bool hasButton(String? routeName) => false;

  @override
  SplasherPageType get type => SplasherPageType.info;
}

class _InfoPageState extends SplasherPageState<InfoPage> {
  static const String _kReportBugUrl = "https://github.com/splasherproject/Splasher-project/issues/new";
  static const String _kDiscordInviteUrl = "https://discord.gg/Gu96DpVPG8";
  
  @override
  List<SettingTile> get settings => [
    _discord,
    _tutorial,
    _reportBug
  ];

  SettingTile get _reportBug => SettingTile(
      icon: Icon(
          FluentIcons.bug_24_regular
      ),
      title: Text(translations.settingsUtilsBugReportName),
      subtitle: Text(translations.settingsUtilsBugReportSubtitle),
      content: Button(
        onPressed: () => launchUrlString(_kReportBugUrl),
        child: Text(translations.settingsUtilsBugReportContent),
      )
  );

  SettingTile get _tutorial => SettingTile(
      icon: Icon(
          FluentIcons.chat_help_24_regular
      ),
      title: Text(translations.infoVideoName),
      subtitle: Text(translations.infoVideoDescription),
      content: Button(
          onPressed: () => startOnboarding(),
          child: Text(translations.infoVideoContent)
      )
  );

  SettingTile get _discord => SettingTile(
      icon: Icon(
          Icons.discord_outlined
      ),
      title: Text(translations.infoDiscordName),
      subtitle: Text(translations.infoDiscordDescription),
      content: Button(
          onPressed: () => launchUrlString(_kDiscordInviteUrl),
          child: Text(translations.infoDiscordContent)
      )
  );

  @override
  Widget? get button => null;
}