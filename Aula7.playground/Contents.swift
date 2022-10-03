import Foundation

enum RowType {
    case image
    case text
}


// Protocols

protocol Item {
    func itemAction()
    func swipeAction()
    func tapAction()
}

protocol Row {
    var identifier: UUID { get }
    var name: String { get set }
    var type: RowType { get }

    func action()
}

extension Row {
    func action() {
        print("Row Action")
    }
}

protocol TextRowProtocol: Row {
    var title: String { get set }
}

protocol TextAndDescriptionRow: TextRowProtocol {
    var description: String { get set }
}

struct TextRow: TextRowProtocol {
    var title: String
    let identifier: UUID = UUID()
    var name: String
    let type: RowType = .text
}

extension TextRow: Item {
    func itemAction() {
        print("Item")
    }
    
    func swipeAction() {
        print("Swipe")
    }
    
    func tapAction() {
        print("Tap")
    }
}


struct DescriptionRow: TextAndDescriptionRow {
    var description: String
    var title: String
    var identifier: UUID
    var name: String
    let type: RowType = .text
}

struct ImageRow: Row {
    let identifier: UUID = UUID()
    var name: String
    let type: RowType = .image

    let imageData: Data
}

struct Table {
    var rows: [Row] = []
}

var table = Table()

table.rows.append(TextRow(title: "Title", name: "Nome"))
table.rows.append(ImageRow(name: "profilePicture", imageData: Data()))


// Generics
func swap<T>(_ value1: inout T, _ value2: inout T) {
    let tmp = value1
    value1 = value2
    value2 = tmp
}

func sum<T: Numeric>(_ num1: T, _ num2: T) -> T {
    return num1 + num2
}


// Extension
extension Int {
    var absoluteValue: Int {
        return abs(self)
    }
}

protocol Payable {
    var salary: Double { get set }
    var taxes: Double { get }
}

extension Payable where Self: CustomStringConvertible {
    var description: String {
        return "O salário líquido é de: \(self.salary - self.taxes)"
    }

    func foo() {
        print("Do something...")
    }
}

struct Employee: Payable {
    var salary: Double = 1000
    var taxes: Double = 100
}

extension Employee: CustomStringConvertible {}

var e = Employee()


// Tratamento de Erros
enum FileError: Error {
    case notFound
}

func readFile() throws -> String? {
    guard let url = Bundle.main.url(forResource: "caesarCiphe", withExtension: "txt"),
          let data = try? Data(contentsOf: url)
    else {
        throw FileError.notFound
    }
    return String(data: data, encoding: .utf8)
}

do {
    let txt = try readFile()
    print(txt)
} catch FileError.notFound {
    print("File Error")
} catch {
    print("Error: ", error.localizedDescription)
}
