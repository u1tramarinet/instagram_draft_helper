import 'package:flutter/material.dart';
import 'package:instagram_draft_helper/model/group/comment.dart';
import 'input_modal_bottom_sheet.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String inputText = '';
  String text = '';
  Comment comment = Comment();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.cyan.shade50,
      appBar: AppBar(
        title: const Text('Draftagram'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                child: _result(text: text),
              ),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      _title('コメント', inputText.length),
                      _content(
                        child: _input(
                          text: inputText,
                          onTap: () {
                            showInputModalBottomSheet(
                                    context: context,
                                    title: 'コメント',
                                    before: inputText)
                                .then((after) => _updateComment(after));
                          },
                        ),
                      ),
                      _divider(),
                      _title('ハッシュタグ', 3),
                      _content(
                        child: _wrap(
                          children: [
                            _chip(
                              primary: '夜景',
                              onDeleted: () {},
                            ),
                            _chip(
                              primary: '夜',
                              onDeleted: () {},
                            ),
                            _chip(
                              primary: '風景撮影',
                              onDeleted: () {},
                            ),
                            _chip(
                              primary: 'スタバ',
                              onDeleted: () {},
                            ),
                            _chip(
                              primary: 'ラーメン',
                              onDeleted: () {},
                            ),
                            _addChip(
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      _divider(),
                      _title('機材', 2),
                      _content(
                        child: Table(
                          columnWidths: const <int, TableColumnWidth>{
                            0: IntrinsicColumnWidth(),
                            1: IntrinsicColumnWidth(),
                            2: FlexColumnWidth(),
                          },
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          children: <TableRow>[
                            TableRow(
                              children: [
                                const Text('カメラ'),
                                const SizedBox(width: 5),
                                _wrap(
                                  children: [
                                    _chip(
                                      primary: 'Google Pixel 7 Pro',
                                      secondary: 'Google Pixel / Google',
                                      onDeleted: () {},
                                    ),
                                    _addChip(
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                const Text('レンズ'),
                                const SizedBox(width: 5),
                                _wrap(
                                  children: [
                                    _addChip(
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                const Text('エディタ'),
                                const SizedBox(width: 5),
                                _wrap(
                                  children: [
                                    _chip(
                                      primary: 'Googleフォト',
                                      secondary: 'Google',
                                      onDeleted: () {},
                                    ),
                                    _addChip(
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      _divider(),
                      _title('投稿識別子'),
                      _content(
                          child: _input(
                        text: '2023-XXX(weekX-X)',
                        onTap: () {},
                      ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        child: const Icon(Icons.copy, color: Colors.white),
        onPressed: () {},
      ),
    );
  }

  Widget _result({required String text}) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFF455A64))),
                clipBehavior: Clip.antiAlias,
                child: const Placeholder(),
              ),
            ),
          ),
          const SizedBox(width: 5),
          Flexible(
            flex: 8,
            child: Text(
              text,
              maxLines: null,
              softWrap: true,
              style: const TextStyle(fontSize: 12),
            ),
          ),
          const SizedBox(width: 5),
          const Flexible(
            flex: 1,
            child: AspectRatio(
              aspectRatio: 1,
              child: Placeholder(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _title(String title, [int badgeCount = 0]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
          if (badgeCount > 0) ...{
            const SizedBox(width: 5),
            Badge.count(count: badgeCount),
          },
        ],
      ),
    );
  }

  Widget _content({Widget? child}) {
    if (child == null) {
      return const Offstage();
    }
    return Padding(
      padding: const EdgeInsets.all(5),
      child: child,
    );
  }

  Widget _wrap({required List<Widget> children}) {
    return Wrap(
      spacing: 10,
      children: children,
    );
  }

  Widget _divider() {
    return const Divider(
      height: 5,
      color: Colors.white,
      thickness: 1,
    );
  }

  Widget _chip({
    required String primary,
    String? secondary,
    Function()? onDeleted,
  }) {
    return Chip(
      label: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            primary,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
          if (secondary != null) ...{
            Text(
              secondary,
              style: const TextStyle(
                fontSize: 8,
                color: Colors.blueAccent,
              ),
            ),
          }
        ],
      ),
      onDeleted: onDeleted,
    );
  }

  Widget _addChip({
    Function()? onPressed,
  }) {
    return ActionChip(
      label: const Icon(Icons.add),
      onPressed: onPressed,
    );
  }

  Widget _input({required String text, required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: Colors.black54),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              flex: 1,
              child: Text(
                text,
                maxLines: 1,
                style: const TextStyle(color: Colors.cyan, fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 10),
            const Icon(Icons.edit, color: Colors.cyan),
          ],
        ),
      ),
    );
  }

  void _updateComment(String text) {
    setState(() {
      comment.updateContent(text);
      inputText = text;
      this.text = inputText;
      this.text += '\n';
      this.text += '\n';
      this.text += '#夜景 #nightsight \n';
      this.text += '#夜 #night \n';
      this.text += '#風景撮影 #landscapephotography \n';
      this.text += '#スタバ #スターバックス #starbucks \n';
      this.text += '#ラーメン #ramen \n';
      this.text += '#googlepixel7pro \n';
      this.text += '#googlepixel #teampixel #madebygoogle #pixelで撮影 \n';
    });
  }
}
