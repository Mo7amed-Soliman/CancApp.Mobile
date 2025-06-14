import 'package:canc_app/core/helpers/responsive_helpers/size_helper_extension.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/models/chat_message_model.dart';
import '../../data/models/user_chat_model.dart';
import 'widgets/chat_body.dart';
import '../../../../widgets/image_source_picker.dart';
import 'widgets/custom_app_bar_chat.dart';
import 'widgets/message_input.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key, required this.user});

  final UserChatModel user;

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ImagePicker _imagePicker = ImagePicker();
  final FocusNode _focusNode = FocusNode();

  final List<ChatMessageModel> _messages = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (_focusNode.hasFocus) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          _scrollToBottom();
        }
      });
    }
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add(
        ChatMessageModel(
          text: _messageController.text,
          isMe: true,
          timestamp: '${DateTime.now().hour}:${DateTime.now().minute} AM',
          type: TypeMessage.text,
          idTo: widget.user.id,
          idFrom: widget.user.idFrom,
        ),
      );
    });
    _messageController.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    if (!_scrollController.hasClients) return;

    final position = _scrollController.position.maxScrollExtent;
    _scrollController.animateTo(
      position,
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
    );
  }

  void _handleImagePicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(context.setMinSize(20)),
        ),
      ),
      builder: (context) => ImageSourcePicker(
        onImageSourceSelected: _pickImage,
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: source,
        imageQuality: 70,
      );

      if (image != null) {
        setState(() {
          _messages.add(
            ChatMessageModel(
              text: image.path,
              isMe: true,
              timestamp: '${DateTime.now().hour}:${DateTime.now().minute} AM',
              type: TypeMessage.image,
              idTo: widget.user.id,
              idFrom: widget.user.idFrom,
            ),
          );
        });

        Future.delayed(const Duration(seconds: 1), () {
          _scrollToBottom();
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarChat(
        title: widget.user.name,
        subtitle: 'Hey, how are you holding up today?',
        imagePath: widget.user.imagePath,
      ),
      body: Column(
        children: [
          ChatBody(
            messages: _messages,
            scrollController: _scrollController,
          ),
          MessageInput(
            controller: _messageController,
            onSendPressed: _sendMessage,
            onImagePressed: _handleImagePicker,
            focusNode: _focusNode,
          ),
        ],
      ),
    );
  }
}
