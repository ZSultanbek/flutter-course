import 'models.dart';

class Library{
  final List<LibraryItem> items = [];
  late final DateTime openedAt;
  String? _cachedReport;

  void add(LibraryItem item){
    items.add(item);
  }

  void open() {
    openedAt = DateTime.now();
  }

  List<Book> get books => items.whereType<Book>().toList();

  Book? findByTitle(String title) {
    return books.where((b) => b.title == title).firstOrNull;
  }

  // question? duh, ? is for stopping at null, and then a fallback with ??. duh.
  String countryOf(String title) =>
    findByTitle(title)?.author.country ?? 'unknown';
  
  String report() => _cachedReport ??= [
    'Opened at: $openedAt',
    ...display,
  ].join('\n');


  List<String> get titles => items.map((i) => i.title).toList();

  List<Book> get booksAfter2010 => books.where((b) => b.year > 2010).toList();
  
  //NO reduce, fold goddamn, reduce must return the SAME type as the elements
  // duh, (Book), but we want an int sum; reduce also throws on an empty list,
  // while fold starts from an initial value (0) and works on empty lists. duh.
  double get averagePages => books.isEmpty
    ? 0.0
    : books.fold<int>(0, (sum, b) => sum + b.pages) / books.length;

  Map<String, int> get booksPerAuthor => books.fold<Map<String, int>>(
    {},
    (counts, b) =>
      counts..update(b.author.name, (n) => n+1, ifAbsent: () => 1),
  );

  Set<String> get authorNames => books.map((b) => b.author.name).toSet();
  Set<Genre> get genres => books.map((b) => b.genre).toSet();

  List<String> get display => [
    'CATALOGUE',
    for (final b in books) '${b.title} (${b.year})',
    ...authorNames,
    if (books.any((b) => b.pages == 0)) '(incomplete data)',
  ];
}