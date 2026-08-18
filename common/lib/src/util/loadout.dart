import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:splasher_common/common.dart';

/// The base outfit ("Recruit") every account starts with before ever
/// equipping a skin, used as the avatar fallback.
const String kDefaultOutfitTemplateId = "AthenaCharacter:CID_001_Athena_Commando_F_Default";

class LastEquippedOutfit {
  final String templateId;
  final int timestamp;

  const LastEquippedOutfit(this.templateId, this.timestamp);
}

final File _lastLoadoutFile = File("${backendDirectory.path}\\state\\last_loadout.json");

Future<LastEquippedOutfit?> getLastEquippedOutfit() async {
  try {
    if (!await _lastLoadoutFile.exists()) {
      return null;
    }

    final content = jsonDecode(await _lastLoadoutFile.readAsString());
    final templateId = content["characterId"] as String?;
    if (templateId == null || templateId.isEmpty) {
      return null;
    }

    return LastEquippedOutfit(templateId, content["timestamp"] as int? ?? 0);
  } catch (_) {
    return null;
  }
}

Future<String?> getOutfitIconUrl(String templateId) async {
  final separatorIndex = templateId.indexOf(":");
  if (separatorIndex == -1 || separatorIndex + 1 >= templateId.length) {
    return null;
  }

  final cosmeticId = templateId.substring(separatorIndex + 1);
  try {
    final response = await http.get(Uri.parse("https://fortnite-api.com/v2/cosmetics/br/$cosmeticId"));
    if (response.statusCode != 200) {
      return null;
    }

    final json = jsonDecode(response.body);
    final images = json["data"]?["images"];
    return images?["icon"] as String? ?? images?["smallIcon"] as String?;
  } catch (_) {
    return null;
  }
}
