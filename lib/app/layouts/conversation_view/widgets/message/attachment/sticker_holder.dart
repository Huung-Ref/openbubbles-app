import 'dart:async';

import 'package:bluebubbles/app/wrappers/stateful_boilerplate.dart';
import 'package:bluebubbles/database/models.dart';
import 'package:bluebubbles/services/services.dart';
import 'package:bluebubbles/utils/logger/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:universal_io/io.dart';

class StickerHolder extends StatefulWidget {
  StickerHolder({super.key, required this.stickerMessages, required this.controller});
  final Iterable<Message> stickerMessages;
  final ConversationViewController controller;

  @override
  State<StickerHolder> createState() => _StickerHolderState();
}

class _StickerHolderState extends OptimizedState<StickerHolder> with AutomaticKeepAliveClientMixin {
  Iterable<Message> get messages => widget.stickerMessages;
  ConversationViewController get controller => widget.controller;
  
  bool _visible = true;
  int renderedStickers = 0;

  @override
  void initState() {
    super.initState();
    updateObx(() {
      loadStickers();
    });
  }

  Future<void> loadStickers() async {
    if (renderedStickers == messages.length) return;
    renderedStickers = messages.length;
    for (Message msg in messages) {
      for (Attachment? attachment in msg.attachments) {
        // If we've already loaded it, don't try again
        if (controller.stickerData.keys.contains(attachment!.guid)) continue;

        final pathName = attachment.path;
        if (await FileSystemEntity.type(pathName) == FileSystemEntityType.notFound) {
          attachmentDownloader.startDownload(attachment, onComplete: (_) async {
            await checkImage(msg, attachment);
          });
        } else {
          await checkImage(msg, attachment);
        }
      }
    }
  }

  Future<void> checkImage(Message message, Attachment attachment) async {
    final pathName = attachment.path;
    // Check via the image package to make sure this is a valid, render-able image
    // final image = await compute(decodeIsolate, PlatformFile(
    //     path: pathName,
    //     name: attachment.transferName!,
    //     bytes: attachment.bytes,
    //     size: attachment.totalBytes ?? 0,
    //   ),
    // );
    final bytes = await File(pathName).readAsBytes();
    var stickerData = message.attributedBody.firstOrNull?.runs
      .firstWhere((element) => element.attributes?.attachmentGuid == attachment.guid).attributes?.stickerData;
    controller.stickerData[message.guid!] = {
      attachment.guid!: (bytes, stickerData)
    };
    Logger.debug("sticker count ${controller.stickerData.length}");
    setState(() {});
  }

  @override
  void didUpdateWidget(StickerHolder oldWidget) { 
    super.didUpdateWidget(oldWidget);
    Logger.debug("ugh why ${messages.length}");
    updateObx(() {
      loadStickers();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final guids = messages.map((e) => e.guid!);
    final stickers = controller.stickerData.entries.where((element) => guids.contains(element.key)).map((e) => e.value);
    if (stickers.isEmpty) return const SizedBox.shrink();

    final data = stickers.map((e) => e.values).expand((element) => element);
    return Positioned(top: -20, left: -20, right: -20, bottom: -20, child: GestureDetector(
      onTap: () {
        setState(() {
          _visible = !_visible;
        });
      },
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 150),
        opacity: _visible ? 1.0 : 0.25,
        child: Stack(
          children: data.map((e) => Container(
            child: Transform.rotate(
              angle: e.$2?.rotation ?? 0,
              alignment: FractionalOffset(e.$2?.normalizedX ?? .5, e.$2?.normalizedY ?? .5),
              child: Transform.scale(
                child: Image.memory(
                  e.$1,
                  scale: .01,
                  gaplessPlayback: true,
                  cacheHeight: 200,
                  filterQuality: FilterQuality.none,
                ),
                scale: e.$2?.scale ?? 1,
              ),
            ),
            alignment: FractionalOffset(e.$2?.normalizedX ?? .5, e.$2?.normalizedY ?? .5),
          )).toList(),
        )
      ),
    ));
  }

  @override
  bool get wantKeepAlive => true;
}
