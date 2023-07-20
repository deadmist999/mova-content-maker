import 'dart:io';

abstract class Post {
  const Post();
}

class TextPost extends Post {
  final String message;

  const TextPost({required this.message});
}

class ImagePost extends Post {
  final File image;

  const ImagePost({required this.image});
}

class TextAndImagePost extends Post {
  final String message;
  final File image;

  const TextAndImagePost({required this.message, required this.image});
}
