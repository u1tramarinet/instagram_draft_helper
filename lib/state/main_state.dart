import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../model/part/keyword.dart';
import '../model/part/product.dart';
import '../model/part/tag.dart';
import '../model/group/comment.dart';
import '../model/group/keywords.dart';
import '../model/group/products.dart';
import '../model/group/record.dart';

part 'main_state.freezed.dart';

class MainStateNotifier extends StateNotifier<MainState> {
  MainStateNotifier(super.state);

  void updateComment(String newComment) {
    state = state.copyWith(
      comment: state.comment.updateContent(newComment),
    );
    updateResult();
  }

  void deleteTopic(Keyword topic) {
    Keywords keywords = state.keywords;
    keywords.remove(topic, (Keyword a, Keyword b) => a.name == b.name);
    state = state.copyWith(keywords: keywords);
    updateResult();
  }

  void deleteProduct(Product product) {
    Products products = state.products;
    products.remove(product, (Product a, Product b) => a.name == b.name);
    state = state.copyWith(products: products);
    updateResult();
  }

  void updateResult() {
    List<String> elements = [
      state.comment.getText(),
      state.keywords.getText(),
      state.products.getText(),
      state.record.getText(),
    ].where((element) => element.isNotEmpty).toList();
    state = state.copyWith(result: elements.join('\n\n'));
  }

  void setDummyData() {
    Keywords newKeywords = state.keywords;
    newKeywords.addAll([
      const Keyword(
        name: '夜景',
        tags: [Tag(name: '夜景'), Tag(name: 'nightsight')],
      ),
      const Keyword(
        name: '夜',
        tags: [Tag(name: '夜'), Tag(name: 'night')],
      ),
      const Keyword(
        name: '風景撮影',
        tags: [Tag(name: '風景撮影'), Tag(name: 'landscapephotography')],
      ),
      const Keyword(
        name: 'スタバ',
        tags: [Tag(name: 'スタバ'), Tag(name: 'スターバックス'), Tag(name: 'starbucks')],
      ),
      const Keyword(
        name: 'ラーメン',
        tags: [Tag(name: 'ラーメン'), Tag(name: 'ramen')],
      ),
    ]);
    Products products = state.products;
    const Keyword google = Keyword(name: 'Google', tags: [Tag(name: 'google')]);
    const Keyword googlePixel = Keyword(
      name: 'Google Pixel',
      tags: [
        Tag(name: 'googlepixel'),
        Tag(name: 'teampixel'),
        Tag(name: 'madebygoogle'),
        Tag(name: 'pixelで撮影'),
      ],
    );
    products.addAll([
      const Product(
        name: 'Google Pixel 7 Pro',
        tags: [Tag(name: 'googlepixel7pro')],
        category: cameras,
        maker: google,
        brand: googlePixel,
      ),
      const Product(
        name: 'Googleフォト',
        tags: [Tag(name: 'googlephotos')],
        category: editors,
        maker: google,
      ),
    ]);
    state = state.copyWith(
      keywords: newKeywords,
      products: products,
    );
  }
}

final mainStateProvider =
    StateNotifierProvider<MainStateNotifier, MainState>((ref) {
  MainStateNotifier notifier = MainStateNotifier(
    MainState(
      comment: Comment(),
      keywords: Keywords(),
      products: Products(),
      record: Record(date: DateTime.now()),
    ),
  );
  notifier.setDummyData();
  notifier.updateResult();
  return notifier;
});

@freezed
class MainState with _$MainState {
  const factory MainState({
    @Default('') String result,
    required Comment comment,
    required Keywords keywords,
    required Products products,
    required Record record,
  }) = _MainState;
}
