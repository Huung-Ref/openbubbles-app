import 'package:async_task/async_task_extension.dart';
import 'package:bluebubbles/src/rust/api/api.dart' as api;
import 'package:bluebubbles/helpers/helpers.dart';
import 'package:bluebubbles/models/models.dart';
import 'package:bluebubbles/services/services.dart';
import 'package:bluebubbles/utils/logger.dart';
import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:supercharged/supercharged.dart';
import 'package:tuple/tuple.dart';
import 'package:universal_io/io.dart';
import '../network/backend_service.dart';
import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';
import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:telephony_plus/telephony_plus.dart';

var uuid = const Uuid();
RustPushService pushService =
    Get.isRegistered<RustPushService>() ? Get.find<RustPushService>() : Get.put(RustPushService());


// utils for communicating between dart and rustpush.
class RustPushBBUtils {
  static Handle rustHandleToBB(String handle) {
    var address = handle.replaceAll("tel:", "").replaceAll("mailto:", "");
    var mHandle = Handle.findOne(addressAndService: Tuple2(address, "iMessage"));
    if (mHandle == null) {
      mHandle = Handle(
        address: handle.replaceAll("tel:", "").replaceAll("mailto:", "")
      );
      mHandle.save();
    }
    if (mHandle.originalROWID == null) {
      mHandle.originalROWID = mHandle.id!;
      mHandle.save();
    }
    return mHandle;
  }

  static Future<String> formatAddress(String e) async {
    if (e.isEmail) {
      return e;
    }
    var parsed = PhoneNumberUtil.instance.parse(e, "US");
    return PhoneNumberUtil.instance.format(parsed, PhoneNumberFormat.e164);
  }

  static Future<String> formatAndAddPrefix(String e) async {
    var address = await formatAddress(e);
    if (address.isEmail) {
      return "mailto:$address";
    } else {
      return "tel:$address";
    }
  }

  static String bbHandleToRust(Handle handle) {
    var address = handle.address;
    if (address.isEmail) {
      return "mailto:$address";
    } else {
      return "tel:$address";
    }
  }

  static Future<List<Handle>> rustParticipantsToBB(List<String> participants) async {
    var myHandles = (await api.getHandles(state: pushService.state));
    return participants.filter((e) => !myHandles.contains(e)).map((e) => rustHandleToBB(e)).toList();
  }

  static Map<String, String> modelMap = {
    "MacBookAir1,1": "MacBook Air 13\" (2008)",
    "MacBookAir2,1": "MacBook Air 13\" (2009)",
    "MacBookAir3,1": "MacBook Air 11\" (2010)",
    "MacBookAir3,2": "MacBook Air 13\" (2010)",
    "MacBookAir4,1": "MacBook Air 11\" (2011)",
    "MacBookAir4,2": "MacBook Air 13\" (2012)",
    "MacBookAir5,1": "MacBook Air 11\" (2012)",
    "MacBookAir5,2": "MacBook Air 13\" (2012)",
    "MacBookAir6,1": "MacBook Air 11\" (2014)",
    "MacBookAir6,2": "MacBook Air 13\" (2014)",
    "MacBookAir7,1": "MacBook Air 11\" (2015)",
    "MacBookAir7,2": "MacBook Air 13\" (2017)",
    "MacBookAir8,1": "MacBook Air 13\" (2018)",
    "MacBookAir8,2": "MacBook Air 13\" (2019)",
    "MacBookAir9,1": "MacBook Air 13\" (2020)",
    "MacBookAir10,1": "MacBook Air 13\" (2020)",
    "Mac14,2": "MacBook Air 13\" (2022)",
    "Mac14,15": "MacBook Air 15\" (2023)",
    "Mac15,12": "MacBook Air 13\" (2024)",
    "Mac15,13": "MacBook Air 15\" (2024)",
    "MacBookPro1,1": "MacBook Pro 15\" (2006)",
    "MacBookPro1,2": "MacBook Pro 17\" (2006)",
    "MacBookPro2,2": "MacBook Pro 15\" (2006)",
    "MacBookPro2,1": "MacBook Pro 17\" (2006)",
    "MacBookPro3,1": "MacBook Pro 17\" (2007)",
    "MacBookPro4,1": "MacBook Pro 17\" (2008)",
    "MacBookPro5,1": "MacBook Pro 15\" (2009)",
    "MacBookPro5,2": "MacBook Pro 17\" (2009)",
    "MacBookPro5,5": "MacBook Pro 13\" (2009)",
    "MacBookPro5,4": "MacBook Pro 15\" (2009)",
    "MacBookPro5,3": "MacBook Pro 15\" (2009)",
    "MacBookPro7,1": "MacBook Pro 13\" (2010)",
    "MacBookPro6,2": "MacBook Pro 15\" (2010)",
    "MacBookPro6,1": "MacBook Pro 17\" (2010)",
    "MacBookPro8,1": "MacBook Pro 13\" (2011)",
    "MacBookPro8,2": "MacBook Pro 15\" (2011)",
    "MacBookPro8,3": "MacBook Pro 17\" (2011)",
    "MacBookPro9,2": "MacBook Pro 13\" (2012)",
    "MacBookPro9,1": "MacBook Pro 15\" (2012)",
    "MacBookPro10,1": "MacBook Pro 15\" (2013)",
    "MacBookPro10,2": "MacBook Pro 13\" (2013)",
    "MacBookPro11,1": "MacBook Pro 13\" (2014)",
    "MacBookPro11,2": "MacBook Pro 15\" (2014)",
    "MacBookPro11,3": "MacBook Pro 15\" (2014)",
    "MacBookPro12,1": "MacBook Pro 13\" (2015)",
    "MacBookPro11,4": "MacBook Pro 15\" (2015)",
    "MacBookPro11,5": "MacBook Pro 15\" (2015)",
    "MacBookPro13,1": "MacBook Pro 13\" (2016)",
    "MacBookPro13,2": "MacBook Pro 13\" (2016)",
    "MacBookPro13,3": "MacBook Pro 15\" (2016)",
    "MacBookPro14,1": "MacBook Pro 13\" (2017)",
    "MacBookPro14,2": "MacBook Pro 13\" (2017)",
    "MacBookPro14,3": "MacBook Pro 15\" (2017)",
    "MacBookPro15,2": "MacBook Pro 13\" (2019)",
    "MacBookPro15,1": "MacBook Pro 15\" (2019)",
    "MacBookPro15,3": "MacBook Pro 15\" (2019)",
    "MacBookPro15,4": "MacBook Pro 13\" (2019)",
    "MacBookPro16,1": "MacBook Pro 16\" (2019)",
    "MacBookPro16,3": "MacBook Pro 13\" (2020)",
    "MacBookPro16,2": "MacBook Pro 13\" (2020)",
    "MacBookPro16,4": "MacBook Pro 16\" (2020)",
    "MacBookPro17,1": "MacBook Pro 13\" (2020)",
    "MacBookPro18,3": "MacBook Pro 14\" (2021)",
    "MacBookPro18,4": "MacBook Pro 14\" (2021)",
    "MacBookPro18,1": "MacBook Pro 16\" (2021)",
    "MacBookPro18,2": "MacBook Pro 16\" (2021)",
    "Mac14,7": "MacBook Pro 13\" (2022)",
    "Mac14,9": "MacBook Pro 14\" (2023)",
    "Mac14,5": "MacBook Pro 14\" (2023)",
    "Mac14,10": "MacBook Pro 16\" (2023)",
    "Mac14,6": "MacBook Pro 16\" (2023)",
    "Mac15,3": "MacBook Pro 14\" (2023)",
    "Mac15,6": "MacBook Pro 14\" (2023)",
    "Mac15,10": "MacBook Pro 14\" (2023)",
    "Mac15,8": "MacBook Pro 14\" (2023)",
    "Mac15,7": "MacBook Pro 16\" (2023)",
    "Mac15,11": "MacBook Pro 16\" (2023)",
    "Mac15,9": "MacBook Pro 16\" (2023)",
    "MacBook1,1": "MacBook 13\" (2006)",
    "MacBook2,1": "MacBook 13\" (2007)",
    "MacBook3,1": "MacBook 13\" (2007)",
    "MacBook4,1": "MacBook 13\" (2008)",
    "MacBook5,1": "MacBook 13\" (2008)",
    "MacBook5,2": "MacBook 13\" (2009)",
    "MacBook6,1": "MacBook 13\" (2009)",
    "MacBook7,1": "MacBook 13\" (2010)",
    "MacBook8,1": "MacBook 12\" (2015)",
    "MacBook9,1": "MacBook 12\" (2016)",
    "MacBook10,1": "MacBook 12\" (2017)",
    "iMac4,1": "iMac 20\" (2006)",
    "iMac4,2": "iMac 17\" (2006)",
    "iMac5,2": "iMac 17\" (2006)",
    "iMac5,1": "iMac 20\" (2006)",
    "iMac6,1": "iMac 24\" (2006)",
    "iMac7,1": "iMac 24\" (2007)",
    "iMac8,1": "iMac 24\" (2008)",
    "iMac9,1": "iMac 20\" (2010)",
    "iMac10,1": "iMac 27\" (2009)",
    "iMac11,1": "iMac 27\" (2009)",
    "iMac11,2": "iMac 21.5\" (2010)",
    "iMac11,3": "iMac 27\" (2010)",
    "iMac12,1": "iMac 21.5\" (2011)",
    "iMac12,2": "iMac 27\" (2011)",
    "iMac13,1": "iMac 21.5\" (2013)",
    "iMac13,2": "iMac 27\" (2012)",
    "iMac14,1": "iMac 21.5\" (2013)",
    "iMac14,3": "iMac 21.5\" (2013)",
    "iMac14,2": "iMac 27\" (2013)",
    "iMac14,4": "iMac 21.5\" (2014)",
    "iMac15,1": "iMac 27\" (2015)",
    "iMac16,1": "iMac 21.5\" (2015)",
    "iMac16,2": "iMac 21.5\" (2015)",
    "iMac17,1": "iMac 27\" (2015)",
    "iMac18,1": "iMac 21.5\" (2017)",
    "iMac18,2": "iMac 21.5\" (2017)",
    "iMac18,3": "iMac 27\" (2017)",
    "iMac19,2": "iMac 21.5\" (2019)",
    "iMac19,1": "iMac 27\" (2019)",
    "iMac20,1": "iMac 27\" (2020)",
    "iMac20,2": "iMac 27\" (2020)",
    "iMac21,2": "iMac 24\" (2021)",
    "iMac21,1": "iMac 24\" (2021)",
    "Mac15,4": "iMac 24\" (2023)",
    "Mac15,5": "iMac 24\" (2023)",
    "iMacPro1,1": "iMac Pro 27\" (2017)",
    "Macmini1,1": "Mac mini (2006)",
    "Macmini2,1": "Mac mini (2007)",
    "Macmini3,1": "Mac mini (2009)",
    "Macmini4,1": "Mac mini (2010)",
    "Macmini5,1": "Mac mini (2011)",
    "Macmini5,2": "Mac mini (2011)",
    "Macmini5,3": "Mac mini (2011)",
    "Macmini6,1": "Mac mini (2012)",
    "Macmini6,2": "Mac mini (2012)",
    "Macmini7,1": "Mac mini (2014)",
    "Macmini8,1": "Mac mini (2018)",
    "Macmini9,1": "Mac mini (2020)",
    "Mac14,3": "Mac mini (2023)",
    "Mac14,12": "Mac mini (2023)",
    "MacPro1,1*": "Mac Pro (2006)",
    "MacPro2,1": "Mac Pro (2007)",
    "MacPro3,1": "Mac Pro (2008)",
    "MacPro4,1": "Mac Pro (2009)",
    "MacPro5,1": "Mac Pro (2012)",
    "MacPro6,1": "Mac Pro (2013)",
    "MacPro7,1": "Mac Pro (2019)",
    "Mac14,8": "Mac Pro (2023)",
  };

  static bool isLaptop(String model) {
    return model.contains("MacBook");
  }

  static String modelToUser(String model) {
    return modelMap[model] ?? model;
  }
}

class RustPushBackend implements BackendService {
  Future<String> getDefaultHandle() async {
    var myHandles = await api.getHandles(state: pushService.state);
    var setHandle = Settings.getSettings().defaultHandle.value;
    if (myHandles.contains(setHandle)) {
      return setHandle;
    }
    return myHandles[0];
  }

  @override
  void init() {
    pushService.hello();
  }

  @override
  bool canCreateGroupChats() {
    return true;
  }

  @override
  bool supportsSmsForwarding() {
    return true;
  }

  Future<api.DartMessageType> getService(bool isSms, {Message? forMessage}) async {
    if (isSms) {
      String? fromHandle;
      if (forMessage != null && forMessage.handle != null) {
        var myHandles = await api.getHandles(state: pushService.state);
        var sender = RustPushBBUtils.bbHandleToRust(forMessage.handle!);
        if (!myHandles.contains(sender)) {
          fromHandle = sender; // this is a forwarded message
        }
      }
      var number = "";
      if (!kIsDesktop) {
        // we don't need number on desktop, b/c it's only used for relaying messages to other devices
        // which desktops will never do
        number = await RustPushBBUtils.formatAddress(await TelephonyPlus().getNumber());
      }
      return api.DartMessageType.sms(isPhone: ss.settings.isSmsRouter.value, usingNumber: "tel:$number", fromHandle: fromHandle);
    }
    return const api.DartMessageType.iMessage();
  }

  @override
  Future<Chat> createChat(List<String> addresses, String? message, String service,
      {CancelToken? cancelToken}) async {
    var handle = await getDefaultHandle();
    var formattedHandles = (await Future.wait(
              addresses.map((e) async => RustPushBBUtils.rustHandleToBB(await RustPushBBUtils.formatAddress(e)))))
          .toList();
    var chat = Chat(
      guid: uuid.v4(),
      participants: formattedHandles,
      usingHandle: handle,
      isRpSms: service == "SMS"
    );
    chat.save(); //save for reflectMessage
    if (message != null) {
      var msg = await api.newMsg(
          state: pushService.state,
          conversation: await chat.getConversationData(),
          message: api.DartMessage.message(api.DartNormalMessage(
              parts: api.DartMessageParts(
                  field0: [api.DartIndexedMessagePart(field0: api.DartMessagePart.text(message))]),
                  service: await getService(chat.isRpSms)
                  )),
          sender: handle);
      await api.send(state: pushService.state, msg: msg);
      msg.sentTimestamp = DateTime.now().millisecondsSinceEpoch;

      final newMessage = await pushService.reflectMessageDyn(msg);
      newMessage.chat.target = chat;
      newMessage.forwardIfNessesary(chat);
      newMessage.save();
    }
    await chats.addChat(chat);
    return chat;
  }

  @override
  Future<PlatformFile> downloadAttachment(Attachment attachment,
      {void Function(int p1, int p2)? onReceiveProgress, bool original = false, CancelToken? cancelToken}) async {
    var rustAttachment = await api.DartAttachment.restore(saved: attachment.metadata!["rustpush"]);
    var stream = api.downloadAttachment(state: pushService.state, attachment: rustAttachment, path: attachment.path);
    await for (final event in stream) {
      if (onReceiveProgress != null) {
        onReceiveProgress(event.prog, event.total);
      }
    }
    return attachment.getFile();
  }

  @override
  Future<Message> sendAttachment(Chat chat, Message m, bool isAudioMessage, Attachment att, {void Function(int p1, int p2)? onSendProgress, CancelToken? cancelToken}) async {
    var stream = api.uploadAttachment(
        state: pushService.state,
        path: att.getFile().path!,
        mime: att.mimeType ?? "application/octet-stream",
        uti: att.uti ?? "public.data",
        name: att.transferName!);
    api.DartAttachment? attachment;
    await for (final event in stream) {
      if (event.attachment != null) {
        print("upload finish");
        attachment = event.attachment;
      } else if (onSendProgress != null) {
        print("upload progress ${event.prog} of ${event.total}");
        onSendProgress(event.prog, event.total);
      }
    }
    print("uploaded");
    var partIndex = int.tryParse(m.threadOriginatorPart?.split(":").firstOrNull ?? "");
    var msg = await api.newMsg(
        state: pushService.state,
        conversation: await chat.getConversationData(),
        sender: await chat.ensureHandle(),
        message: api.DartMessage.message(api.DartNormalMessage(
          parts: api.DartMessageParts(
              field0: [api.DartIndexedMessagePart(field0: api.DartMessagePart.attachment(attachment!))]),
          replyGuid: m.threadOriginatorGuid,
          replyPart: m.threadOriginatorGuid == null ? null : "$partIndex:0:0",
          effect: m.expressiveSendStyleId,
          service: await getService(chat.isRpSms, forMessage: m),
        )));
    await api.send(state: pushService.state, msg: msg);
    msg.sentTimestamp = DateTime.now().millisecondsSinceEpoch;
    return await pushService.reflectMessageDyn(msg);
  }

  Future<Message> forwardMMSAttachment(Chat chat, Message m, Attachment att) async {
    api.DartAttachment? attachment = api.DartAttachment(
      aType: api.DartAttachmentType.inline(await att.getFile().getBytes()),
      mime: att.mimeType ?? "application/octet-stream",
      partIdx: 0,
      utiType: att.uti ?? "public.data",
      name: att.transferName!,
      iris: false,
    );
    print("uploaded");
    var partIndex = int.tryParse(m.threadOriginatorPart?.split(":").firstOrNull ?? "");
    var service = await getService(chat.isRpSms, forMessage: m);
    var msg = await api.newMsg(
        state: pushService.state,
        conversation: await chat.getConversationData(),
        sender: await chat.ensureHandle(),
        message: api.DartMessage.message(api.DartNormalMessage(
          parts: api.DartMessageParts(
              field0: [api.DartIndexedMessagePart(field0: api.DartMessagePart.attachment(attachment!))]),
          replyGuid: m.threadOriginatorGuid,
          replyPart: m.threadOriginatorGuid == null ? null : "$partIndex:0:0",
          effect: m.expressiveSendStyleId,
          service: service,
        )));
    await api.send(state: pushService.state, msg: msg);
    msg.sentTimestamp = DateTime.now().millisecondsSinceEpoch;
    return await pushService.reflectMessageDyn(msg);
  }

  @override
  bool canCancelUploads() {
    return false;
  }

  Future<void> broadcastSmsForwardingState(bool state) async {
    var handles = await api.getHandles(state: pushService.state);
    var useHandle = handles.firstWhereOrNull((handle) => handle.contains("tel:")) ?? handles.first;
    var msg = await api.newMsg(
      state: pushService.state,
      conversation: api.DartConversationData(participants: [useHandle], cvName: null, senderGuid: null),
      sender: useHandle,
      message: api.DartMessage.enableSmsActivation(state),
    );
    await api.send(state: pushService.state, msg: msg);
  }

  Future<void> confirmSmsSent(Message m, Chat c) async {
    var msg = await api.newMsg(
      state: pushService.state,
      conversation: await c.getConversationData(),
      sender: await c.ensureHandle(),
      message: const api.DartMessage.smsConfirmSent(),
    );
    msg.id = m.guid!;
    await api.send(state: pushService.state, msg: msg);
  }

  @override
  Future<bool> canUploadGroupPhotos() async {
    return true;
  }

  @override
  Future<bool> deleteChatIcon(Chat chat, {CancelToken? cancelToken}) async {
    var msg = await api.newMsg(
      state: pushService.state,
      conversation: await chat.getConversationData(),
      sender: await chat.ensureHandle(),
      message: api.DartMessage.iconChange(api.DartIconChangeMessage(groupVersion: chat.groupVersion!)),
    );
    await api.send(state: pushService.state, msg: msg);
    return true;
  }

  @override
  Future<Map<String, dynamic>> getAccountInfo() async {
    var handles = await api.getHandles(state: pushService.state);
    var state = await api.getRegstate(state: pushService.state);
    var stateStr = "";
    if (state is api.DartRegisterState_Registered) {
      stateStr = "Connected";
    } else if (state is api.DartRegisterState_Registering) {
      stateStr = "Reregistering...";
    } else if (state is api.DartRegisterState_Failed) {
      stateStr = "Deregistered";
    }
    return {
      "account_name": Settings.getSettings().userName.value,
      "apple_id": Settings.getSettings().iCloudAccount.value,
      "login_status_message": stateStr,
      "vetted_aliases": handles.map((e) => {
        "Alias": e.replaceFirst("tel:", "").replaceFirst("mailto:", "")
      }).toList(),
      "active_alias": (await getDefaultHandle()).replaceFirst("tel:", "").replaceFirst("mailto:", ""),
      "sms_forwarding_capable": true,
      "sms_forwarding_enabled": ss.settings.smsForwardingEnabled.value,
    };
  }

  @override
  Future<void> setDefaultHandle(String defaultHandle) async {
    var ss = Settings.getSettings();
    ss.defaultHandle.value = await RustPushBBUtils.formatAndAddPrefix(defaultHandle);
    ss.save();
  }

  @override
  Future<Map<String, dynamic>> getAccountContact() async {
    return {};
  }

  @override
  Future<bool> setChatIcon(Chat chat,
      {void Function(int p1, int p2)? onSendProgress, CancelToken? cancelToken}) async {
    chat.groupVersion = (chat.groupVersion ?? -1) + 1;
    var mmcsStream = api.uploadMmcs(state: pushService.state, path: chat.customAvatarPath!);
    api.DartMMCSFile? mmcs;
    await for (final event in mmcsStream) {
      if (event.file != null) {
        print("upload finish");
        mmcs = event.file;
      } else if (onSendProgress != null) {
        print("upload progress ${event.prog} of ${event.total}");
        onSendProgress(event.prog, event.total);
      }
    }
    var msg = await api.newMsg(
      state: pushService.state,
      conversation: await chat.getConversationData(),
      sender: await chat.ensureHandle(),
      message: api.DartMessage.iconChange(api.DartIconChangeMessage(groupVersion: chat.groupVersion!, file: mmcs!)),
    );
    await api.send(state: pushService.state, msg: msg);
    return true;
  }

  @override
  Future<Message> sendMessage(Chat chat, Message m, {CancelToken? cancelToken}) async {
    var partIndex = int.tryParse(m.threadOriginatorPart?.split(":").firstOrNull ?? "");
    var msg = await api.newMsg(
      state: pushService.state,
      conversation: await chat.getConversationData(),
      sender: await chat.ensureHandle(),
      message: api.DartMessage.message(api.DartNormalMessage(
        parts: api.DartMessageParts(field0: [api.DartIndexedMessagePart(field0: api.DartMessagePart.text(m.text!))]),
        replyGuid: m.threadOriginatorGuid,
        replyPart: m.threadOriginatorGuid == null ? null : "$partIndex:0:0",
        effect: m.expressiveSendStyleId,
        service: await getService(chat.isRpSms, forMessage: m),
      )),
    );
    m.guid = msg.id;
    m.save(chat: chat);
    await api.send(state: pushService.state, msg: msg);
    msg.sentTimestamp = DateTime.now().millisecondsSinceEpoch;
    return await pushService.reflectMessageDyn(msg);
  }

  Future<bool> markDelivered(api.DartIMessage message) async {
    // all messages with c = 100 need to be acked
    if (!(message.message is api.DartMessage_React ||
        message.message is api.DartMessage_Message ||
        message.message is api.DartMessage_Typing)) {
      return true;
    }
    var chat = await pushService.chatForMessage(message);
    if (chat.isRpSms) {
      return true; // no delivery recipts :)
    }
    var msg = await api.newMsg(
      state: pushService.state,
      conversation: api.DartConversationData(
        participants: [message.sender!],
        cvName: message.conversation!.cvName,
        senderGuid: message.conversation!.senderGuid
      ),
      sender: await chat.ensureHandle(),
      message: const api.DartMessage.delivered(),
    );
    msg.id = message.id;
    await api.send(state: pushService.state, msg: msg);
    return true;
  }

  @override
  bool supportsFocusStates() {
    return false;
  }

  @override
  Future<bool> markRead(Chat chat) async {
    var latestMsg = chat.latestMessage.guid;
    var msg = await api.newMsg(
        state: pushService.state,
        conversation: await chat.getConversationData(),
        sender: await chat.ensureHandle(),
        message: const api.DartMessage.read());
    msg.id = latestMsg!;
    await api.send(state: pushService.state, msg: msg);
    return true;
  }

  @override
  Future<bool> renameChat(Chat chat, String newName) async {
    var data = await chat.getConversationData();
    var msg = await api.newMsg(
        state: pushService.state,
        conversation: data,
        sender: await chat.ensureHandle(),
        message: api.DartMessage.renameMessage(api.DartRenameMessage(newName: newName)));
    await api.send(state: pushService.state, msg: msg);
    msg.sentTimestamp = DateTime.now().millisecondsSinceEpoch;
    inq.queue(IncomingItem(
      chat: chat,
      message: await pushService.reflectMessageDyn(msg),
      type: QueueType.newMessage
    ));
    return true;
  }

  @override
  Future<bool> chatParticipant(ParticipantOp method, Chat chat, String newName) async {
    chat.groupVersion = (chat.groupVersion ?? -1) + 1;
    var data = await chat.getConversationData();
    var newParticipants = data.participants.copy();
    if (method == ParticipantOp.Add) {
      var target = await RustPushBBUtils.formatAndAddPrefix(newName);
      var valid =
          (await api.validateTargets(state: pushService.state, targets: [target], sender: await chat.ensureHandle()))
              .isNotEmpty;
      if (!valid) {
        return false;
      }
      newParticipants.add(target);
    } else if (method == ParticipantOp.Remove) {
      newParticipants.remove(await RustPushBBUtils.formatAndAddPrefix(newName));
    }
    var msg = await api.newMsg(
        state: pushService.state,
        conversation: data,
        sender: await chat.ensureHandle(),
        message: api.DartMessage.changeParticipants(
            api.DartChangeParticipantMessage(groupVersion: chat.groupVersion!, newParticipants: newParticipants)));
    await api.send(state: pushService.state, msg: msg);
    msg.sentTimestamp = DateTime.now().millisecondsSinceEpoch;
    inq.queue(IncomingItem(
      chat: chat,
      message: await pushService.reflectMessageDyn(msg),
      type: QueueType.newMessage
    ));
    return true;
  }

  @override
  Future<bool> leaveChat(Chat chat) async {
    var handle = RustPushBBUtils.rustHandleToBB(await chat.ensureHandle());
    return await chatParticipant(ParticipantOp.Remove, chat, handle.address);
  }

  var reactionMap = {
    ReactionTypes.LOVE: api.DartReaction.heart,
    ReactionTypes.LIKE: api.DartReaction.like,
    ReactionTypes.DISLIKE: api.DartReaction.dislike,
    ReactionTypes.LAUGH: api.DartReaction.laugh,
    ReactionTypes.EMPHASIZE: api.DartReaction.emphsize,
    ReactionTypes.QUESTION: api.DartReaction.question
  };

  @override
  Future<Message> sendTapback(
      Chat chat, Message selected, String reaction, int? repPart) async {
    var enabled = !reaction.startsWith("-");
    reaction = enabled ? reaction : reaction.substring(1);
    var msg = await api.newMsg(
        state: pushService.state,
        conversation: await chat.getConversationData(),
        sender: await chat.ensureHandle(),
        message: api.DartMessage.react(api.DartReactMessage(
            toUuid: selected.guid!,
            toPart: repPart ?? 0,
            toText: selected.text ?? "",
            enable: enabled,
            reaction: reactionMap[reaction]!)));
    await api.send(state: pushService.state, msg: msg);
    msg.sentTimestamp = DateTime.now().millisecondsSinceEpoch;
    return await pushService.reflectMessageDyn(msg);
  }

  @override
  Future<Message?> unsend(Message msgObj, MessagePart part) async {
    var msg = await api.newMsg(
        state: pushService.state,
        sender: await msgObj.chat.target!.ensureHandle(),
        conversation: await msgObj.chat.target!.getConversationData(),
        message: api.DartMessage.unsend(api.DartUnsendMessage(tuuid: msgObj.guid!, editPart: part.part)));
    await api.send(state: pushService.state, msg: msg);
    return await pushService.reflectMessageDyn(msg);
  }

  @override
  Future<Message?> edit(Message msgObj, String text, int part) async {
    var msg = await api.newMsg(
        state: pushService.state,
        conversation: await msgObj.chat.target!.getConversationData(),
        sender: await msgObj.chat.target!.ensureHandle(),
        message: api.DartMessage.edit(api.DartEditMessage(
            tuuid: msgObj.guid!,
            editPart: part,
            newParts: api.DartMessageParts(
                field0: [api.DartIndexedMessagePart(field0: api.DartMessagePart.text(text), field1: part)]))));
    await api.send(state: pushService.state, msg: msg);
    msg.sentTimestamp = DateTime.now().millisecondsSinceEpoch;
    return await pushService.reflectMessageDyn(msg);
  }

  @override
  HttpService? getRemoteService() {
    return null;
  }

  @override
  bool canLeaveChat() {
    return true;
  }

  @override
  bool canEditUnsend() {
    return true;
  }

  @override
  Future<bool> downloadLivePhoto(Attachment attachment, String target,
      {void Function(int p1, int p2)? onReceiveProgress, CancelToken? cancelToken}) async {
    var rustAttachment = await api.DartAttachment.restore(saved: attachment.metadata!["myIris"]);
    var stream = api.downloadAttachment(state: pushService.state, attachment: rustAttachment, path: target);
    await for (final event in stream) {
      if (onReceiveProgress != null) {
        onReceiveProgress(event.prog, event.total);
      }
    }
    return true;
  }

  @override
  bool canSchedule() {
    return false; // don't want to write a local db for scheduled messages rn
  }

  @override
  bool supportsFindMy() {
    return false;
  }

  @override
  void startedTyping(Chat c) async {
    if (c.participants.length > 1) {
      return; // no typing indicators for multiple chats
    }
    var msg = await api.newMsg(
      state: pushService.state,
      conversation: await c.getConversationData(),
      sender: await c.ensureHandle(),
      message: const api.DartMessage.typing()
    );
    await api.send(state: pushService.state, msg: msg);
  }

  @override
  void stoppedTyping(Chat c) async {
    if (c.participants.length > 1) {
      return; // no typing indicators for multiple chats
    }
    var msg = await api.newMsg(
      state: pushService.state,
      conversation: await c.getConversationData(),
      sender: await c.ensureHandle(),
      message: const api.DartMessage.stopTyping()
    );
    await api.send(state: pushService.state, msg: msg);
  }

  @override
  void updateTypingStatus(Chat c) {  }

  @override
  Future<bool> handleiMessageState(String address) async {
    var handle = await getDefaultHandle();
    var formatted = await RustPushBBUtils.formatAndAddPrefix(address);
    var available = await api.validateTargets(state: pushService.state, targets: [formatted], sender: handle);
    return available.isNotEmpty;
  }

}

class RustPushService extends GetxService {
  late api.ArcPushState state;

  Map<String, api.DartAttachment> attachments = {};

  var invReactionMap = {
    api.DartReaction.heart: ReactionTypes.LOVE,
    api.DartReaction.like: ReactionTypes.LIKE,
    api.DartReaction.dislike: ReactionTypes.DISLIKE,
    api.DartReaction.laugh: ReactionTypes.LAUGH,
    api.DartReaction.emphsize: ReactionTypes.EMPHASIZE,
    api.DartReaction.question: ReactionTypes.QUESTION,
  };

  Future<(AttributedBody, String, List<Attachment>)> indexedPartsToAttributedBodyDyn(
      List<api.DartIndexedMessagePart> parts, String msgId, AttributedBody? existingBody) async {
    var bodyString = "";
    List<Run> body = existingBody?.runs.copy() ?? [];
    List<Attachment> attachments = [];
    var index = -1;
    for (var indexedParts in parts) {
      index += 1;
      var part = indexedParts.field0;
      var fieldIdx = indexedParts.field1 ?? body.length;
      // remove old elements
      body.removeWhere((element) => element.attributes?.messagePart == fieldIdx);
      if (part is api.DartMessagePart_Text) {
        body.add(Run(
          range: [bodyString.length, part.field0.length],
          attributes: Attributes(
            messagePart: fieldIdx,
          )
        ));
        bodyString += part.field0;
      } else if (part is api.DartMessagePart_Attachment) {
        if (part.field0.iris) {
          continue;
        }
        api.DartAttachment? myIris;
        var next = parts.elementAtOrNull(index + 1);
        if (next != null && next.field0 is api.DartMessagePart_Attachment) {
          var nextA = next.field0 as api.DartMessagePart_Attachment;
          if (nextA.field0.iris) {
            myIris = nextA.field0;
          }
        }
        var myUuid = "${msgId}_$fieldIdx";
        attachments.add(Attachment(
          guid: myUuid,
          uti: part.field0.utiType,
          mimeType: part.field0.mime,
          isOutgoing: false,
          transferName: part.field0.name,
          totalBytes: await part.field0.getSize(),
          hasLivePhoto: myIris != null,
          metadata: {"rustpush": await part.field0.save(), "myIris": await myIris?.save()},
        ));
        body.add(Run(
          range: [bodyString.length, 1],
          attributes: Attributes(
            attachmentGuid: myUuid,
            messagePart: body.length
          )
        ));
        bodyString += " ";
      }
    }
    return (AttributedBody(string: bodyString, runs: body), bodyString, attachments);
  }

  Future<Message> reflectMessageDyn(api.DartIMessage myMsg) async {
    var chat = myMsg.conversation != null ? await chatForMessage(myMsg) : null;
    var myHandles = (await api.getHandles(state: pushService.state));
    if (myMsg.message is api.DartMessage_Message) {
      var innerMsg = myMsg.message as api.DartMessage_Message;
      var attributedBodyData = await indexedPartsToAttributedBodyDyn(innerMsg.field0.parts.field0, myMsg.id, null);
      var sender = myMsg.sender;
      
      if (innerMsg.field0.service is api.DartMessageType_SMS) {
        var smsServ = innerMsg.field0.service as api.DartMessageType_SMS;
        if (smsServ.fromHandle != null) {
          sender = smsServ.fromHandle;
        }
      }

      return Message(
        guid: myMsg.id,
        text: attributedBodyData.$2,
        isFromMe: myHandles.contains(sender),
        handle: RustPushBBUtils.rustHandleToBB(sender!),
        dateCreated: DateTime.fromMillisecondsSinceEpoch(myMsg.sentTimestamp),
        threadOriginatorPart: innerMsg.field0.replyPart?.toString(),
        threadOriginatorGuid: innerMsg.field0.replyGuid,
        expressiveSendStyleId: innerMsg.field0.effect,
        attributedBody: [attributedBodyData.$1],
        attachments: attributedBodyData.$3,
      );
    } else if (myMsg.message is api.DartMessage_RenameMessage) {
      var msg = myMsg.message as api.DartMessage_RenameMessage;
      
      return Message(
        guid: myMsg.id,
        isFromMe: myHandles.contains(myMsg.sender),
        handleId: RustPushBBUtils.rustHandleToBB(myMsg.sender!).originalROWID!,
        dateCreated: DateTime.fromMillisecondsSinceEpoch(myMsg.sentTimestamp),
        itemType: 2,
        groupActionType: 2,
        groupTitle: msg.field0.newName
      );
    } else if (myMsg.message is api.DartMessage_ChangeParticipants) {
      var msg = myMsg.message as api.DartMessage_ChangeParticipants;
      var didILeave = !msg.field0.newParticipants.contains(await chat!.ensureHandle());
      var didIJoin = !myMsg.conversation!.participants.contains(await chat.ensureHandle());
      var newParticipants = msg.field0.newParticipants.copy();
      if (!didILeave) {
        newParticipants.remove(await chat.ensureHandle());
      }
      var isAdd = newParticipants.length > chat.participants.length || didIJoin;
      var participantHandles = await RustPushBBUtils.rustParticipantsToBB(newParticipants);
      var changed = didILeave || didIJoin
          ? RustPushBBUtils.rustHandleToBB(await chat.ensureHandle())
          : isAdd
              ? participantHandles
                  .firstWhere((element) => chat!.participants.none((p0) => p0.address == element.address))
              : chat.participants
                  .firstWhere((element) => participantHandles.none((p0) => p0.address == element.address));
      chat.groupVersion = msg.field0.groupVersion;
      chat.handles.clear();
      chat.handles.addAll(participantHandles);
      chat.handles.applyToDb();
      chat.handlesChanged();
      chat = chat.getParticipants();
      chat.save(updateGroupVersion: true);
      var personDidLeave = RustPushBBUtils.bbHandleToRust(changed) == myMsg.sender && !isAdd;
      return Message(
        guid: myMsg.id,
        isFromMe: myHandles.contains(myMsg.sender),
        handleId: RustPushBBUtils.rustHandleToBB(myMsg.sender!).originalROWID!,
        dateCreated: DateTime.fromMillisecondsSinceEpoch(myMsg.sentTimestamp),
        itemType: personDidLeave ? 3 : 1,
        groupActionType: isAdd || personDidLeave ? 0 : 1,
        otherHandle: changed.originalROWID
      );
    } else if (myMsg.message is api.DartMessage_IconChange) {
      if (!chat!.lockChatIcon) {
        var innerMsg = myMsg.message as api.DartMessage_IconChange;
        var file = innerMsg.field0.file;
        chat.groupVersion = innerMsg.field0.groupVersion;
        if (file != null) {
          var path = chat.getIconPath(file.size);
          var stream = api.downloadMmcs(state: pushService.state, attachment: file, path: path);
          await for (final event in stream) {
            print("Downloaded attachment ${event.prog} bytes of ${event.total}");
          }
          chat.customAvatarPath = path;
        } else {
          chat.removeProfilePhoto();
        }
        chat.save(updateCustomAvatarPath: true, updateGroupVersion: true);
      }
      return Message(
        guid: myMsg.id,
        isFromMe: myHandles.contains(myMsg.sender),
        handleId: RustPushBBUtils.rustHandleToBB(myMsg.sender!).originalROWID!,
        dateCreated: DateTime.fromMillisecondsSinceEpoch(myMsg.sentTimestamp),
        itemType: 3,
        groupActionType: 1,
      );
    } else if (myMsg.message is api.DartMessage_React) {
      var msg = myMsg.message as api.DartMessage_React;
      var reaction = invReactionMap[msg.field0.reaction]!;
      if (!msg.field0.enable) {
        reaction = "-$reaction";
      }
      return Message(
        guid: myMsg.id,
        isFromMe: myHandles.contains(myMsg.sender),
        handleId: RustPushBBUtils.rustHandleToBB(myMsg.sender!).originalROWID!,
        dateCreated: DateTime.fromMillisecondsSinceEpoch(myMsg.sentTimestamp),
        itemType: 1,
        associatedMessagePart: msg.field0.toPart,
        associatedMessageGuid: msg.field0.toUuid,
        associatedMessageType: reaction,
      );
    } else if (myMsg.message is api.DartMessage_Unsend) {
      var msg = myMsg.message as api.DartMessage_Unsend;
      var msgObj = Message.findOne(guid: msg.field0.tuuid)!;
      msgObj.dateEdited = DateTime.now();
      var summaryInfo = msgObj.messageSummaryInfo.firstOrNull;
      if (summaryInfo == null) {
        summaryInfo = MessageSummaryInfo.empty();
        msgObj.messageSummaryInfo.add(summaryInfo);
      }
      summaryInfo.retractedParts.add(msg.field0.editPart);
      return msgObj;
    } else if (myMsg.message is api.DartMessage_Edit) {
      var msg = myMsg.message as api.DartMessage_Edit;
      var msgObj = Message.findOne(guid: msg.field0.tuuid);
      if (msgObj == null) {
        throw Exception("Cannot find msg!");
      }
      
      var attributedBodyDataInclusive = await indexedPartsToAttributedBodyDyn(
          msg.field0.newParts.field0, myMsg.id, msgObj.attributedBody.firstOrNull);
      var attributedBodyEdited = await indexedPartsToAttributedBodyDyn(msg.field0.newParts.field0, myMsg.id, null);
      msgObj.text = attributedBodyDataInclusive.$2;
      msgObj.dateEdited = DateTime.now();

      var summaryInfo = msgObj.messageSummaryInfo.firstOrNull;
      if (summaryInfo == null) {
        summaryInfo = MessageSummaryInfo.empty();
        msgObj.messageSummaryInfo.add(summaryInfo);
      }
      if (!summaryInfo.editedParts.contains(msg.field0.editPart)) {
        summaryInfo.editedParts.add(msg.field0.editPart);
      }

      // TODO need i set originalTextRange?
      var contentMap = summaryInfo.editedContent;
      if (contentMap[msg.field0.editPart.toString()] == null) {
        contentMap[msg.field0.editPart.toString()] = [
          EditedContent(
            date: (msgObj.dateCreated?.millisecondsSinceEpoch ?? 0).toDouble(),
            text: Content(values: msgObj.attributedBody)
          )
        ];
      }

      contentMap[msg.field0.editPart.toString()]!.add(
        EditedContent(
          date: myMsg.sentTimestamp.toDouble(),
          text: Content(values: [attributedBodyEdited.$1])
        )
      );

      msgObj.attributedBody = [attributedBodyDataInclusive.$1];
      return msgObj;
    }
    throw Exception("bad message type!");
  }

  String getService(api.DartIMessage msg) {
    if (msg.message is api.DartMessage_Message) {
      var m = msg.message as api.DartMessage_Message;
      if (m.field0.service is api.DartMessageType_SMS) {
        return "SMS";
      }
    }
    return "iMessage";
  }

  // finds chat for message. Use over `Chat.findByRust` for incoming messages
  // to handle after conversation changes (renames, participants)
  Future<Chat> chatForMessage(api.DartIMessage myMsg) async {
    // find existing saved message and use that chat if we're getting a replay
    var existing = Message.findOne(guid: myMsg.id);
    if (existing?.getChat() != null) {
      return existing!.getChat()!;
    }
    if (myMsg.message is api.DartMessage_RenameMessage) {
      var found = (await Chat.findByRust(myMsg.conversation!, getService(myMsg), soft: true));
      if (found == null) {
        // try using the new name
        var msg = myMsg.message as api.DartMessage_RenameMessage;
        myMsg.conversation!.cvName = msg.field0.newName;
        return (await Chat.findByRust(myMsg.conversation!, getService(myMsg)))!;
      } else {
        return found;
      }
    }
    if (myMsg.message is api.DartMessage_ChangeParticipants) {
      var found = (await Chat.findByRust(myMsg.conversation!, getService(myMsg), soft: true));
      if (found == null) {
        // try using the new participants
        var msg = myMsg.message as api.DartMessage_ChangeParticipants;
        myMsg.conversation!.participants = msg.field0.newParticipants;
        return (await Chat.findByRust(myMsg.conversation!, getService(myMsg)))!;
      } else {
        return found;
      }
    }
    if (myMsg.message is api.DartMessage_Message) {
      var message = myMsg.message as api.DartMessage_Message;
      var service = message.field0.service;
      if (service is api.DartMessageType_SMS) {
        // remove any potential us from the conversation it won't recognize the telephone as a "handle"
        myMsg.conversation?.participants.remove(service.usingNumber);
      }
    }
    return (await Chat.findByRust(myMsg.conversation!, getService(myMsg)))!;
  }

  Future handleMsg(api.DartIMessage myMsg) async {
    if (myMsg.message is api.DartMessage_EnableSmsActivation) {
      var message = myMsg.message as api.DartMessage_EnableSmsActivation;
      ss.settings.smsForwardingEnabled.value = message.field0;
      return;
    }
    if (myMsg.message is api.DartMessage_SmsConfirmSent) {
      return; // not much to do for now  
    }
    if (myMsg.message is api.DartMessage_Delivered || myMsg.message is api.DartMessage_Read) {
      var myHandles = (await api.getHandles(state: pushService.state));
      if (myHandles.contains(myMsg.sender)) {
        return; // delivered to other devices is not
      }
      var message = Message.findOne(guid: myMsg.id);
      if (message == null) {
        return;
      }
      var map = message.toMap();
      map["chats"] = [message.chat.target!.toMap()];
      if (myMsg.message is api.DartMessage_Delivered) {
        map["dateDelivered"] = myMsg.sentTimestamp;
      } else {
        map["dateRead"] = myMsg.sentTimestamp;
      }
      inq.queue(IncomingItem.fromMap(QueueType.updatedMessage, map));
      return;
    }
    var chat = await chatForMessage(myMsg);
    if (myMsg.message is api.DartMessage_RenameMessage) {
      var msg = myMsg.message as api.DartMessage_RenameMessage;
      if (!chat.lockChatName) {
        chat.displayName = msg.field0.newName;
      }
      chat.apnTitle = msg.field0.newName;
      myMsg.conversation?.cvName = msg.field0.newName;
      chat = chat.save(updateDisplayName: true, updateAPNTitle: true);
    }
    if (myMsg.message is api.DartMessage_Typing) {
      final controller = cvc(chat);
      controller.showTypingIndicator.value = true;
      var future = Future.delayed(const Duration(minutes: 1));
      var subscription = future.asStream().listen((any) {
        controller.showTypingIndicator.value = false;
        controller.cancelTypingIndicator = null;
      });
      controller.cancelTypingIndicator = subscription;
      return;
    }
    if (myMsg.message is api.DartMessage_StopTyping) {
      final controller = cvc(chat);
      controller.showTypingIndicator.value = false;
      if (controller.cancelTypingIndicator != null) {
        controller.cancelTypingIndicator!.cancel();
        controller.cancelTypingIndicator = null;
      }
      return;
    }
    if (myMsg.message is api.DartMessage_Message) {
      final controller = cvc(chat);
      controller.showTypingIndicator.value = false;
      controller.cancelTypingIndicator?.cancel();
      controller.cancelTypingIndicator = null;
      var msg = myMsg.message as api.DartMessage_Message;
      if ((await msg.field0.parts.asPlain()) == "" &&
          msg.field0.parts.field0.none((p0) => p0.field0 is api.DartMessagePart_Attachment)) {
        return;
      }
    }
    var service = backend as RustPushBackend;
    service.markDelivered(myMsg);
    inq.queue(IncomingItem(
      chat: chat,
      message: await pushService.reflectMessageDyn(myMsg),
      type: QueueType.newMessage
    ));
  }

  Future recievedMsgPointer(String pointer) async {
    var message = await api.ptrToDart(ptr: pointer);
    await initFuture;
    try {
      await handleMsg(message);
    } catch (e, s) {
      print("$e\n$s");
      rethrow;
    }
  }

  void doPoll() async {
    while (true) {
      try {
        var msgRaw = await api.recvWait(state: pushService.state);
        if (msgRaw is api.PollResult_Stop) {
          break;
        }
        var msg = (msgRaw as api.PollResult_Cont).field0;
        if (msg == null) {
          continue;
        }
        await handleMsg(msg);
      } catch (e, t) {
        // if there was an error somewhere, log it and move on.
        // don't stop our loop
        Logger.error("$e: $t");
      }
    }
  }

  void hello() {
    // used to get GetX to get up off it's ass
  }

  late Future initFuture;

  @override
  Future<void> onInit() async {
    super.onInit();
    initFuture = (() async {
      if (Platform.isAndroid) {
        print("tryingService");
        String result = await mcs.invokeMethod("get-native-handle");
        state = await api.serviceFromPtr(ptr: result);
        print("service");
        await stdout.flush();
      } else {
        state = await api.newPushState(dir: fs.appDocDir.path);
        if ((await api.getPhase(state: state)) == api.RegistrationPhase.registered) {
          doPoll();
        }
      }
      await cs.refreshContacts();
    })();
    await initFuture;
  }

  Future reset() async {
    await api.resetState(state: state);
  }

  Future configured() async {
    if (Platform.isAndroid) {
      await mcs.invokeMethod("notify-native-configured");
    } else {
      doPoll();
    }
  }

  @override
  void onClose() {
    state.dispose();
    super.onClose();
  }
}
