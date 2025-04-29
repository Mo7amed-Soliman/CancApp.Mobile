import 'package:flutter/material.dart';

/// Model for chat items in the available to chat section
class ChatItemModel {
  /// The image path for the chat category
  final String image;

  /// The title of the chat category
  final String title;

  /// The color theme for the chat category
  final Color color;

  /// Creates a chat item model
  const ChatItemModel({
    required this.image,
    required this.title,
    required this.color,
  });
}
