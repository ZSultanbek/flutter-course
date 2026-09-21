import 'models.dart';

// put every subtype in this file, or compiler won't know shi about 
// the complete list, duh. and check the switch for every case.
sealed class ShelfState {
  const ShelfState();
}

class Empty extends ShelfState {
  const Empty();
}

class Ready extends ShelfState {
  final List<Book> books;
  const Ready(this.books);
}

class Broken extends ShelfState {
  final String message;
  const Broken(this.message);
}

//Switch expression, no default tho, why? exhaustive, thanks to 'sealed', DUH
// Object patterns pull the fields out.
String describe(ShelfState state) => switch (state) {
  Empty() => 'Shelf is empty',
  Ready(:final books) => 'Shelf is ready with ${books.length} books',
  Broken(:final message) => 'Shelf is broken: $message',
};
({int count, double avgPages}) statsOf(List<Book> books) => (
  count: books.length,
  avgPages: books.isEmpty
    ? 0.0
    : books.fold<int>(0, (sum, b) => sum + b.pages) / books.length,
);