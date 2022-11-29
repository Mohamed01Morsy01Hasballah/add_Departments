class Book {
  String? image;
  String? title;
  Book(this.image, this.title);
  static List<Book> getCommonBooks() {
    return [
      Book(
        'assets/images/common_book_4.jpg',
        'Name of the book',
      ),
      Book(
        'assets/images/common_book_3.jpg',
        'Name of the book',
      ),
      Book(
        'assets/images/common_book_2.jpg',
        'Name of the book',
      ),
      Book(
        'assets/images/common_book_1.jpg',
        'Name of the book',
      ),


    ];
  }
}