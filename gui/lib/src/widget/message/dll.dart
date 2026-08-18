import 'package:fluent_ui/fluent_ui.dart';
import 'package:splasher/src/messenger/dialog.dart';
import 'package:splasher/src/util/translations.dart';

Future<void> showDllDeletedDialog() => showSplasherDialog(
    builder: (context) => InfoDialog(
      text: translations.dllDeletedTitle,
      buttons: [
        DialogButton(
          type: ButtonType.secondary,
          text: translations.dllDeletedSecondaryAction,
        ),
        DialogButton(
          type: ButtonType.secondary,
          text: translations.dllDeletedPrimaryAction,
          onTap: () {
            Navigator.pop(context);

          },
        ),
      ],
    )
);