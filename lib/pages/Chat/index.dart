import 'package:flutter/material.dart';
import 'package:flutter_challenge/constants/theme.dart';
import 'package:flutter_challenge/viewmodels/chat.dart';

class ChatView extends StatefulWidget {
  ChatView({Key? key}) : super(key: key);

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  TextEditingController _searchController = TextEditingController();
  List<ChatMessage> _chatList = [];

  @override
  void initState() {
    super.initState();
    _initMockData();
  }

  void _initMockData() {
    // user data
    _chatList = [
      ChatMessage(
        id: "1",
        name: "Kari Rasmussen",
        avatar: "https://i.pravatar.cc/150?img=1",
        lastMessage: "Thanks for contacting me!",
        time: "15:23",
        unreadCount: 2,
        isRead: false,
      ),
      ChatMessage(
        id: "2",
        name: "Anita Cruz",
        avatar: "https://i.pravatar.cc/150?img=2",
        lastMessage: "Your payment was accepted.",
        time: "Yesterday",
        unreadCount: 0,
        isRead: true,
      ),
      ChatMessage(
        id: "3",
        name: "Noah Pierre",
        avatar: "https://i.pravatar.cc/150?img=3",
        lastMessage: "It was great experience!",
        time: "11/10/2021",
        unreadCount: 0,
        isRead: true,
      ),
      ChatMessage(
        id: "4",
        name: "Lucy Bond",
        avatar: "https://i.pravatar.cc/150?img=4",
        lastMessage: "How much does it cost?",
        time: "11/10/2021",
        unreadCount: 0,
        isRead: false,
      ),
      ChatMessage(
        id: "5",
        name: "Louise Vuitton",
        avatar: "https://i.pravatar.cc/150?img=5",
        lastMessage: "Sure, man!",
        time: "11/10/2021",
        unreadCount: 0,
        isRead: true,
      ),
    ];
    setState(() {});
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.backgroundColor,
      child: Column(
        children: [
          // 顶部标题和搜索框
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Messages",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
                SizedBox(height: 16),
                // 搜索框
                Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppTheme.lightGrayBackground,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.transparent),
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Search messages",
                      hintStyle: TextStyle(color: AppTheme.textTertiary),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 12,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppTheme.textTertiary,
                        size: 22,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
          // 聊天列表
          Expanded(
            child: ListView.builder(
              itemCount: _chatList.length,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              itemBuilder: (context, index) {
                final chat = _chatList[index];
                return _buildChatItem(chat);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatItem(ChatMessage chat) {
    return Container(
      margin: EdgeInsets.only(bottom: 14),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // 头像
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.lightGrayBackground,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                chat.avatar,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Icon(Icons.person, color: Colors.grey, size: 28),
                  );
                },
              ),
            ),
          ),
          SizedBox(width: 14),
          // 信息内容
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chat.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  chat.lastMessage,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppTheme.textTertiary,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 12),
          // 时间和未读消息数
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                chat.time,
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.textTertiary,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 6),
              if (chat.unreadCount > 0)
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.primaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryColor.withOpacity(0.3),
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      chat.unreadCount.toString(),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              else if (!chat.isRead)
                Icon(Icons.check, size: 16, color: AppTheme.primaryColor)
              else
                Icon(Icons.done_all, size: 16, color: AppTheme.textTertiary),
            ],
          ),
        ],
      ),
    );
  }
}
