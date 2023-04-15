import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_draft_helper/model/part/category.dart';
import 'package:instagram_draft_helper/model/part/keyword.dart';
import 'package:instagram_draft_helper/model/part/product.dart';
import 'package:instagram_draft_helper/state/main_state.dart';
import 'input_modal_bottom_sheet.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends ConsumerState<MainPage> {
  @override
  Widget build(BuildContext context) {
    MainStateNotifier notifier = ref.read(mainStateProvider.notifier);
    MainState state = ref.watch(mainStateProvider);
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
                child: _result(text: state.result),
              ),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      _title('コメント', state.comment.getCount()),
                      _content(
                        child: _input(
                          text: state.comment.getText(),
                          onTap: () {
                            showInputModalBottomSheet(
                                    context: context,
                                    title: 'コメント',
                                    before: state.comment.getText())
                                .then((after) => notifier.updateComment(after));
                          },
                        ),
                      ),
                      _divider(),
                      _title('トピック', state.keywords.getCount()),
                      _content(
                        child: _wrap(
                          children: [
                            for (Keyword topic in state.keywords.getAll()) ...{
                              _chip(
                                primary: topic.name,
                                onDeleted: () => notifier.deleteTopic(topic),
                              ),
                            },
                            _addChip(
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      _divider(),
                      _title('機材', state.products.getAll().length),
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
                            for (Category category
                                in state.products.getCategories()) ...{
                              TableRow(
                                children: [
                                  Text(category.name),
                                  const SizedBox(width: 5),
                                  _wrap(
                                    children: [
                                      for (Product product in state.products
                                          .getProducts(category)) ...{
                                        _chip(
                                          primary: product.name,
                                          secondary: (product.maker != null &&
                                                  product.brand != null)
                                              ? '${product.maker?.name} / ${product.brand?.name}'
                                              : '${product.maker?.name}${product.brand?.name}',
                                          onDeleted: () =>
                                              notifier.deleteProduct(product),
                                        ),
                                      },
                                      _addChip(
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            },
                          ],
                        ),
                      ),
                      _divider(),
                      _title('投稿識別子'),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Flexible(
                            child: _content(
                              child: _input(
                                text: state.record.getText(),
                                onTap: () {},
                              ),
                            ),
                          ),
                          Visibility(
                            visible: false,
                            maintainSize: true,
                            maintainState: true,
                            maintainAnimation: true,
                            child: _fabCopy(),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton:
          _fabCopy(onPressed: () => onCopyPressed(context, state.result)),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _result({required String text}) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          const SizedBox(width: 10),
          Expanded(
            flex: 9,
            child: Visibility(
              visible: text.isNotEmpty,
              replacement: const Text(
                'キャプションを入力...',
                maxLines: null,
                softWrap: true,
                style: TextStyle(fontSize: 12),
              ),
              child: Text(
                text,
                maxLines: null,
                softWrap: true,
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ),
          const SizedBox(width: 10),
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
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
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
      backgroundColor: Colors.white,
    );
  }

  Widget _addChip({
    Function()? onPressed,
  }) {
    return ActionChip(
      label: const Icon(Icons.add),
      onPressed: onPressed,
      backgroundColor: Colors.white,
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

  Widget _fabCopy({Function()? onPressed}) {
    return FloatingActionButton.extended(
      backgroundColor: Colors.indigo,
      foregroundColor: Colors.white,
      onPressed: onPressed,
      icon: const Icon(Icons.copy, color: Colors.white),
      label: const Text('コピー'),
    );
  }

  Future<void> onCopyPressed(BuildContext context, String text) async {
    await copy(text).then((value) => showSnackBar(context, 'コピーしました'));
  }

  Future<void> copy(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }

  void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
