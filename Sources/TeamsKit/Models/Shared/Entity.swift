import Foundation

public enum EntityType: String, Codable {
    /// decoded from teams is `mention`, but needs to be `Mention` when encoded back
    case mention
    case clientInfo
    case place = "Place"
    case geoCoordinates = "GeoCoordinates"
}

/// Metadata object pertaining to an activity.
public enum Entity: Codable {
    case mention(Mention)
    case clientInfo(ClientInfo)
    case place(Place)
    case geoCoordinates(GeoCoordinates)
    
    enum CodingKeys: String, CodingKey {
        case type
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .mention(let mention): try container.encode(mention)
        case .clientInfo(let clientInfo): try container.encode(clientInfo)
        case .place(let place): try container.encode(place)
        case .geoCoordinates(let geoCoordinates): try container.encode(geoCoordinates)
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(EntityType.self, forKey: .type)
        switch type {
        case .mention: self = .mention(try Mention(from: decoder))
        case .clientInfo: self = .clientInfo(try ClientInfo(from: decoder))
        case .place: self = .place(try Place(from: decoder))
        case .geoCoordinates: self = .geoCoordinates(try GeoCoordinates(from: decoder))
        }
    }
    
    public static func mention(mentioned: ChannelAccount, text: String?) -> Self {
        let entity = Mention(mentioned: mentioned, text: text)
        return .mention(entity)
    }
    
    public static func clientInfo(locale: String, country: String, platform: String, timezone: String) -> Self {
        let entity = ClientInfo(locale: locale, country: country, platform: platform, timezone: timezone)
        return .clientInfo(entity)
    }
    
    public static func place(address: Place.Address, geo: GeoCoordinates, hasMap: Place.HasMap, name: String) -> Self {
        let entity = Place(address: address, geo: geo, hasMap: hasMap, name: name)
        return .place(entity)
    }
    
    public static func geoCoordinates(elevation: Double, latitude: Double, longitude: Double, name: String) -> Self {
        let entity = GeoCoordinates(elevation: elevation, latitude: latitude, longitude: longitude, name: name)
        return .geoCoordinates(entity)
    }
}

extension Entity {
    public struct ClientInfo: Codable {
        public let type: EntityType
        public let locale: String
        public let country: String
        public let platform: String
        public let timezone: String
        
        public init(locale: String, country: String, platform: String, timezone: String) {
            self.locale = locale
            self.country = country
            self.platform = platform
            self.timezone = timezone
            self.type = .clientInfo
        }
    }
}

extension Entity {
    /// Defines a user or bot that was mentioned in the conversation.
    public struct Mention: Codable {
        /// A ChannelAccount object that specifies the user or the bot that was mentioned.
        public let mentioned: ChannelAccount
        /// The user or bot as mentioned in the conversation.
        /// For example, if the message is "@ColorBot pick me a new color," this property would be set to **@ColorBot**.
        /// Not all channels set this property.
        public let text: String?
        /// This object's type.
        public let type: String
        
        public init(mentioned: ChannelAccount, text: String?) {
            self.mentioned = mentioned
            self.text = text
            self.type = "Mention"
        }
    }
}

extension Entity {
    /// Defines a geographical location using World Geodetic System (WSG84) coordinates.
    public struct GeoCoordinates: Codable {
        /// Elevation of the location.
        public let elevation: Double
        /// Latitude of the location.
        public let latitude: Double
        /// Longitude of the location.
        public let longitude: Double
        /// Name of the location.
        public let name: String
        /// The type of this object.
        public let type: String
        
        public init(elevation: Double, latitude: Double, longitude: Double, name: String) {
            self.elevation = elevation
            self.latitude = latitude
            self.longitude = longitude
            self.name = name
            self.type = "GeoCoordinates"
        }
    }
}

extension Entity {
    /// Defines a place that was mentioned in the conversation.
    public struct Place: Codable {
        /// Address of a place. This property can be a string or a complex object of type PostalAddress.
        public let address: Address
        /// A GeoCoordinates object that specifies the geographical coordinates of the place.
        public let geo: GeoCoordinates
        /// Map to the place. This property can be a string (URL) or a complex object of type Map.
        public let hasMap: HasMap
        /// Name of the place.
        public let name: String
        /// This object's type.
        public let type: String
        
        public init(address: Address, geo: GeoCoordinates, hasMap: HasMap, name: String) {
            self.address = address
            self.geo = geo
            self.hasMap = hasMap
            self.name = name
            self.type = "Place"
        }
        
        public enum HasMap: Codable {
            case url(URL)
            case map(Map)
            
            public func encode(to encoder: Encoder) throws {
                var container = encoder.unkeyedContainer()
                switch self {
                case .url(let url): try container.encode(url)
                case .map(let map): try container.encode(map)
                }
            }
            
            public init(from decoder: Decoder) throws {
                self = .url(try URL(from: decoder))
            }
            
            public struct Map: Codable {}
        }
        
        public enum Address: Codable {
            case string(String)
            case address(PostalAddress)
            
            public func encode(to encoder: Encoder) throws {
                var container = encoder.unkeyedContainer()
                switch self {
                case .string(let string): try container.encode(string)
                case .address(let address): try container.encode(address)
                }
            }
            
            public init(from decoder: Decoder) throws {
                self = .string(try String(from: decoder))
            }
            
            public struct PostalAddress: Codable {}
        }
    }
}
