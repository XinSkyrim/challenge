class ChatMessage {
  String id;
  String name;
  String avatar;
  String lastMessage;
  String time;
  int unreadCount;
  bool isRead;

  ChatMessage({
    required this.id,
    required this.name,
    required this.avatar,
    required this.lastMessage,
    required this.time,
    this.unreadCount = 0,
    this.isRead = true,
  });

  factory ChatMessage.formJSON(Map<String, dynamic> json) {
    return ChatMessage(
      id: json["id"]?.toString() ?? "",
      name: json["name"]?.toString() ?? "",
      avatar: json["avatar"]?.toString() ?? "",
      lastMessage: json["lastMessage"]?.toString() ?? "",
      time: json["time"]?.toString() ?? "",
      unreadCount: int.tryParse(json["unreadCount"]?.toString() ?? "0") ?? 0,
      isRead: json["isRead"] ?? true,
    );
  }
}

class ChatMessageList {
  List<ChatMessage> items;

  ChatMessageList({required this.items});

  factory ChatMessageList.formJSON(dynamic json) {
    List<ChatMessage> items = [];

    if (json is List) {
      items = json
          .map((item) => ChatMessage.formJSON(item as Map<String, dynamic>))
          .toList();
    } else if (json is Map) {
      if (json["items"] != null) {
        items = (json["items"] as List)
            .map((item) => ChatMessage.formJSON(item as Map<String, dynamic>))
            .toList();
      } else if (json["data"] != null) {
        items = (json["data"] as List)
            .map((item) => ChatMessage.formJSON(item as Map<String, dynamic>))
            .toList();
      }
    }

    return ChatMessageList(items: items);
  }
}
