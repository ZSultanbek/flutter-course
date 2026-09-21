class Author {
  final String name;
  final String? country;
  const Author({required this.name, this.country});
  @override
  String toString() => '$name (${country ?? 'unknown'})';
}

enum Genre {
  craft('Software craft'), thoery('Theory'), unknown('Unknown');
  final String label;
  const Genre(this.label);
  static Genre fromString(String? raw) => Genre.values.firstWhere(
    (g) => g.name == raw, orElse: () => Genre.unknown
  );
}

abstract class LibraryItem {
  final String title;
  final int year;
 
  const LibraryItem({required this.title, required this.year});
 
  /// Abstract: no body, every subclass must implement it.
  String describe();
 
  /// Concrete: has a body, subclasses inherit it for free.
  bool get isOld => year < 2000;
}

mixin Borrowable on LibraryItem {
  String borrowLabel() => 'Borrow: "$title"';
}

class Book extends LibraryItem with Borrowable {
  final int pages;
  final Genre genre;
  final Author author;
  final String? description;

  const Book({
    required super.title,
    required super.year,
    required this.pages,
    required this.author,
    required this.genre,
    this.description
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] as String? ?? 'Untitled',
      year: json['year'] as int? ?? 0,
      pages: json['pages'] as int? ?? 0,
      author: Author(
        name: json['author'] as String? ?? 'Unknown',
        country: json['country'] as String?,
      ),
      genre: Genre.fromString(json['genre' as String?]),
      description: json['description'] as String?,
    );
  }

  bool get isLong => pages > 400;

  Book copyWith({
    String? title,
    int? year,
    int? pages,
    Author? author,
    Genre? genre,
    String? description,
  }) {
    return Book(
      title: title ?? this.title, 
      year: year ?? this.year, 
      pages: pages ?? this.pages, 
      author: author ?? this.author, 
      genre: genre ?? this.genre, 
      description: description
    );
  }

  @override
  String describe() => 'Book "$title" by ${author.name}, $year, $pages pages';
 
  @override
  String toString() {
    // A public field is not promoted by a null check -> copy into a local.
    final desc = description;
    final base = 'Book($title, $year, $pages p., $author, ${genre.label})';
    return desc == null ? base : '$base - $desc';
  }
}

class Magazine extends LibraryItem {
  final int issue;
 
  const Magazine({required super.title, required super.year, required this.issue});
 
  @override
  String describe() => 'Magazine "$title", issue #$issue ($year)';
}
 
/// `implements` = contract only. Nothing is inherited, so every member
/// (including the fields and isOld) is written by hand with @override.
class Ghost implements LibraryItem {
  @override
  final String title;
  @override
  final int year;
 
  const Ghost({required this.title, required this.year});
 
  @override
  String describe() => 'Ghost "$title" - looks like an item, inherits nothing';
 
  @override
  bool get isOld => year < 2000;
}