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
    
    public static func divider(
        block_id: String? = nil
    ) -> Self {
        .divider(
            Divider(
                block_id: block_id
            )
        )
    }
    
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
    
    public static func image(
        image_url: String,
        alt_text: String,
        title: CompositionObject.Text? = nil,
        block_id: String? = nil
    ) -> Self {
        .image(Image(image_url: image_url, alt_text: alt_text, title: title, block_id: block_id))
    }
    
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

extension Block {
    /// A block that is used to hold interactive elements.
    ///
    /// Available in surfaces: Modals Messages Home tabs
    public struct Action: Encodable {
        /// The type of block. For an actions block, type is always actions.
        public let type: String
        /// An array of interactive element objects - buttons, select menus, overflow menus, or date pickers.
        /// There is a maximum of 5 elements in each action block.
        public let elements: [BlockElement]
        /// A string acting as a unique identifier for a block.
        /// If not specified, a block_id will be generated.
        /// You can use this block_id when you receive an interaction payload to identify the source of the action.
        /// Maximum length for this field is 255 characters.
        /// block_id should be unique for each message and each iteration of a message.
        /// If a message is updated, use a new block_id.
        public let block_id: String?
        
        init(
            elements: [BlockElement],
            block_id: String? = nil
        ) {
            self.type = "actions"
            self.elements = elements
            self.block_id = block_id
        }
    }
}

extension Block {
    /// Displays message context, which can include both images and text.
    ///
    /// Available in surfaces: Modals Messages Home tabs
    public struct Context: Encodable {
        /// The type of block. For a context block, type is always context.
        public let type: String
        /// An array of interactive element objects - buttons, select menus, overflow menus, or date pickers.
        /// There is a maximum of 5 elements in each action block.
        public let elements: [BlockElement]
        /// A string acting as a unique identifier for a block.
        /// If not specified, a block_id will be generated.
        /// You can use this block_id when you receive an interaction payload to identify the source of the action.
        /// Maximum length for this field is 255 characters.
        /// block_id should be unique for each message and each iteration of a message.
        /// If a message is updated, use a new block_id.
        public let block_id: String?
        
        init(
            elements: [BlockElement],
            block_id: String? = nil
        ) {
            self.type = "context"
            self.elements = elements
            self.block_id = block_id
        }
    }
}

extension Block {
    ///     A content divider, like an <hr>, to split up different blocks inside of a message.
    ///     The divider block is nice and neat, requiring only a type.
    ///
    ///     Available in surfaces: Modals Messages Home tabs
    public struct Divider: Encodable {
        /// The type of block. For a divider block, type is always divider.
        public let type: String
        /// A string acting as a unique identifier for a block.
        /// If not specified, a block_id will be generated.
        /// You can use this block_id when you receive an interaction payload to identify the source of the action.
        /// Maximum length for this field is 255 characters.
        /// block_id should be unique for each message and each iteration of a message.
        /// If a message is updated, use a new block_id.
        public let block_id: String?
        
        init(
            block_id: String? = nil
        ) {
            self.type = "divider"
            self.block_id = block_id
        }
    }
}

extension Block {
    /// Displays a remote file. You can't add this block to app surfaces directly, but it will show up when retrieving messages that contain remote files.
    ///
    /// Appears in surfaces: Messages
    /// If you want to add remote files to messages, follow our guide.
    public struct File: Encodable {
        /// The type of block. For a file block, type is always file.
        public let type: String
        /// The external unique ID for this file.
        public let external_id: String
        /// At the moment, source will always be remote for a remote file.
        public let source: String
        /// A string acting as a unique identifier for a block.
        /// If not specified, a block_id will be generated.
        /// You can use this block_id when you receive an interaction payload to identify the source of the action.
        /// Maximum length for this field is 255 characters.
        /// block_id should be unique for each message and each iteration of a message.
        /// If a message is updated, use a new block_id.
        public let block_id: String?
        
        init(
            external_id: String,
            source: String,
            block_id: String? = nil
        ) {
            self.type = "file"
            self.external_id = external_id
            self.source = source
            self.block_id = block_id
        }
    }
}

extension Block {
    /// A header is a plain-text block that displays in a larger, bold font.
    /// Use it to delineate between different groups of content in your app's surfaces.
    ///
    /// Available in surfaces: Modals Messages Home tabs
    public struct Header: Encodable {
        /// The type of block. For this block, type will always be header.
        public let type: String
        /// The text for the block, in the form of a plain_text text object.
        /// Maximum length for the text in this field is 150 characters.
        public let text: CompositionObject.Text
        /// A string acting as a unique identifier for a block.
        /// If not specified, a block_id will be generated.
        /// You can use this block_id when you receive an interaction payload to identify the source of the action.
        /// Maximum length for this field is 255 characters.
        /// block_id should be unique for each message and each iteration of a message.
        /// If a message is updated, use a new block_id.
        public let block_id: String?
        
        init(
            text: CompositionObject.Text,
            block_id: String? = nil
        ) {
            self.type = "header"
            self.text = text
            self.block_id = block_id
        }
    }
}

extension Block {
    /// A simple image block, designed to make those cat photos really pop.
    ///
    /// Available in surfaces: Modals Messages Home tabs
    public struct Image: Encodable {
        /// The type of block. For an image block, type is always image.
        public let type: String
        /// The URL of the image to be displayed.
        /// Maximum length for this field is 3000 characters.
        public let image_url: String
        /// A plain-text summary of the image. This should not contain any markup.
        /// Maximum length for this field is 2000 characters.
        public let alt_text: String
        /// An optional title for the image in the form of a text object that can only be of type: plain_text.
        /// Maximum length for the text in this field is 2000 characters.
        public let title: CompositionObject.Text?
        /// A string acting as a unique identifier for a block.
        /// If not specified, a block_id will be generated.
        /// You can use this block_id when you receive an interaction payload to identify the source of the action.
        /// Maximum length for this field is 255 characters.
        /// block_id should be unique for each message and each iteration of a message.
        /// If a message is updated, use a new block_id.
        public let block_id: String?
        
        public init(
            image_url: String,
            alt_text: String,
            title: CompositionObject.Text? = nil,
            block_id: String? = nil
        ) {
            self.type = "image"
            self.image_url = image_url
            self.alt_text = alt_text
            self.title = title
            self.block_id = block_id
        }
    }
}

extension Block {
    /// A block that collects information from users - it can hold a plain-text input element, a checkbox element, a radio button element, a select menu element, a multi-select menu element, or a datepicker.
    ///
    /// Available in surfaces: Modals Messages Home tabs
    /// Read our guides to collecting input in modals or in Home tabs to learn how input blocks pass information to your app.
    public struct Input: Encodable {
        /// The type of block. For an input block, type is always input.
        public let type: String
        /// A label that appears above an input element in the form of a text object that must have type of plain_text.
        /// Maximum length for the text in this field is 2000 characters.
        public let label: CompositionObject.Text
        /// An plain-text input element, a checkbox element, a radio button element, a select menu element, a multi-select menu element, or a datepicker.
        public let element: BlockElement
        /// A boolean that indicates whether or not the use of elements in this block should dispatch a block_actions payload.
        /// Defaults to false.
        public let dispatch_action: Bool?
        /// A string acting as a unique identifier for a block.
        /// If not specified, a block_id will be generated.
        /// You can use this block_id when you receive an interaction payload to identify the source of the action.
        /// Maximum length for this field is 255 characters.
        /// block_id should be unique for each message and each iteration of a message.
        /// If a message is updated, use a new block_id.
        public let block_id: String?
        /// An optional hint that appears below an input element in a lighter grey.
        /// It must be a a text object with a type of plain_text.
        /// Maximum length for the text in this field is 2000 characters.
        public let hint: CompositionObject.Text?
        /// A boolean that indicates whether the input element may be empty when a user submits the modal.
        /// Defaults to false.
        public let optional: Bool?
        
        init(
            label: CompositionObject.Text,
            element: BlockElement,
            dispatch_action: Bool? = nil,
            block_id: String? = nil,
            hint: CompositionObject.Text? = nil,
            optional: Bool? = nil
        ) {
            self.type = "input"
            self.label = label
            self.element = element
            self.dispatch_action = dispatch_action
            self.block_id = block_id
            self.hint = hint
            self.optional = optional
        }
    }
}

extension Block {
    /// A section is one of the most flexible blocks available - it can be used as a simple text block, in combination with text fields, or side-by-side with any of the available block elements.
    ///
    /// Available in surfaces: Modals Messages Home tabs
    public struct Section: Encodable {
        /// The type of block. For a section block, type will always be section.
        public let type: String
        /// The text for the block, in the form of a text object.
        /// Maximum length for the text in this field is 3000 characters.
        /// This field is not required if a valid array of fields objects is provided instead.
        public let text: CompositionObject.Text?
        /// A string acting as a unique identifier for a block.
        /// If not specified, a block_id will be generated.
        /// You can use this block_id when you receive an interaction payload to identify the source of the action.
        /// Maximum length for this field is 255 characters.
        /// block_id should be unique for each message and each iteration of a message.
        /// If a message is updated, use a new block_id.
        public let block_id: String?
        /// Required if no text is provided.
        /// An array of text objects.
        /// Any text objects included with fields will be rendered in a compact format that allows for 2 columns of side-by-side text.
        /// Maximum number of items is 10.
        /// Maximum length for the text in each item is 2000 characters.
        public let fields: [CompositionObject.Text]?
        /// One of the available element objects.
        public let accessory: BlockElement?
        
        init(
            text: CompositionObject.Text? = nil,
            block_id: String? = nil,
            fields: [CompositionObject.Text]? = nil,
            accessory: BlockElement? = nil
        ) {
            self.type = "section"
            self.text = text
            self.block_id = block_id
            self.fields = fields
            self.accessory = accessory
        }
    }
}
