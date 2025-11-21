import Foundation

/// Send and receive an email that contains body, subject, and importance metadata
/// To create an email message, set the Activity object's channelData property to a JSON object that contains these properties:
public struct Email: Encodable {
    /// The HTML to use for the body of the message.
    public let htmlBody: String
    /// The subject to use for the message.
    public let subject: String
    /// The importance flag to use for the message: low, normal, or high.
    public let importance: Importance
    /// A semicolon (;) delimited string of email addresses to add to the message's To field.
    public let toRecipients: String
    /// A semicolon (;) delimited string of email addresses to add to the message's Cc (carbon copy) field.
    public let ccRecipients: String
    /// A semicolon (;) delimited string of email addresses to add to the message's Bcc (blind carbon copy) field.
    public let bbcRecipients: String
    
    public init(htmlBody: String, subject: String, importance: Importance, toRecipients: [String], ccRecipients: [String], bbcRecipients: [String]) {
        self.htmlBody = htmlBody
        self.subject = subject
        self.importance = importance
        self.toRecipients = toRecipients.joined(separator: ";")
        self.ccRecipients = ccRecipients.joined(separator: ";")
        self.bbcRecipients = bbcRecipients.joined(separator: ";")
    }
}
