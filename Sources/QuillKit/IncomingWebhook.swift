import Foundation
import BlockKit

/// An incoming webhook allows you to generate a unique link at which you can post messages one-way into a channel.
/// This is typically useful for testing and/or integrating Quill into other systems easily.
///
/// You can create an incoming channel webhook for a channel by going to Settings , selecting the Team that owns the channel, clicking the Incoming Webhooks tab then clicking Add Webhook .
public struct IncomingWebhook: Encodable {
    /// Text body to send. This field works differently whether you're using blocks or attachments.
    public let text: String
    /// Set the title of a new thread, or update the title of an existing thread.
    public let title: String?
    /// A JSON-based array of structured blocks, presented as a URL-encoded string.
    public let blocks: [Block]?
    /// A JSON-based array of structured attachments, presented as a URL-encoded string.
//    public let attachments: Array
    /// Provide a thread_ts from a previous message's ts to thread the reply vs making a new thread in a channel.
    public let thread_ts: String?
    /// A UID per webhook you can set that will map this to a thread id.
    /// The first time you use this, we'll insert a new thread.
    /// Subsequent requests with this set will post messages to the same thread.
    /// This is useful for integrating with systems where storing state is difficult (e.g. CI systems).
    public let thread_uid: String?
    
    public init(
        text: String,
        title: String? = nil,
        blocks: [Block]? = nil,
        thread_ts: String? = nil,
        thread_uid: String? = nil
    ) {
        self.text = text
        self.title = title
        self.blocks = blocks
        self.thread_ts = thread_ts
        self.thread_uid = thread_uid
    }
}
