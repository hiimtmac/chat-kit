import Foundation

extension CompositionObject {
    /// An object containing some text, formatted either as plain_text or using mrkdwn, our proprietary contribution to the much beloved Markdown standard.
    public struct Text: Encodable {
        /// The formatting to use for this text object. Can be one of plain_textor mrkdwn.
        public let type: TextType
        /// The text for the block.
        /// This field accepts any of the standard text formatting markup when type is mrkdwn.
        public let text: String
        /// Indicates whether emojis in a text field should be escaped into the colon emoji format.
        /// This field is only usable when type is plain_text.
        public let emoji: Bool?
        /// When set to false (as is default) URLs will be auto-converted into links, conversation names will be link-ified, and certain mentions will be automatically parsed.
        /// Using a value of true will skip any preprocessing of this nature, although you can still include manual parsing strings.
        /// This field is only usable when type is mrkdwn.
        public let verbatim: Bool?
        
        init(
            type: TextType,
            text: String,
            emoji: Bool? = nil,
            verbatim: Bool? = nil
        ) {
            self.type = type
            self.text = text
            self.emoji = emoji
            self.verbatim = verbatim
        }
        
        public static func plainText(
            text: String,
            emoji: Bool? = nil
        ) -> Self {
            .init(type: .plain_text, text: text, emoji: emoji)
        }
        
        public static func markdown(
            text: String,
            verbatim: Bool? = nil
        ) -> Self {
            .init(type: .mrkdwn, text: text, verbatim: verbatim)
        }
        
        public enum TextType: String, Encodable {
            case plain_text
            case mrkdwn
        }
    }
}
