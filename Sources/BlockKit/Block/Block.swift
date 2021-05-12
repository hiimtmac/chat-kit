import Foundation

/// Blocks are a series of components that can be combined to create visually rich and compellingly interactive messages.
///
/// Block type    Available in surfaces
/// Actions    Modals Messages Home tabs
/// Context    Modals Messages Home tabs
/// Divider    Modals Messages Home tabs
/// File    Messages
/// Header    Modals Messages Home tabs
/// Image    Modals Messages Home tabs
/// Input    Modals Messages Home tabs
/// Section    Modals Messages Home tabs
public enum Block: Encodable {
    case action(Action)
    case context(Context)
    case divider(Divider)
    case file(File)
    case header(Header)
    case image(Image)
    case input(Input)
    case section(Section)
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .action(let object): try container.encode(object)
        case .context(let object): try container.encode(object)
        case .divider(let object): try container.encode(object)
        case .file(let object): try container.encode(object)
        case .header(let object): try container.encode(object)
        case .image(let object): try container.encode(object)
        case .input(let object): try container.encode(object)
        case .section(let object): try container.encode(object)
        }
    }
    
    /// A block that is used to hold interactive elements.
    ///
    /// Available in surfaces: Modals, Messages, Home tabs
    /// - Parameters:
    ///   - elements: An array of interactive element objects - buttons, select menus, overflow menus, or date pickers. There is a maximum of 5 elements in each action block.
    ///   - block_id: A string acting as a unique identifier for a block. If not specified, a block_id will be generated. Maximum length for this field is 255 characters.
    /// - Returns: Action block
    public static func action(
        elements: [BlockElement],
        block_id: String? = nil
    ) -> Self {
        .action(
            Action(
                elements: elements,
                block_id: block_id
            )
        )
    }
    
    /// Displays message context, which can include both images and text.
    ///
    /// Available in surfaces: Modals, Messages, Home tabs
    /// - Parameters:
    ///   - elements: An array of interactive element objects - buttons, select menus, overflow menus, or date pickers. There is a maximum of 5 elements in each action block.
    ///   - block_id: A string acting as a unique identifier for a block. If not specified, a block_id will be generated. Maximum length for this field is 255 characters.
    /// - Returns: Context block
    public static func context(
        elements: [BlockElement],
        block_id: String? = nil
    ) -> Self {
        .context(
            Context(
                elements: elements,
                block_id: block_id
            )
        )
    }
    
    /// A content divider, like an <hr>, to split up different blocks inside of a message.
    /// The divider block is nice and neat, requiring only a type.
    ///
    /// Available in surfaces: Modals Messages Home tabs
    /// - Parameter block_id: A string acting as a unique identifier for a block. If not specified, a block_id will be generated. Maximum length for this field is 255 characters.
    /// - Returns: Divider block
    public static func divider(
        block_id: String? = nil
    ) -> Self {
        .divider(
            Divider(
                block_id: block_id
            )
        )
    }
    
    /// Displays a remote file. You can't add this block to app surfaces directly, but it will show up when retrieving messages that contain remote files.
    ///
    /// Appears in surfaces: Messages
    /// If you want to add remote files to messages, follow our guide.
    /// - Parameters:
    ///   - external_id: The external unique ID for this file.
    ///   - source: At the moment, source will always be remote for a remote file.
    ///   - block_id: A string acting as a unique identifier for a block. If not specified, a block_id will be generated. Maximum length for this field is 255 characters.
    /// - Returns: File block
    public static func file(
        external_id: String,
        source: String,
        block_id: String? = nil
    ) -> Self {
        .file(
            File(
                external_id: external_id,
                source: source,
                block_id: block_id
            )
        )
    }
    
    /// A header is a plain-text block that displays in a larger, bold font.
    /// Use it to delineate between different groups of content in your app's surfaces.
    ///
    /// Available in surfaces: Modals, Messages, Home tabs
    /// - Parameters:
    ///   - text: The text for the block, in the form of a plain_text text object. Maximum length for the text in this field is 150 characters.
    ///   - emoji: Indicates whether emojis in a text field should be escaped into the colon emoji format.
    ///   - block_id: A string acting as a unique identifier for a block. If not specified, a block_id will be generated. Maximum length for this field is 255 characters.
    /// - Returns: Header block
    public static func header(
        text: String,
        emoji: Bool? = nil,
        block_id: String? = nil
    ) -> Self {
        .header(
            Header(
                text: .plainText(text: text, emoji: emoji),
                block_id: block_id
            )
        )
    }
    
    /// A simple image block, designed to make those cat photos really pop.
    ///
    /// Available in surfaces: Modals Messages Home tabs
    /// - Parameters:
    ///   - image_url: The URL of the image to be displayed. Maximum length for this field is 3000 characters.
    ///   - alt_text: A plain-text summary of the image. This should not contain any markup. Maximum length for this field is 2000 characters.
    ///   - title: An optional title for the image in the form of a text object that can only be of type: plain_text. Maximum length for the text in this field is 2000 characters.
    ///   - titleEmoji: Indicates whether emojis in a text field should be escaped into the colon emoji format.
    ///   - block_id: A string acting as a unique identifier for a block. If not specified, a block_id will be generated. Maximum length for this field is 255 characters.
    /// - Returns: Image block
    public static func image(
        image_url: String,
        alt_text: String,
        title: String? = nil,
        titleEmoji: Bool? = nil,
        block_id: String? = nil
    ) -> Self {
        .image(
            Image(
                image_url: image_url,
                alt_text: alt_text,
                title: title.flatMap { .plainText(text: $0, emoji: titleEmoji) },
                block_id: block_id
            )
        )
    }
    
    /// A block that collects information from users - it can hold a plain-text input element, a checkbox element, a radio button element, a select menu element, a multi-select menu element, or a datepicker.
    ///
    /// Available in surfaces: Modals, Messages, Home tabs
    /// - Parameters:
    ///   - label: A label that appears above an input element in the form of a text object that must have type of plain_text. Maximum length for the text in this field is 2000 characters.
    ///   - labelEmoji: Indicates whether emojis in a text field should be escaped into the colon emoji format.
    ///   - element: An plain-text input element, a checkbox element, a radio button element, a select menu element, a multi-select menu element, or a datepicker.
    ///   - dispatch_action: A boolean that indicates whether or not the use of elements in this block should dispatch a block_actions payload. Defaults to false.
    ///   - block_id: A string acting as a unique identifier for a block. If not specified, a block_id will be generated. Maximum length for this field is 255 characters.
    ///   - hint: An optional hint that appears below an input element in a lighter grey. Maximum length for the text in this field is 2000 characters.
    ///   - hintEmoji: Indicates whether emojis in a text field should be escaped into the colon emoji format.
    ///   - optional: A boolean that indicates whether the input element may be empty when a user submits the modal. Defaults to false.
    /// - Returns: Input block
    public static func input(
        label: String,
        labelEmoji: Bool? = nil,
        element: BlockElement,
        dispatch_action: Bool? = nil,
        block_id: String? = nil,
        hint: String? = nil,
        hintEmoji: Bool? = nil,
        optional: Bool? = nil
    ) -> Self {
        .input(
            Input(
                label: .plainText(text: label, emoji: labelEmoji),
                element: element,
                dispatch_action: dispatch_action,
                block_id: block_id,
                hint: hint.flatMap { .plainText(text: $0, emoji: hintEmoji) },
                optional: optional
            )
        )
    }
    
    /// A section is one of the most flexible blocks available - it can be used as a simple text block, in combination with text fields, or side-by-side with any of the available block elements.
    ///
    /// Available in surfaces: Modals, Messages, Home tabs
    /// - Parameters:
    ///   - text: The text for the block, in the form of a text object. Maximum length for the text in this field is 3000 characters.
    ///   - emoji: Indicates whether emojis in a text field should be escaped into the colon emoji format.
    ///   - block_id: A string acting as a unique identifier for a block. If not specified, a block_id will be generated. Maximum length for this field is 255 characters.
    ///   - accessory: One of the available element objects.
    /// - Returns: Section block
    public static func plainTextSection(
        text: String,
        emoji: Bool? = nil,
        block_id: String? = nil,
        accessory: BlockElement? = nil
    ) -> Self {
        .section(
            Section(
                text: .plainText(text: text, emoji: emoji),
                block_id: block_id,
                fields: nil,
                accessory: accessory
            )
        )
    }
    
    /// A section is one of the most flexible blocks available - it can be used as a simple text block, in combination with text fields, or side-by-side with any of the available block elements.
    ///
    /// Available in surfaces: Modals, Messages, Home tabs
    /// - Parameters:
    ///   - text: The text for the block, in the form of a text object. Maximum length for the text in this field is 3000 characters.
    ///   - verbatim: When set to false (as is default) URLs will be auto-converted into links, conversation names will be link-ified, and certain mentions will be automatically parsed.
    ///   - block_id: A string acting as a unique identifier for a block. If not specified, a block_id will be generated. Maximum length for this field is 255 characters.
    ///   - accessory: One of the available element objects.
    /// - Returns: Section block
    public static func markdownSection(
        text: String,
        verbatim: Bool? = nil,
        block_id: String? = nil,
        accessory: BlockElement? = nil
    ) -> Self {
        .section(
            Section(
                text: .markdown(text: text, verbatim: verbatim),
                block_id: block_id,
                fields: nil,
                accessory: accessory
            )
        )
    }
    
    /// A section is one of the most flexible blocks available - it can be used as a simple text block, in combination with text fields, or side-by-side with any of the available block elements.
    ///
    /// Available in surfaces: Modals, Messages, Home tabs
    /// - Parameters:
    ///   - text: The text for the block, in the form of a text object. Maximum length for the text in this field is 3000 characters.
    ///   - block_id: A string acting as a unique identifier for a block. If not specified, a block_id will be generated. Maximum length for this field is 255 characters.
    ///   - fields: An array of text objects. Any text objects included with fields will be rendered in a compact format that allows for 2 columns of side-by-side text. Maximum number of items is 10. Maximum length for the text in each item is 2000 characters.
    ///   - accessory: One of the available element objects.
    /// - Returns: Section block
    public static func fieldsSection(
        text: CompositionObject.Text? = nil,
        block_id: String? = nil,
        fields: [CompositionObject.Text],
        accessory: BlockElement? = nil
    ) -> Self {
        .section(
            Section(
                text: text,
                block_id: block_id,
                fields: fields,
                accessory: accessory
            )
        )
    }
}
