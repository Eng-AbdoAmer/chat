import 'package:chat/config/custom_elevatedbutton.dart';
import 'package:flutter/Material.dart';

class NotificationButton extends StatelessWidget {
  final VoidCallback onPress;
  final String text;
  const NotificationButton(
      {super.key, required this.onPress, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, bottom: 10, right: 30, top: 20),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: CustomElevatedButton(
          name: text,
          onPressed: onPress,
        ),
      ),
    );
  }
}
