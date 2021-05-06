import Foundation

public enum Router {
    case createConversation
    case deleteActivity(conversationId: String, activityId: String)
    case deleteConversationMember(conversationId: String, memberId: String)
    case getActivityMembers(conversationId: String, activityId: String)
    case getConversations(continuationToken: String)
    case getConversationMember(conversationId: String, memberId: String)
    case getConversationMembers(conversationId: String)
    case getConversationPagedMembers(conversationId: String, pageSize: String, continuationToken: String)
    case replyToActivity(conversationId: String, activityId: String)
    case sendConversationHistory(conversationId: String)
    case sendToConversation(conversationId: String)
    case updateActivity(conversationId: String, activityId: String)
    case uploadAttachmentToChannel(conversationId: String)
    case getAttachmentInfo(attachmentId: String)
    case getAttachment(attachmentId: String, viewId: String)
    
    public var method: HTTPMethod {
        switch self {
        case .createConversation: return .post
        case .deleteActivity: return .delete
        case .deleteConversationMember: return .delete
        case .getActivityMembers: return .get
        case .getConversations: return .get
        case .getConversationMember: return .get
        case .getConversationMembers: return .get
        case .getConversationPagedMembers: return .get
        case .replyToActivity: return .post
        case .sendConversationHistory: return .post
        case .sendToConversation: return .post
        case .updateActivity: return .put
        case .uploadAttachmentToChannel: return .post
        case .getAttachmentInfo: return .get
        case .getAttachment: return .get
        }
    }
    
    public var slug: String {
        switch self {
        case .createConversation:
            return "/v3/conversations"
        case .deleteActivity(let conversationId, let activityId):
            return "/v3/conversations/\(conversationId)/activities/\(activityId)"
        case .deleteConversationMember(let conversationId, let memberId):
            return "/v3/conversations/\(conversationId)/members/\(memberId)"
        case .getActivityMembers(let conversationId, let activityId):
            return "/v3/conversations/\(conversationId)/activities/\(activityId)/members"
        case .getConversations(let continuationToken):
            return "/v3/conversations?continuationToken={\(continuationToken)}"
        case .getConversationMember(let conversationId, let memberId):
            return "/v3/conversations/\(conversationId)/members/\(memberId)"
        case .getConversationMembers(let conversationId):
            return "/v3/conversations/\(conversationId)/members"
        case .getConversationPagedMembers(let conversationId, let pageSize, let continuationToken):
            return "/v3/conversations/\(conversationId)/pagedmembers?pageSize=\(pageSize)&continuationToken=\(continuationToken)"
        case .replyToActivity(let conversationId, let activityId):
            return "/v3/conversations/\(conversationId)/activities/\(activityId)"
        case .sendConversationHistory(let conversationId):
            return "/v3/conversations/\(conversationId)/activities/history"
        case .sendToConversation(let conversationId):
            return "/v3/conversations/\(conversationId)/activities"
        case .updateActivity(let conversationId, let activityId):
            return "/v3/conversations/\(conversationId)/activities/\(activityId)"
        case .uploadAttachmentToChannel(let conversationId):
            return "/v3/conversations/\(conversationId)/attachments"
        case .getAttachmentInfo(let attachmentId):
            return "/v3/attachments/\(attachmentId)"
        case .getAttachment(let attachmentId, let viewId):
            return "/v3/attachments/\(attachmentId)/views/\(viewId)"
        }
    }
    
    public enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
}
