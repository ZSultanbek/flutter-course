import 'catalogue.dart';
import 'data.dart';
import 'models.dart';
import 'shelf_state.dart';

void main() {
  final catalogue = Library()..open();

  // Build the library from the raw maps through Book.fromJson.
  rawBooks.map(Book.fromJson).forEach(catalogue.add);

  // Level 2: other kinds of items live in the same list.
  catalogue.add(const Magazine(title: 'Dart Monthly', year: 2024, issue: 7));
  catalogue.add(const Ghost(title: 'Invisible Book', year: 1990));

  print('=== Level 1 & 2: items ===');
  for (final item in catalogue.items) {
    print('${item.describe()}  | old: ${item.isOld}');
  }
  final clean = catalogue.findByTitle('Clean Code');
  print(clean?.borrowLabel());
  print(clean?.copyWith(pages: 500));
  print('Clean Code is long: ${clean?.isLong}');

  print('\n=== Level 3: null safety ===');
  print('Find "Nope": ${catalogue.findByTitle('Nope')}');
  print('Country of Clean Code: ${catalogue.countryOf('Clean Code')}');
  print('Country of Design Patterns: ${catalogue.countryOf('Design Patterns')}');
  print('Country of Nope: ${catalogue.countryOf('Nope')}');
  print('Broken Record: ${catalogue.findByTitle('Broken Record')}');

  print('\n=== Level 4: collections ===');
  print('Titles: ${catalogue.titles}');
  print('After 2010: ${catalogue.booksAfter2010.map((b) => b.title).toList()}');
  print('Average pages: ${catalogue.averagePages.toStringAsFixed(1)}');
  print('Books per author: ${catalogue.booksPerAuthor}');
  print('Authors: ${catalogue.authorNames}');
  print('Genres: ${catalogue.genres.map((g) => g.label).toSet()}');
  print('');
  print(catalogue.report());
  print('(second call uses the cache: ${identical(catalogue.report(), catalogue.report())})');

  print('\n=== Level 5: Dart 3 ===');
  final (:count, :avgPages) = statsOf(catalogue.books);
  print('Stats record: count=$count, avgPages=${avgPages.toStringAsFixed(1)}');

  final states = <ShelfState>[
    const Empty(),
    Ready(catalogue.books),
    const Broken('shelf collapsed'),
  ];
  for (final s in states) {
    print(describe(s));
  }
}