import 'dart:async';

import 'package:fluent_ui/fluent_ui.dart' hide FluentIcons;
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:get/get.dart';
import 'package:splasher_common/common.dart';
import 'package:splasher/src/controller/game_controller.dart';
import 'package:splasher/src/controller/hosting_controller.dart';
import 'package:splasher/src/messenger/overlay.dart';
import 'package:splasher/src/widget/message/profile.dart';
import 'package:splasher/src/page/page_type.dart';
import 'package:splasher/src/page/pages.dart';

class ProfileWidget extends StatefulWidget {
  final GlobalKey<OverlayTargetState> overlayKey;
  final bool expanded;
  const ProfileWidget({required this.overlayKey, this.expanded = true});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final GameController _gameController = Get.find<GameController>();
  final HostingController _hostingController = Get.find<HostingController>();
  String? _outfitIconUrl;
  int _lastOutfitTimestamp = 0;
  Timer? _outfitRefreshTimer;

  @override
  void initState() {
    super.initState();
    _refreshOutfitIcon();
    _outfitRefreshTimer = Timer.periodic(const Duration(seconds: 10), (_) => _refreshOutfitIcon());
  }

  @override
  void dispose() {
    _outfitRefreshTimer?.cancel();
    super.dispose();
  }

  Future<void> _refreshOutfitIcon() async {
    final outfit = await getLastEquippedOutfit();
    if (outfit == null || outfit.timestamp == _lastOutfitTimestamp) {
      return;
    }

    _lastOutfitTimestamp = outfit.timestamp;
    final iconUrl = await getOutfitIconUrl(outfit.templateId);
    if (iconUrl != null && mounted) {
      setState(() => _outfitIconUrl = iconUrl);
    }
  }

  @override
  Widget build(BuildContext context) => OverlayTarget(
    key: widget.overlayKey,
    child: HoverButton(
        margin: const EdgeInsets.all(8.0),
        onPressed: () async {
          if(await showProfileForm(context, _username, _password)) {
            setState(() {});
          }
        },
        builder: (context, states) => Container(
          decoration: BoxDecoration(
              color: ButtonThemeData.uncheckedInputColor(
                FluentTheme.of(context),
                states,
                transparentWhenNone: true,
              ),
              borderRadius: BorderRadius.all(Radius.circular(6.0))
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 8.0
            ),
            child: Row(
              mainAxisAlignment: widget.expanded ? MainAxisAlignment.start : MainAxisAlignment.center,
              children: [
                Container(
                    width: widget.expanded ? 48 : 36,
                    height: widget.expanded ? 48 : 36,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: FluentTheme.of(context).accentColor.withAlpha(38)
                    ),
                    child: _outfitIconUrl == null
                        ? Icon(
                            FluentIcons.person_24_filled,
                            size: widget.expanded ? 22 : 16,
                            color: FluentTheme.of(context).accentColor.defaultBrushFor(
                                FluentTheme.of(context).brightness
                            )
                        )
                        : Image.network(
                            _outfitIconUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Icon(
                                FluentIcons.person_24_filled,
                                size: widget.expanded ? 22 : 16,
                                color: FluentTheme.of(context).accentColor.defaultBrushFor(
                                    FluentTheme.of(context).brightness
                                )
                            )
                        )
                ),
                if(widget.expanded) ...[
                  const SizedBox(
                    width: 12.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            _usernameLabel,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis
                        ),
                        Text(
                            _emailLabel,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontWeight: FontWeight.w100
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis
                        )
                      ],
                    ),
                  )
                ]
              ],
            ),
          ),
        )
    ),
  );

  String get _usernameLabel {
    final username = _username.text;
    if(username.isEmpty) {
      return kDefaultPlayerName;
    }

    var atIndex = username.indexOf("@");
    if(atIndex == -1) {
      return username.substring(0, 1).toUpperCase() + username.substring(1);
    }

    var result = username.substring(0, atIndex);
    return result.substring(0, 1).toUpperCase() + result.substring(1);
  }

  String get _emailLabel {
    final username = _username.text;
    if(username.isEmpty) {
      return "$kDefaultPlayerName@splasher.gg";
    }

    if(username.contains("@")) {
      return username.toLowerCase();
    }

    return "$username@splasher.gg".toLowerCase();
  }

  TextEditingController get _username => pageIndex.value == SplasherPageType.host.index ? _hostingController.accountUsername : _gameController.username;
  TextEditingController get _password => pageIndex.value == SplasherPageType.host.index ? _hostingController.accountPassword : _gameController.password;
}
