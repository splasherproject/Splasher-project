import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:splasher_common/common.dart';
import 'package:splasher/src/controller/backend_controller.dart';
import 'package:splasher/src/messenger/dialog.dart';
import 'package:splasher/src/messenger/overlay.dart';
import 'package:splasher/src/util/translations.dart';

class ServerTypeSelector extends StatefulWidget {
  final Key overlayKey;
  const ServerTypeSelector({required this.overlayKey});

  @override
  State<ServerTypeSelector> createState() => _ServerTypeSelectorState();
}

class _ServerTypeSelectorState extends State<ServerTypeSelector> {
  late final BackendController _controller = Get.find<BackendController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => OverlayTarget(
      key: widget.overlayKey,
      child: DropDownButton(
          onOpen: () => inDialog = true,
          onClose: () => inDialog = false,
          leading: Text(_controller.type.value.label),
          items: ServerType.values
              .map((type) => _createItem(type))
              .toList()
      ),
    ));
  }

  MenuFlyoutItem _createItem(ServerType type) => MenuFlyoutItem(
      text: Text(type.label),
      onPressed: () async {
        await _controller.stop(interactive: false);
        _controller.type.value = type;
      }
  );
}

extension _ServerTypeExtension on ServerType {
  String get label {
    return this == ServerType.embedded ? translations.embedded
        : this == ServerType.remote ? translations.remote
        : translations.local;
  }
}
