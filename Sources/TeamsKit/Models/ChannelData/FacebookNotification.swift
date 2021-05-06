import Foundation

/// Send Facebook notifications natively
public struct FacebookNotification: Encodable {
    /// The type of notification (e.g., REGULAR, SILENT_PUSH, NO_PUSH).
    public let notificationType: NotificationType
    /// An attachment that specifies an image, video, or other multimedia type, or a templated attachment such as a receipt.
    public let attachment: Attachment
    
    enum CodingKeys: String, CodingKey {
        case notificationType = "notification_type"
        case attachment
    }
}

extension FacebookNotification {
    public struct Attachment: Encodable {
        // https://docs.microsoft.com/en-us/previous-versions/azure/bot-service/rest-api/bot-framework-rest-connector-channeldata?view=azure-bot-service-3.0#create-a-facebook-notification
        // https://developers.facebook.com/docs/messenger-platform/reference/send-api#guidelines
    }
    
    public enum NotificationType: String, Encodable {
        case regular = "REGULAR"
        case silentPush = "SILENT_PUSH"
        case noPush = "NO_PUSH"
    }
}
