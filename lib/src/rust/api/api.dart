// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.0.0-dev.28.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../frb_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'package:freezed_annotation/freezed_annotation.dart' hide protected;
part 'api.freezed.dart';

// The type `InnerPushState` is not used by any `pub` functions, thus it is ignored.
// The type `SavedState` is not used by any `pub` functions, thus it is ignored.

Future<ArcPushState> newPushState({required String dir, dynamic hint}) =>
    RustLib.instance.api.newPushState(dir: dir, hint: hint);

Future<ArcPushState> serviceFromPtr({required String ptr, dynamic hint}) =>
    RustLib.instance.api.serviceFromPtr(ptr: ptr, hint: hint);

Future<DartSupportAlert?> registerIds(
        {required ArcPushState state, dynamic hint}) =>
    RustLib.instance.api.registerIds(state: state, hint: hint);

Future<void> configureMacos(
        {required ArcPushState state,
        required MacOsConfig config,
        dynamic hint}) =>
    RustLib.instance.api
        .configureMacos(state: state, config: config, hint: hint);

Future<MacOsConfig> configFromValidationData(
        {required List<int> data, required DartHwExtra extra, dynamic hint}) =>
    RustLib.instance.api
        .configFromValidationData(data: data, extra: extra, hint: hint);

Future<DartIMessage> ptrToDart({required String ptr, dynamic hint}) =>
    RustLib.instance.api.ptrToDart(ptr: ptr, hint: hint);

Future<String> formatE164(
        {required String number, required String country, dynamic hint}) =>
    RustLib.instance.api
        .formatE164(number: number, country: country, hint: hint);

Future<DartIMessage?> recvWait({required ArcPushState state, dynamic hint}) =>
    RustLib.instance.api.recvWait(state: state, hint: hint);

Future<void> send(
        {required ArcPushState state,
        required DartIMessage msg,
        dynamic hint}) =>
    RustLib.instance.api.send(state: state, msg: msg, hint: hint);

Future<List<String>> getHandles({required ArcPushState state, dynamic hint}) =>
    RustLib.instance.api.getHandles(state: state, hint: hint);

Future<DartIMessage> newMsg(
        {required ArcPushState state,
        required DartConversationData conversation,
        required String sender,
        required DartMessage message,
        dynamic hint}) =>
    RustLib.instance.api.newMsg(
        state: state,
        conversation: conversation,
        sender: sender,
        message: message,
        hint: hint);

Future<List<String>> validateTargets(
        {required ArcPushState state,
        required List<String> targets,
        required String sender,
        dynamic hint}) =>
    RustLib.instance.api.validateTargets(
        state: state, targets: targets, sender: sender, hint: hint);

Future<RegistrationPhase> getPhase(
        {required ArcPushState state, dynamic hint}) =>
    RustLib.instance.api.getPhase(state: state, hint: hint);

Stream<TransferProgress> downloadAttachment(
        {required ArcPushState state,
        required DartAttachment attachment,
        required String path,
        dynamic hint}) =>
    RustLib.instance.api.downloadAttachment(
        state: state, attachment: attachment, path: path, hint: hint);

Stream<TransferProgress> downloadMmcs(
        {required ArcPushState state,
        required DartMMCSFile attachment,
        required String path,
        dynamic hint}) =>
    RustLib.instance.api.downloadMmcs(
        state: state, attachment: attachment, path: path, hint: hint);

Stream<MMCSTransferProgress> uploadMmcs(
        {required ArcPushState state, required String path, dynamic hint}) =>
    RustLib.instance.api.uploadMmcs(state: state, path: path, hint: hint);

Stream<TransferProgress> uploadAttachment(
        {required ArcPushState state,
        required String path,
        required String mime,
        required String uti,
        required String name,
        dynamic hint}) =>
    RustLib.instance.api.uploadAttachment(
        state: state, path: path, mime: mime, uti: uti, name: name, hint: hint);

Future<DartLoginState> tryAuth(
        {required ArcPushState state,
        required String username,
        required String password,
        dynamic hint}) =>
    RustLib.instance.api.tryAuth(
        state: state, username: username, password: password, hint: hint);

Future<DartLoginState> send2FaToDevices(
        {required ArcPushState state, dynamic hint}) =>
    RustLib.instance.api.send2FaToDevices(state: state, hint: hint);

Future<DartLoginState> verify2Fa(
        {required ArcPushState state, required String code, dynamic hint}) =>
    RustLib.instance.api.verify2Fa(state: state, code: code, hint: hint);

Future<List<DartTrustedPhoneNumber>> get2FaSmsOpts(
        {required ArcPushState state, dynamic hint}) =>
    RustLib.instance.api.get2FaSmsOpts(state: state, hint: hint);

Future<DartLoginState> send2FaSms(
        {required ArcPushState state, required int phoneId, dynamic hint}) =>
    RustLib.instance.api.send2FaSms(state: state, phoneId: phoneId, hint: hint);

Future<DartLoginState> verify2FaSms(
        {required ArcPushState state,
        required VerifyBody body,
        required String code,
        dynamic hint}) =>
    RustLib.instance.api
        .verify2FaSms(state: state, body: body, code: code, hint: hint);

Future<String> getUserName({required ArcPushState state, dynamic hint}) =>
    RustLib.instance.api.getUserName(state: state, hint: hint);

Future<DartRegisterState> getRegstate(
        {required ArcPushState state, dynamic hint}) =>
    RustLib.instance.api.getRegstate(state: state, hint: hint);

// Rust type: RustOpaqueMoi<flutter_rust_bridge::for_generated::rust_async::RwLock<Arc < PushState >>>
@sealed
class ArcPushState extends RustOpaque {
  ArcPushState.dcoDecode(List<dynamic> wire)
      : super.dcoDecode(wire, _kStaticData);

  ArcPushState.sseDecode(int ptr, int externalSizeOnNative)
      : super.sseDecode(ptr, externalSizeOnNative, _kStaticData);

  static final _kStaticData = RustArcStaticData(
    rustArcIncrementStrongCount:
        RustLib.instance.api.rust_arc_increment_strong_count_ArcPushState,
    rustArcDecrementStrongCount:
        RustLib.instance.api.rust_arc_decrement_strong_count_ArcPushState,
    rustArcDecrementStrongCountPtr:
        RustLib.instance.api.rust_arc_decrement_strong_count_ArcPushStatePtr,
  );
}

// Rust type: RustOpaqueMoi<flutter_rust_bridge::for_generated::rust_async::RwLock<MacOSConfig>>
@sealed
class MacOsConfig extends RustOpaque {
  MacOsConfig.dcoDecode(List<dynamic> wire)
      : super.dcoDecode(wire, _kStaticData);

  MacOsConfig.sseDecode(int ptr, int externalSizeOnNative)
      : super.sseDecode(ptr, externalSizeOnNative, _kStaticData);

  static final _kStaticData = RustArcStaticData(
    rustArcIncrementStrongCount:
        RustLib.instance.api.rust_arc_increment_strong_count_MacOsConfig,
    rustArcDecrementStrongCount:
        RustLib.instance.api.rust_arc_decrement_strong_count_MacOsConfig,
    rustArcDecrementStrongCountPtr:
        RustLib.instance.api.rust_arc_decrement_strong_count_MacOsConfigPtr,
  );
}

// Rust type: RustOpaqueMoi<flutter_rust_bridge::for_generated::rust_async::RwLock<VerifyBody>>
@sealed
class VerifyBody extends RustOpaque {
  VerifyBody.dcoDecode(List<dynamic> wire)
      : super.dcoDecode(wire, _kStaticData);

  VerifyBody.sseDecode(int ptr, int externalSizeOnNative)
      : super.sseDecode(ptr, externalSizeOnNative, _kStaticData);

  static final _kStaticData = RustArcStaticData(
    rustArcIncrementStrongCount:
        RustLib.instance.api.rust_arc_increment_strong_count_VerifyBody,
    rustArcDecrementStrongCount:
        RustLib.instance.api.rust_arc_decrement_strong_count_VerifyBody,
    rustArcDecrementStrongCountPtr:
        RustLib.instance.api.rust_arc_decrement_strong_count_VerifyBodyPtr,
  );
}

class DartAttachment {
  final DartAttachmentType aType;
  final int partIdx;
  final String utiType;
  final String mime;
  final String name;
  final bool iris;

  const DartAttachment({
    required this.aType,
    required this.partIdx,
    required this.utiType,
    required this.mime,
    required this.name,
    required this.iris,
  });

  Future<int> getSize({dynamic hint}) =>
      RustLib.instance.api.dartAttachmentGetSize(
        that: this,
      );

  static Future<DartAttachment> restore(
          {required String saved, dynamic hint}) =>
      RustLib.instance.api.dartAttachmentRestore(saved: saved, hint: hint);

  Future<String> save({dynamic hint}) =>
      RustLib.instance.api.dartAttachmentSave(
        that: this,
      );

  @override
  int get hashCode =>
      aType.hashCode ^
      partIdx.hashCode ^
      utiType.hashCode ^
      mime.hashCode ^
      name.hashCode ^
      iris.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DartAttachment &&
          runtimeType == other.runtimeType &&
          aType == other.aType &&
          partIdx == other.partIdx &&
          utiType == other.utiType &&
          mime == other.mime &&
          name == other.name &&
          iris == other.iris;
}

@freezed
sealed class DartAttachmentType with _$DartAttachmentType {
  const factory DartAttachmentType.inline(
    Uint8List field0,
  ) = DartAttachmentType_Inline;
  const factory DartAttachmentType.mmcs(
    DartMMCSFile field0,
  ) = DartAttachmentType_MMCS;
}

class DartBalloonBody {
  String bid;
  Uint8List data;

  DartBalloonBody({
    required this.bid,
    required this.data,
  });

  @override
  int get hashCode => bid.hashCode ^ data.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DartBalloonBody &&
          runtimeType == other.runtimeType &&
          bid == other.bid &&
          data == other.data;
}

class DartChangeParticipantMessage {
  final List<String> newParticipants;
  final int groupVersion;

  const DartChangeParticipantMessage({
    required this.newParticipants,
    required this.groupVersion,
  });

  @override
  int get hashCode => newParticipants.hashCode ^ groupVersion.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DartChangeParticipantMessage &&
          runtimeType == other.runtimeType &&
          newParticipants == other.newParticipants &&
          groupVersion == other.groupVersion;
}

class DartConversationData {
  List<String> participants;
  String? cvName;
  String? senderGuid;

  DartConversationData({
    required this.participants,
    this.cvName,
    this.senderGuid,
  });

  @override
  int get hashCode =>
      participants.hashCode ^ cvName.hashCode ^ senderGuid.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DartConversationData &&
          runtimeType == other.runtimeType &&
          participants == other.participants &&
          cvName == other.cvName &&
          senderGuid == other.senderGuid;
}

class DartEditMessage {
  final String tuuid;
  final int editPart;
  final DartMessageParts newParts;

  const DartEditMessage({
    required this.tuuid,
    required this.editPart,
    required this.newParts,
  });

  @override
  int get hashCode => tuuid.hashCode ^ editPart.hashCode ^ newParts.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DartEditMessage &&
          runtimeType == other.runtimeType &&
          tuuid == other.tuuid &&
          editPart == other.editPart &&
          newParts == other.newParts;
}

class DartHwExtra {
  final String version;
  final int protocolVersion;
  final String deviceId;
  final String icloudUa;
  final String aoskitVersion;

  const DartHwExtra({
    required this.version,
    required this.protocolVersion,
    required this.deviceId,
    required this.icloudUa,
    required this.aoskitVersion,
  });

  @override
  int get hashCode =>
      version.hashCode ^
      protocolVersion.hashCode ^
      deviceId.hashCode ^
      icloudUa.hashCode ^
      aoskitVersion.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DartHwExtra &&
          runtimeType == other.runtimeType &&
          version == other.version &&
          protocolVersion == other.protocolVersion &&
          deviceId == other.deviceId &&
          icloudUa == other.icloudUa &&
          aoskitVersion == other.aoskitVersion;
}

class DartIMessage {
  String id;
  String? sender;
  String? afterGuid;
  DartConversationData? conversation;
  DartMessage message;
  int sentTimestamp;

  DartIMessage({
    required this.id,
    this.sender,
    this.afterGuid,
    this.conversation,
    required this.message,
    required this.sentTimestamp,
  });

  @override
  int get hashCode =>
      id.hashCode ^
      sender.hashCode ^
      afterGuid.hashCode ^
      conversation.hashCode ^
      message.hashCode ^
      sentTimestamp.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DartIMessage &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          sender == other.sender &&
          afterGuid == other.afterGuid &&
          conversation == other.conversation &&
          message == other.message &&
          sentTimestamp == other.sentTimestamp;
}

class DartIconChangeMessage {
  final DartMMCSFile? file;
  final int groupVersion;

  const DartIconChangeMessage({
    this.file,
    required this.groupVersion,
  });

  @override
  int get hashCode => file.hashCode ^ groupVersion.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DartIconChangeMessage &&
          runtimeType == other.runtimeType &&
          file == other.file &&
          groupVersion == other.groupVersion;
}

class DartIndexedMessagePart {
  final DartMessagePart field0;
  final int? field1;

  const DartIndexedMessagePart({
    required this.field0,
    this.field1,
  });

  @override
  int get hashCode => field0.hashCode ^ field1.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DartIndexedMessagePart &&
          runtimeType == other.runtimeType &&
          field0 == other.field0 &&
          field1 == other.field1;
}

@freezed
sealed class DartLoginState with _$DartLoginState {
  const factory DartLoginState.loggedIn() = DartLoginState_LoggedIn;
  const factory DartLoginState.needsDevice2Fa() = DartLoginState_NeedsDevice2FA;
  const factory DartLoginState.needs2FaVerification() =
      DartLoginState_Needs2FAVerification;
  const factory DartLoginState.needsSms2Fa() = DartLoginState_NeedsSMS2FA;
  const factory DartLoginState.needsSms2FaVerification(
    VerifyBody field0,
  ) = DartLoginState_NeedsSMS2FAVerification;
  const factory DartLoginState.needsExtraStep(
    String field0,
  ) = DartLoginState_NeedsExtraStep;
  const factory DartLoginState.needsLogin() = DartLoginState_NeedsLogin;
}

@freezed
sealed class DartMessage with _$DartMessage {
  const factory DartMessage.message(
    DartNormalMessage field0,
  ) = DartMessage_Message;
  const factory DartMessage.renameMessage(
    DartRenameMessage field0,
  ) = DartMessage_RenameMessage;
  const factory DartMessage.changeParticipants(
    DartChangeParticipantMessage field0,
  ) = DartMessage_ChangeParticipants;
  const factory DartMessage.react(
    DartReactMessage field0,
  ) = DartMessage_React;
  const factory DartMessage.delivered() = DartMessage_Delivered;
  const factory DartMessage.read() = DartMessage_Read;
  const factory DartMessage.typing() = DartMessage_Typing;
  const factory DartMessage.unsend(
    DartUnsendMessage field0,
  ) = DartMessage_Unsend;
  const factory DartMessage.edit(
    DartEditMessage field0,
  ) = DartMessage_Edit;
  const factory DartMessage.iconChange(
    DartIconChangeMessage field0,
  ) = DartMessage_IconChange;
  const factory DartMessage.stopTyping() = DartMessage_StopTyping;
}

@freezed
sealed class DartMessagePart with _$DartMessagePart {
  const factory DartMessagePart.text(
    String field0,
  ) = DartMessagePart_Text;
  const factory DartMessagePart.attachment(
    DartAttachment field0,
  ) = DartMessagePart_Attachment;
}

class DartMessageParts {
  final List<DartIndexedMessagePart> field0;

  const DartMessageParts({
    required this.field0,
  });

  Future<String> asPlain({dynamic hint}) =>
      RustLib.instance.api.dartMessagePartsAsPlain(
        that: this,
      );

  @override
  int get hashCode => field0.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DartMessageParts &&
          runtimeType == other.runtimeType &&
          field0 == other.field0;
}

class DartMMCSFile {
  final Uint8List signature;
  final String object;
  final String url;
  final Uint8List key;
  final int size;

  const DartMMCSFile({
    required this.signature,
    required this.object,
    required this.url,
    required this.key,
    required this.size,
  });

  @override
  int get hashCode =>
      signature.hashCode ^
      object.hashCode ^
      url.hashCode ^
      key.hashCode ^
      size.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DartMMCSFile &&
          runtimeType == other.runtimeType &&
          signature == other.signature &&
          object == other.object &&
          url == other.url &&
          key == other.key &&
          size == other.size;
}

class DartNormalMessage {
  DartMessageParts parts;
  DartBalloonBody? body;
  String? effect;
  String? replyGuid;
  String? replyPart;

  DartNormalMessage({
    required this.parts,
    this.body,
    this.effect,
    this.replyGuid,
    this.replyPart,
  });

  @override
  int get hashCode =>
      parts.hashCode ^
      body.hashCode ^
      effect.hashCode ^
      replyGuid.hashCode ^
      replyPart.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DartNormalMessage &&
          runtimeType == other.runtimeType &&
          parts == other.parts &&
          body == other.body &&
          effect == other.effect &&
          replyGuid == other.replyGuid &&
          replyPart == other.replyPart;
}

class DartReactMessage {
  final String toUuid;
  final int toPart;
  final bool enable;
  final DartReaction reaction;
  final String toText;

  const DartReactMessage({
    required this.toUuid,
    required this.toPart,
    required this.enable,
    required this.reaction,
    required this.toText,
  });

  @override
  int get hashCode =>
      toUuid.hashCode ^
      toPart.hashCode ^
      enable.hashCode ^
      reaction.hashCode ^
      toText.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DartReactMessage &&
          runtimeType == other.runtimeType &&
          toUuid == other.toUuid &&
          toPart == other.toPart &&
          enable == other.enable &&
          reaction == other.reaction &&
          toText == other.toText;
}

enum DartReaction {
  heart,
  like,
  dislike,
  laugh,
  emphsize,
  question,
}

@freezed
sealed class DartRegisterState with _$DartRegisterState {
  const factory DartRegisterState.registered() = DartRegisterState_Registered;
  const factory DartRegisterState.registering() = DartRegisterState_Registering;
  const factory DartRegisterState.failed({
    required int retryWait,
    required String error,
  }) = DartRegisterState_Failed;
}

class DartRenameMessage {
  final String newName;

  const DartRenameMessage({
    required this.newName,
  });

  @override
  int get hashCode => newName.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DartRenameMessage &&
          runtimeType == other.runtimeType &&
          newName == other.newName;
}

class DartSupportAction {
  final String url;
  final String button;

  const DartSupportAction({
    required this.url,
    required this.button,
  });

  @override
  int get hashCode => url.hashCode ^ button.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DartSupportAction &&
          runtimeType == other.runtimeType &&
          url == other.url &&
          button == other.button;
}

class DartSupportAlert {
  final String title;
  final String body;
  final DartSupportAction? action;

  const DartSupportAlert({
    required this.title,
    required this.body,
    this.action,
  });

  @override
  int get hashCode => title.hashCode ^ body.hashCode ^ action.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DartSupportAlert &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          body == other.body &&
          action == other.action;
}

class DartTrustedPhoneNumber {
  final String numberWithDialCode;
  final String lastTwoDigits;
  final String pushMode;
  final int id;

  const DartTrustedPhoneNumber({
    required this.numberWithDialCode,
    required this.lastTwoDigits,
    required this.pushMode,
    required this.id,
  });

  @override
  int get hashCode =>
      numberWithDialCode.hashCode ^
      lastTwoDigits.hashCode ^
      pushMode.hashCode ^
      id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DartTrustedPhoneNumber &&
          runtimeType == other.runtimeType &&
          numberWithDialCode == other.numberWithDialCode &&
          lastTwoDigits == other.lastTwoDigits &&
          pushMode == other.pushMode &&
          id == other.id;
}

class DartUnsendMessage {
  final String tuuid;
  final int editPart;

  const DartUnsendMessage({
    required this.tuuid,
    required this.editPart,
  });

  @override
  int get hashCode => tuuid.hashCode ^ editPart.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DartUnsendMessage &&
          runtimeType == other.runtimeType &&
          tuuid == other.tuuid &&
          editPart == other.editPart;
}

class MMCSTransferProgress {
  final int prog;
  final int total;
  final DartMMCSFile? file;

  const MMCSTransferProgress({
    required this.prog,
    required this.total,
    this.file,
  });

  @override
  int get hashCode => prog.hashCode ^ total.hashCode ^ file.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MMCSTransferProgress &&
          runtimeType == other.runtimeType &&
          prog == other.prog &&
          total == other.total &&
          file == other.file;
}

enum RegistrationPhase {
  wantsOsConfig,
  wantsUserPass,
  wantsRegister,
  registered,
}

class TransferProgress {
  final int prog;
  final int total;
  final DartAttachment? attachment;

  const TransferProgress({
    required this.prog,
    required this.total,
    this.attachment,
  });

  @override
  int get hashCode => prog.hashCode ^ total.hashCode ^ attachment.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransferProgress &&
          runtimeType == other.runtimeType &&
          prog == other.prog &&
          total == other.total &&
          attachment == other.attachment;
}
