import 'package:fluent_ui/fluent_ui.dart';
import 'package:splasher/src/messenger/dialog.dart';
import 'package:splasher/src/util/translations.dart';

Future<void> showResetDialog(Function() onConfirm) => showSplasherDialog(
    builder: (context) => InfoDialog(
      text: translations.resetDefaultsDialogTitle,
      buttons: [
        DialogButton(
          type: ButtonType.secondary,
          text: translations.resetDefaultsDialogSecondaryAction,
        ),
        DialogButton(
          type: ButtonType.primary,
          text: translations.resetDefaultsDialogPrimaryAction,
          onTap: () {
            onConfirm();
            Navigator.of(context).pop();
          },
        )
      ],
    )
);