import Foundation

extension JSONDecoder {
    public static let teams: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let dateStr = try container.decode(String.self)
            
            if let date = DateFormatter.teams.date(from: dateStr) {
                return date
            } else {
                throw DecodingError.dataCorruptedError(
                    in: container,
                    debugDescription: "Could not decode \(dateStr) to Teams Date"
                )
            }
        }
        
        return decoder
    }()
}
