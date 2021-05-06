import Foundation

extension JSONEncoder {
    public static let teams: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .custom { date, encoder in
            let string = DateFormatter.teams.string(from: date)
            var container = encoder.singleValueContainer()
            try container.encode(string)
        }
        
        return encoder
    }()
}
