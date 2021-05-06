import Foundation

public enum CompositionObject: Encodable {
    case text(Text)
    case confirmationDialog(ConfirmationDialog)
    case option(Option)
    case optionGroup(OptionGroup)
    case dispatchActionConfiguration(DispatchActionConfiguration)
    case filterForConversationList(FilterForConversationList)
    
    enum CodingKeys: String, CodingKey {
        case type
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .text(let object): try container.encode(object)
        case .confirmationDialog(let object): try container.encode(object)
        case .option(let object):  try container.encode(object)
        case .optionGroup(let object): try container.encode(object)
        case .dispatchActionConfiguration(let object): try container.encode(object)
        case .filterForConversationList(let object): try container.encode(object)
        }
    }
    
    static func plainText(
        text: String,
        emoji: Bool? = nil
    ) -> Self {
        .text(
            .plainText(text: text, emoji: emoji)
        )
    }
    
    static func markdown(
        text: String,
        verbatim: Bool? = nil
    ) -> Self {
        .text(
            .markdown(text: text, verbatim: verbatim)
        )
    }
    
    public static func confirmationDialog(
        title: String,
        titleEmoji: Bool? = nil,
        text: Text,
        confirm: String,
        confirmEmoji: Bool? = nil,
        deny: String,
        denyEmoji: Bool? = nil,
        style: ConfirmationDialog.Style? = nil
    ) -> Self {
        .confirmationDialog(
            ConfirmationDialog(
                title: .plainText(text: title, emoji: titleEmoji),
                text: text,
                confirm: .plainText(text: confirm, emoji: confirmEmoji),
                deny: .plainText(text: deny, emoji: denyEmoji),
                style: style
            )
        )
    }
    
    public static func option(
        text: String,
        textEmoji: Bool? = nil,
        value: String,
        description: String? = nil,
        descriptionEmoji: Bool? = nil,
        url: String? = nil
    ) -> Self {
        .option(
            Option(
                text: .plainText(text: text, emoji: textEmoji),
                value: value,
                description: description.flatMap { .plainText(text: $0, emoji: descriptionEmoji) },
                url: url
            )
        )
    }
    
    public static func optionGroup(
        text: String,
        emoji: Bool? = nil,
        options: [Option]
    ) -> Self {
        .optionGroup(
            OptionGroup(
                label: .plainText(text: text, emoji: emoji),
                options: options
            )
        )
    }
    
    public static func dispatchActionConfiguration(
        trigger_actions_on: [DispatchActionConfiguration.ActionTrigger]? = nil
    ) -> Self {
        .dispatchActionConfiguration(
            DispatchActionConfiguration(
                trigger_actions_on: trigger_actions_on
            )
        )
    }
    
    public static func filterForConversationList(
        include: [FilterForConversationList.IncludeOption]? = nil,
        exclude_external_shared_channels: Bool? = nil,
        exclude_bot_users: Bool? = nil
    ) -> Self {
        .filterForConversationList(
            FilterForConversationList(
                include: include,
                exclude_external_shared_channels: exclude_external_shared_channels,
                exclude_bot_users: exclude_bot_users
            )
        )
    }
}

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

extension CompositionObject {
    /// An object that defines a dialog that provides a confirmation step to any interactive element.
    /// This dialog will ask the user to confirm their action by offering a confirm and deny buttons.
    public struct ConfirmationDialog: Encodable {
        /// A plain_text-only text object that defines the dialog's title.
        /// Maximum length for this field is 100 characters.
        public let title: Text
        /// A text object that defines the explanatory text that appears in the confirm dialog.
        /// Maximum length for the text in this field is 300 characters.
        public let text: Text
        /// A plain_text-only text object to define the text of the button that confirms the action.
        /// Maximum length for the text in this field is 30 characters.
        public let confirm: Text
        /// A plain_text-only text object to define the text of the button that cancels the action.
        /// Maximum length for the text in this field is 30 characters.
        public let deny: Text
        /// Defines the color scheme applied to the confirm button.
        /// If this field is not provided, the default value will be primary.
        public let style: Style?
        
        init(
            title: Text,
            text: Text,
            confirm: Text,
            deny: Text,
            style: Style? = nil
        ) {
            self.title = title
            self.text = text
            self.confirm = confirm
            self.deny = deny
            self.style = style
        }
        
        public enum Style: String, Encodable {
            /// A value of primary will display the button with a green background on desktop, or blue text on mobile.
            case primary
            /// A value of danger will display the button with a red background on desktop, or red text on mobile.
            case danger
        }
    }
}

extension CompositionObject {
    /// An object that represents a single selectable item in a select menu, multi-select menu, checkbox group, radio button group, or overflow menu.
    public struct Option: Encodable {
        /// A text object that defines the text shown in the option on the menu.
        /// Overflow, select, and multi-select menus can only use plain_text objects, while radio buttons and checkboxes can use mrkdwn text objects.
        /// Maximum length for the text in this field is 75 characters.
        public let text: Text
        /// A unique string value that will be passed to your app when this option is chosen.
        /// Maximum length for this field is 75 characters.
        public let value: String
        /// A plain_text only text object that defines a line of descriptive text shown below the text field beside the radio button.
        /// Maximum length for the text object within this field is 75 characters.
        public let description: Text?
        /// A URL to load in the user's browser when the option is clicked. The url attribute is only available in overflow menus.
        /// Maximum length for this field is 3000 characters. If you're using url, you'll still receive an interaction payload and will need to send an acknowledgement response.
        public let url: String?
        
        init(
            text: Text,
            value: String,
            description: Text? = nil,
            url: String? = nil
        ) {
            self.text = text
            self.value = value
            self.description = description
            self.url = url
        }
    }
}

extension CompositionObject {
    /// Provides a way to group options in a select menu or multi-select menu.
    public struct OptionGroup: Encodable {
        /// A plain_text only text object that defines the label shown above this group of options.
        /// Maximum length for the text in this field is 75 characters.
        public let label: Text
        /// An array of option objects that belong to this specific group.
        /// Maximum of 100 items.
        public let options: [Option]
        
        init(
            label: Text,
            options: [Option]
        ) {
            self.label = label
            self.options = options
        }
    }
}

extension CompositionObject {
    /// Determines when a plain-text input element will return a block_actions interaction payload.
    public struct DispatchActionConfiguration: Encodable {
        /// An array of interaction types that you would like to receive a block_actions payload for.
        public let trigger_actions_on: [ActionTrigger]?
        
        init(
            trigger_actions_on: [ActionTrigger]? = nil
        ) {
            self.trigger_actions_on = trigger_actions_on
        }
        
        /// interaction types, Should be one or both of:
        public enum ActionTrigger: String, Encodable {
            /// payload is dispatched when user presses the enter key while the input is in focus.
            /// Hint text will appear underneath the input explaining to the user to press enter to submit.
            case on_enter_pressed
            /// payload is dispatched when a character is entered (or removed) in the input.
            case on_character_entered
        }
    }
}

extension CompositionObject {
    /// Provides a way to filter the list of options in a conversations select menu or conversations multi-select menu.
    ///
    /// Please note that while none of the fields above are individually required, you must supply at least one of these fields.
    public struct FilterForConversationList: Encodable {
        /// Indicates which type of conversations should be included in the list.
        /// When this field is provided, any conversations that do not match will be excluded.
        /// You should provide an array of strings from the following options: im, mpim, private, and public.
        /// The array cannot be empty.
        public let include: [IncludeOption]?
        /// Indicates whether to exclude external shared channels from conversation lists.
        /// Defaults to false.
        public let exclude_external_shared_channels: Bool?
        /// Indicates whether to exclude bot users from conversation lists.
        /// Defaults to false.
        public let exclude_bot_users: Bool?
        
        init(
            include: [IncludeOption]? = nil,
            exclude_external_shared_channels: Bool? = nil,
            exclude_bot_users: Bool? = nil
        ) {
            self.include = include
            self.exclude_external_shared_channels = exclude_external_shared_channels
            self.exclude_bot_users = exclude_bot_users
        }
        
        public enum IncludeOption: String, Encodable {
            case im
            case mpim
            case `private`
            case `public`
        }
    }
}
