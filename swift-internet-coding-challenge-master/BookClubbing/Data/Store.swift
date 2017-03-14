///
/// Store.swift
///

final class Store {
    
    static let shared = Store()
    
    var books = [Book]()
    
    func update(_ book: Book) {
        books = books.filter { $0.id != book.id }
        books.append(book)
    }
}
