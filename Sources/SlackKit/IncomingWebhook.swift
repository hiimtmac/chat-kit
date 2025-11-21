import Foundation
import BlockKit

/// There are a few ways for apps to send, retrieve, and modify Slack messages, and if you're a beginner with that, you should read our managing messages overview.
///
/// All of the Slack APIs that publish messages use a common base structure, called a message payload.
/// This is a JSON object that is used to define metadata about the message, such as where it should be published, as well as its visual composition.
///
/// If you're using the Web API to send messages, you'll also need to specify the channel where the message should be published.
public struct IncomingWebhook: Encodable {
    /// The usage of this field changes depending on whether you're using blocks or not.
    /// If you are, this is used as a fallback string to display in notifications.
    /// If you aren't, this is the main body text of the message. It can be formatted as plain text, or with mrkdwn.
    /// This field is not enforced as required when using blocks, however it is highly recommended that you include it as the aforementioned fallback.
    public let text: String
    /// An array of layout blocks in the same format as described in the building blocks guide.
    public let blocks: [Block]?
    /// An array of legacy secondary attachments. We recommend you use blocks instead.
//    public let attachments: Array
    /// The ID of another un-threaded message to reply to.
    public let thread_ts: String?
    /// Determines whether the text field is rendered according to mrkdwn formatting or not.
    /// Defaults to true.
    public let mrkdwn: Bool?
    
    public init(
        text: String,
        blocks: [Block]? = nil,
        thread_ts: String? = nil,
        mrkdwn: Bool? = nil
    ) {
        self.text = text
        self.blocks = blocks
        self.thread_ts = thread_ts
        self.mrkdwn = mrkdwn
    }
}
