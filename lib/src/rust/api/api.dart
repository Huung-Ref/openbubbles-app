// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.1.0.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../frb_generated.dart';
import '../lib.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'package:freezed_annotation/freezed_annotation.dart' hide protected;
part 'api.freezed.dart';

// These functions are ignored because they are not marked as `pub`: `config`, `get_phase`, `get_raw`, `get_raw`, `get_raw`, `plist_to_bin`, `plist_to_buf`, `plist_to_string`, `restore`, `setup_push`, `to_imsg`, `wrap_sink`
// These functions are ignored because they have generic arguments: `bin_deserialize`, `bin_serialize`
// These types are ignored because they are not used by any `pub` functions: `FLUTTER_RUST_BRIDGE_HANDLER`, `InnerPushState`, `SavedHardwareState`
// These function are ignored because they are on traits that is not defined in current crate (put an empty `#[frb]` on it to unignore): `clone`, `clone`, `clone`, `deref`, `deref`, `eq`, `fmt`, `from`, `from`, `from`, `initialize`, `into`, `into`, `spawn`

Future<ArcPushState> newPushState({required String dir}) =>
    RustLib.instance.api.crateApiApiNewPushState(dir: dir);

Future<ArcPushState> serviceFromPtr({required String ptr}) =>
    RustLib.instance.api.crateApiApiServiceFromPtr(ptr: ptr);

Future<DartSupportAlert?> registerIds(
        {required ArcPushState state, required List<IdsUser> users}) =>
    RustLib.instance.api.crateApiApiRegisterIds(state: state, users: users);

Future<void> configureAppReview({required ArcPushState state}) =>
    RustLib.instance.api.crateApiApiConfigureAppReview(state: state);

Future<void> configureMacos(
        {required ArcPushState state, required JoinedOsConfig config}) =>
    RustLib.instance.api
        .crateApiApiConfigureMacos(state: state, config: config);

Future<JoinedOsConfig> configFromValidationData(
        {required List<int> data, required DartHwExtra extra}) =>
    RustLib.instance.api
        .crateApiApiConfigFromValidationData(data: data, extra: extra);

Future<JoinedOsConfig> configFromRelay(
        {required String code, required String host, String? token}) =>
    RustLib.instance.api
        .crateApiApiConfigFromRelay(code: code, host: host, token: token);

Future<DartDeviceInfo> getDeviceInfoState({required ArcPushState state}) =>
    RustLib.instance.api.crateApiApiGetDeviceInfoState(state: state);

Future<JoinedOsConfig?> getConfigState({required ArcPushState state}) =>
    RustLib.instance.api.crateApiApiGetConfigState(state: state);

Future<DartDeviceInfo> getDeviceInfo({required JoinedOsConfig config}) =>
    RustLib.instance.api.crateApiApiGetDeviceInfo(config: config);

Future<JoinedOsConfig> configFromEncoded({required List<int> encoded}) =>
    RustLib.instance.api.crateApiApiConfigFromEncoded(encoded: encoded);

Future<DartIMessage> ptrToDart({required String ptr}) =>
    RustLib.instance.api.crateApiApiPtrToDart(ptr: ptr);

Future<PollResult> recvWait({required ArcPushState state}) =>
    RustLib.instance.api.crateApiApiRecvWait(state: state);

Future<void> send({required ArcPushState state, required DartIMessage msg}) =>
    RustLib.instance.api.crateApiApiSend(state: state, msg: msg);

Future<List<String>> getHandles({required ArcPushState state}) =>
    RustLib.instance.api.crateApiApiGetHandles(state: state);

Future<void> doReregister({required ArcPushState state}) =>
    RustLib.instance.api.crateApiApiDoReregister(state: state);

Future<DartIMessage> newMsg(
        {required ArcPushState state,
        required DartConversationData conversation,
        required String sender,
        required DartMessage message}) =>
    RustLib.instance.api.crateApiApiNewMsg(
        state: state,
        conversation: conversation,
        sender: sender,
        message: message);

Future<List<String>> validateTargets(
        {required ArcPushState state,
        required List<String> targets,
        required String sender}) =>
    RustLib.instance.api.crateApiApiValidateTargets(
        state: state, targets: targets, sender: sender);

Future<RegistrationPhase> getPhase({required ArcPushState state}) =>
    RustLib.instance.api.crateApiApiGetPhase(state: state);

Stream<TransferProgress> downloadAttachment(
        {required ArcPushState state,
        required DartAttachment attachment,
        required String path}) =>
    RustLib.instance.api.crateApiApiDownloadAttachment(
        state: state, attachment: attachment, path: path);

Stream<TransferProgress> downloadMmcs(
        {required ArcPushState state,
        required DartMMCSFile attachment,
        required String path}) =>
    RustLib.instance.api.crateApiApiDownloadMmcs(
        state: state, attachment: attachment, path: path);

Stream<MMCSTransferProgress> uploadMmcs(
        {required ArcPushState state, required String path}) =>
    RustLib.instance.api.crateApiApiUploadMmcs(state: state, path: path);

Stream<TransferProgress> uploadAttachment(
        {required ArcPushState state,
        required String path,
        required String mime,
        required String uti,
        required String name}) =>
    RustLib.instance.api.crateApiApiUploadAttachment(
        state: state, path: path, mime: mime, uti: uti, name: name);

Future<Uint8List> getToken({required ArcPushState state}) =>
    RustLib.instance.api.crateApiApiGetToken(state: state);

Future<String> saveUser({required IdsUser user}) =>
    RustLib.instance.api.crateApiApiSaveUser(user: user);

Future<IdsUser> restoreUser({required String user}) =>
    RustLib.instance.api.crateApiApiRestoreUser(user: user);

Future<(DartLoginState, IdsUser?)> tryAuth(
        {required ArcPushState state,
        required String username,
        required String password}) =>
    RustLib.instance.api.crateApiApiTryAuth(
        state: state, username: username, password: password);

Future<IdsUser> authPhone(
        {required ArcPushState state,
        required String number,
        required List<int> sig}) =>
    RustLib.instance.api
        .crateApiApiAuthPhone(state: state, number: number, sig: sig);

Future<DartLoginState> send2FaToDevices({required ArcPushState state}) =>
    RustLib.instance.api.crateApiApiSend2FaToDevices(state: state);

Future<(DartLoginState, IdsUser?)> verify2Fa(
        {required ArcPushState state, required String code}) =>
    RustLib.instance.api.crateApiApiVerify2Fa(state: state, code: code);

Future<(List<DartTrustedPhoneNumber>, DartLoginState?)> get2FaSmsOpts(
        {required ArcPushState state}) =>
    RustLib.instance.api.crateApiApiGet2FaSmsOpts(state: state);

Future<DartLoginState> send2FaSms(
        {required ArcPushState state, required int phoneId}) =>
    RustLib.instance.api.crateApiApiSend2FaSms(state: state, phoneId: phoneId);

Future<(DartLoginState, IdsUser?)> verify2FaSms(
        {required ArcPushState state,
        required VerifyBody body,
        required String code}) =>
    RustLib.instance.api
        .crateApiApiVerify2FaSms(state: state, body: body, code: code);

Future<List<String>> validateCert(
        {required ArcPushState state, required IdsUser user}) =>
    RustLib.instance.api.crateApiApiValidateCert(state: state, user: user);

Future<void> resetState({required ArcPushState state, required bool resetHw}) =>
    RustLib.instance.api.crateApiApiResetState(state: state, resetHw: resetHw);

Future<void> invalidateIdCache({required ArcPushState state}) =>
    RustLib.instance.api.crateApiApiInvalidateIdCache(state: state);

Future<String> getUserName({required ArcPushState state}) =>
    RustLib.instance.api.crateApiApiGetUserName(state: state);

Future<DartRegisterState> getRegstate({required ArcPushState state}) =>
    RustLib.instance.api.crateApiApiGetRegstate(state: state);

Future<String> convertTokenToUuid(
        {required ArcPushState state,
        required String handle,
        required List<int> token}) =>
    RustLib.instance.api.crateApiApiConvertTokenToUuid(
        state: state, handle: handle, token: token);

Future<List<DartPrivateDeviceInfo>> getSmsTargets(
        {required ArcPushState state,
        required String handle,
        required bool refresh}) =>
    RustLib.instance.api.crateApiApiGetSmsTargets(
        state: state, handle: handle, refresh: refresh);

// Rust type: RustOpaqueMoi<flutter_rust_bridge::for_generated::RustAutoOpaqueInner<IDSUser>>
abstract class IdsUser implements RustOpaqueInterface {}

// Rust type: RustOpaqueMoi<flutter_rust_bridge::for_generated::RustAutoOpaqueInner<JoinedOSConfig>>
abstract class JoinedOsConfig implements RustOpaqueInterface {}

// Rust type: RustOpaqueMoi<flutter_rust_bridge::for_generated::RustAutoOpaqueInner<VerifyBody>>
abstract class VerifyBody implements RustOpaqueInterface {}

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

  Future<int> getSize() =>
      RustLib.instance.api.crateApiApiDartAttachmentGetSize(
        that: this,
      );

  static Future<DartAttachment> restore({required String saved}) =>
      RustLib.instance.api.crateApiApiDartAttachmentRestore(saved: saved);

  Future<String> save() => RustLib.instance.api.crateApiApiDartAttachmentSave(
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
  const DartAttachmentType._();

  const factory DartAttachmentType.inline(
    Uint8List field0,
  ) = DartAttachmentType_Inline;
  const factory DartAttachmentType.mmcs(
    DartMMCSFile field0,
  ) = DartAttachmentType_MMCS;
}

class DartBalloon {
  final String url;
  final String? session;
  final DartBalloonLayout layout;
  final String? ldText;
  final bool isLive;
  final Uint8List icon;

  const DartBalloon({
    required this.url,
    this.session,
    required this.layout,
    this.ldText,
    required this.isLive,
    required this.icon,
  });

  @override
  int get hashCode =>
      url.hashCode ^
      session.hashCode ^
      layout.hashCode ^
      ldText.hashCode ^
      isLive.hashCode ^
      icon.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DartBalloon &&
          runtimeType == other.runtimeType &&
          url == other.url &&
          session == other.session &&
          layout == other.layout &&
          ldText == other.ldText &&
          isLive == other.isLive &&
          icon == other.icon;
}

@freezed
sealed class DartBalloonLayout with _$DartBalloonLayout {
  const DartBalloonLayout._();

  const factory DartBalloonLayout.templateLayout({
    required String imageSubtitle,
    required String imageTitle,
    required String caption,
    required String secondarySubcaption,
    required String tertiarySubcaption,
    required String subcaption,
    required NSDictionaryClass class_,
  }) = DartBalloonLayout_TemplateLayout;
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
  String? afterGuid;

  DartConversationData({
    required this.participants,
    this.cvName,
    this.senderGuid,
    this.afterGuid,
  });

  @override
  int get hashCode =>
      participants.hashCode ^
      cvName.hashCode ^
      senderGuid.hashCode ^
      afterGuid.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DartConversationData &&
          runtimeType == other.runtimeType &&
          participants == other.participants &&
          cvName == other.cvName &&
          senderGuid == other.senderGuid &&
          afterGuid == other.afterGuid;
}

class DartDeviceInfo {
  final String name;
  final String serial;
  final String osVersion;
  final Uint8List? encodedData;

  const DartDeviceInfo({
    required this.name,
    required this.serial,
    required this.osVersion,
    this.encodedData,
  });

  @override
  int get hashCode =>
      name.hashCode ^
      serial.hashCode ^
      osVersion.hashCode ^
      encodedData.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DartDeviceInfo &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          serial == other.serial &&
          osVersion == other.osVersion &&
          encodedData == other.encodedData;
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

class DartExtensionApp {
  final String name;
  final int appId;
  final String bundleId;
  final DartBalloon? balloon;

  const DartExtensionApp({
    required this.name,
    required this.appId,
    required this.bundleId,
    this.balloon,
  });

  @override
  int get hashCode =>
      name.hashCode ^ appId.hashCode ^ bundleId.hashCode ^ balloon.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DartExtensionApp &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          appId == other.appId &&
          bundleId == other.bundleId &&
          balloon == other.balloon;
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
  DartConversationData? conversation;
  DartMessage message;
  int sentTimestamp;
  List<DartMessageTarget>? target;
  bool sendDelivered;

  DartIMessage({
    required this.id,
    this.sender,
    this.conversation,
    required this.message,
    required this.sentTimestamp,
    this.target,
    required this.sendDelivered,
  });

  @override
  int get hashCode =>
      id.hashCode ^
      sender.hashCode ^
      conversation.hashCode ^
      message.hashCode ^
      sentTimestamp.hashCode ^
      target.hashCode ^
      sendDelivered.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DartIMessage &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          sender == other.sender &&
          conversation == other.conversation &&
          message == other.message &&
          sentTimestamp == other.sentTimestamp &&
          target == other.target &&
          sendDelivered == other.sendDelivered;
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
  final DartMessagePart part_;
  final int? idx;
  final DartPartExtension? ext;

  const DartIndexedMessagePart({
    required this.part_,
    this.idx,
    this.ext,
  });

  @override
  int get hashCode => part_.hashCode ^ idx.hashCode ^ ext.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DartIndexedMessagePart &&
          runtimeType == other.runtimeType &&
          part_ == other.part_ &&
          idx == other.idx &&
          ext == other.ext;
}

@freezed
sealed class DartLoginState with _$DartLoginState {
  const DartLoginState._();

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
  const DartMessage._();

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
  const factory DartMessage.enableSmsActivation(
    bool field0,
  ) = DartMessage_EnableSmsActivation;
  const factory DartMessage.messageReadOnDevice() =
      DartMessage_MessageReadOnDevice;
  const factory DartMessage.smsConfirmSent(
    bool field0,
  ) = DartMessage_SmsConfirmSent;
  const factory DartMessage.markUnread() = DartMessage_MarkUnread;
  const factory DartMessage.peerCacheInvalidate() =
      DartMessage_PeerCacheInvalidate;
  const factory DartMessage.updateExtension(
    DartUpdateExtensionMessage field0,
  ) = DartMessage_UpdateExtension;
}

@freezed
sealed class DartMessagePart with _$DartMessagePart {
  const DartMessagePart._();

  const factory DartMessagePart.text(
    String field0,
  ) = DartMessagePart_Text;
  const factory DartMessagePart.attachment(
    DartAttachment field0,
  ) = DartMessagePart_Attachment;
  const factory DartMessagePart.mention(
    String field0,
    String field1,
  ) = DartMessagePart_Mention;
  const factory DartMessagePart.object(
    String field0,
  ) = DartMessagePart_Object;
}

class DartMessageParts {
  final List<DartIndexedMessagePart> field0;

  const DartMessageParts({
    required this.field0,
  });

  Future<String> asPlain() =>
      RustLib.instance.api.crateApiApiDartMessagePartsAsPlain(
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

@freezed
sealed class DartMessageTarget with _$DartMessageTarget {
  const DartMessageTarget._();

  const factory DartMessageTarget.token(
    Uint8List field0,
  ) = DartMessageTarget_Token;
  const factory DartMessageTarget.uuid(
    String field0,
  ) = DartMessageTarget_Uuid;
}

@freezed
sealed class DartMessageType with _$DartMessageType {
  const DartMessageType._();

  const factory DartMessageType.iMessage() = DartMessageType_IMessage;
  const factory DartMessageType.sms({
    required bool isPhone,
    required String usingNumber,
    String? fromHandle,
  }) = DartMessageType_SMS;
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
  String? effect;
  String? replyGuid;
  String? replyPart;
  final DartMessageType service;
  String? subject;
  DartExtensionApp? app;

  DartNormalMessage({
    required this.parts,
    this.effect,
    this.replyGuid,
    this.replyPart,
    required this.service,
    this.subject,
    this.app,
  });

  @override
  int get hashCode =>
      parts.hashCode ^
      effect.hashCode ^
      replyGuid.hashCode ^
      replyPart.hashCode ^
      service.hashCode ^
      subject.hashCode ^
      app.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DartNormalMessage &&
          runtimeType == other.runtimeType &&
          parts == other.parts &&
          effect == other.effect &&
          replyGuid == other.replyGuid &&
          replyPart == other.replyPart &&
          service == other.service &&
          subject == other.subject &&
          app == other.app;
}

@freezed
sealed class DartPartExtension with _$DartPartExtension {
  const DartPartExtension._();

  const factory DartPartExtension.sticker({
    required double msgWidth,
    required double rotation,
    required BigInt sai,
    required double scale,
    bool? update,
    required BigInt sli,
    required double normalizedX,
    required double normalizedY,
    required BigInt version,
    required String hash,
    required BigInt safi,
    required PlatformInt64 effectType,
    required String stickerId,
  }) = DartPartExtension_Sticker;
}

class DartPrivateDeviceInfo {
  final String? uuid;
  final String? deviceName;
  final Uint8List token;
  final bool isHsaTrusted;
  final List<String> identites;
  final List<String> subServices;

  const DartPrivateDeviceInfo({
    this.uuid,
    this.deviceName,
    required this.token,
    required this.isHsaTrusted,
    required this.identites,
    required this.subServices,
  });

  @override
  int get hashCode =>
      uuid.hashCode ^
      deviceName.hashCode ^
      token.hashCode ^
      isHsaTrusted.hashCode ^
      identites.hashCode ^
      subServices.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DartPrivateDeviceInfo &&
          runtimeType == other.runtimeType &&
          uuid == other.uuid &&
          deviceName == other.deviceName &&
          token == other.token &&
          isHsaTrusted == other.isHsaTrusted &&
          identites == other.identites &&
          subServices == other.subServices;
}

class DartReactMessage {
  final String toUuid;
  final int? toPart;
  final DartReactMessageType reaction;
  final String toText;

  const DartReactMessage({
    required this.toUuid,
    this.toPart,
    required this.reaction,
    required this.toText,
  });

  @override
  int get hashCode =>
      toUuid.hashCode ^ toPart.hashCode ^ reaction.hashCode ^ toText.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DartReactMessage &&
          runtimeType == other.runtimeType &&
          toUuid == other.toUuid &&
          toPart == other.toPart &&
          reaction == other.reaction &&
          toText == other.toText;
}

@freezed
sealed class DartReactMessageType with _$DartReactMessageType {
  const DartReactMessageType._();

  const factory DartReactMessageType.react({
    required DartReaction reaction,
    required bool enable,
  }) = DartReactMessageType_React;
  const factory DartReactMessageType.extension_({
    required DartExtensionApp spec,
    required DartMessageParts body,
  }) = DartReactMessageType_Extension;
}

enum DartReaction {
  heart,
  like,
  dislike,
  laugh,
  emphsize,
  question,
  ;
}

@freezed
sealed class DartRegisterState with _$DartRegisterState {
  const DartRegisterState._();

  const factory DartRegisterState.registered() = DartRegisterState_Registered;
  const factory DartRegisterState.registering() = DartRegisterState_Registering;
  const factory DartRegisterState.failed({
    BigInt? retryWait,
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

class DartUpdateExtensionMessage {
  final String forUuid;
  final DartPartExtension ext;

  const DartUpdateExtensionMessage({
    required this.forUuid,
    required this.ext,
  });

  @override
  int get hashCode => forUuid.hashCode ^ ext.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DartUpdateExtensionMessage &&
          runtimeType == other.runtimeType &&
          forUuid == other.forUuid &&
          ext == other.ext;
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

class MyAsyncRuntime {
  const MyAsyncRuntime();

  static Future<MyAsyncRuntime> default_() =>
      RustLib.instance.api.crateApiApiMyAsyncRuntimeDefault();

  @override
  int get hashCode => 0;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyAsyncRuntime && runtimeType == other.runtimeType;
}

enum NSDictionaryClass {
  nsDictionary,
  nsMutableDictionary,
  ;
}

@freezed
sealed class PollResult with _$PollResult {
  const PollResult._();

  const factory PollResult.stop() = PollResult_Stop;
  const factory PollResult.cont([
    DartIMessage? field0,
  ]) = PollResult_Cont;
}

enum RegistrationPhase {
  wantsOsConfig,
  wantsRegister,
  registered,
  ;
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
