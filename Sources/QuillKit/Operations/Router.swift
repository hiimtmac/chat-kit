import Foundation

public enum Router {
    case postMessage
    case postEphemeral
    case updateChat
    case unfurlChat
    case createChannel
    
    public var method: HTTPMethod {
        switch self {
        case .postMessage: return .post
        case .postEphemeral: return .post
        case .updateChat: return .post
        case .unfurlChat: return .post
        case .createChannel: return .post
        }
    }
    
    public var slug: String {
        switch self {
        case .postMessage:
            return "/chat.postMessage"
        case .postEphemeral:
            return "/chat.PostEphemeral"
        case .updateChat:
            return "/chat.update"
        case .unfurlChat:
            return "/chat.unfurl"
        case .createChannel:
            return "/channels.create"
        }
    }
    
    public enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
}
