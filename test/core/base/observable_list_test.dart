import 'package:flutter_test/flutter_test.dart';
import 'package:photos/app/core/base/observable_list.dart';

void main() {
  group('ObservableList Tests', () {
    test('Listeners are notified when an item is added', () {
      final ObservableList<int> list =
          ObservableList<int>.empty(growable: true);
      bool notified = false;

      list.addListener(() {
        notified = true;
      });

      list.add(1);
      expect(list.value.contains(1), isTrue);
      expect(notified, isTrue);
    });

    test('Listeners are notified when an item is removed', () {
      final ObservableList<int> list = ObservableList<int>.from(<int>[1, 2, 3]);
      bool notified = false;

      list.addListener(() {
        notified = true;
      });

      list.remove(2);
      expect(list.value.contains(2), isFalse);
      expect(notified, isTrue);
    });

    test('Listeners are notified when the list is cleared', () {
      final ObservableList<int> list = ObservableList<int>.from(<int>[1, 2, 3]);
      bool notified = false;

      list.addListener(() {
        notified = true;
      });

      list.clear();
      expect(list.value.isEmpty, isTrue);
      expect(notified, isTrue);
    });

    test('Batch update notifies listeners once', () {
      final ObservableList<int> list = ObservableList<int>.from(<int>[1, 2, 3]);
      int notificationCount = 0;

      list.addListener(() {
        notificationCount += 1;
      });

      list.batchUpdate((List<int> lst) {
        lst.add(4);
        lst.add(5);
      });

      expect(notificationCount, 1);
      expect(list.value, containsAll(<int>[1, 2, 3, 4, 5]));
    });
  });
}
