import 'package:flutter/material.dart';

Future<String> showInputModalBottomSheet(
    {required BuildContext context, String? title, String before = ''}) async {
  final TextEditingController controller = TextEditingController(text: before);
  return await showModalBottomSheet(
    context: context,
    enableDrag: false,
    useSafeArea: true,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10) +
              EdgeInsets.only(
                top: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (title != null) ...{
                Text(title),
              },
              TextField(
                controller: controller,
                minLines: 1,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                autofocus: true,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: TextButton(
                      onPressed: () {
                        _unFocus(context);
                        Navigator.of(context).pop(before);
                      },
                      child: const Text('キャンセル'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: TextButton(
                      onPressed: () {
                        _unFocus(context);
                        Navigator.of(context).pop(controller.text);
                      },
                      child: const Text('確定'),
                    ),
                  ),
                ],
              )
            ],
          ));
    },
  );
}

void _unFocus(BuildContext context) {
  final FocusScopeNode currentScope = FocusScope.of(context);
  if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
    FocusManager.instance.primaryFocus!.unfocus();
  }
}
