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
    
    /// An object containing some text
    /// - Parameters:
    ///   - text: The text for the block.
    ///   - emoji: Indicates whether emojis in a text field should be escaped into the colon emoji format.
    /// - Returns: Text composition object
    static func plainText(
        text: String,
        emoji: Bool? = nil
    ) -> Self {
        .text(
            .plainText(text: text, emoji: emoji)
        )
    }
    
    /// An object containing some text
    /// - Parameters:
    ///   - text: The text for the block. This field accepts any of the standard text formatting markup when type is mrkdwn.
    ///   - verbatim: When set to false (as is default) URLs will be auto-converted into links, conversation names will be link-ified, and certain mentions will be automatically parsed. Using a value of true will skip any preprocessing of this nature, although you can still include manual parsing strings.
    /// - Returns: Text composition object
    static func markdown(
        text: String,
        verbatim: Bool? = nil
    ) -> Self {
        .text(
            .markdown(text: text, verbatim: verbatim)
        )
    }
    
    /// An object that defines a dialog that provides a confirmation step to any interactive element.
    /// This dialog will ask the user to confirm their action by offering a confirm and deny buttons.
    /// - Parameters:
    ///   - title: A plain_text-only text object that defines the dialog's title. Maximum length for this field is 100 characters.
    ///   - titleEmoji: Indicates whether emojis in a text field should be escaped into the colon emoji format.
    ///   - text: A text object that defines the explanatory text that appears in the confirm dialog. Maximum length for the text in this field is 300 characters.
    ///   - confirm: A plain_text-only text object to define the text of the button that confirms the action.
    ///   - confirmEmoji: Indicates whether emojis in a text field should be escaped into the colon emoji format. Maximum length for the text in this field is 30 characters.
    ///   - deny: A plain_text-only text object to define the text of the button that cancels the action. Maximum length for the text in this field is 30 characters.
    ///   - denyEmoji: Indicates whether emojis in a text field should be escaped into the colon emoji format.
    ///   - style: Defines the color scheme applied to the confirm button. If this field is not provided, the default value will be primary.
    /// - Returns: Confirmation Dialog composition object
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
    
    /// An object that represents a single selectable item in a select menu, multi-select menu, checkbox group, radio button group, or overflow menu.
    /// Can only support: Overflow, select, and multi-select menus
    /// - Parameters:
    ///   - text: A text object that defines the text shown in the option on the menu.
    ///   - textEmoji: Indicates whether emojis in a text field should be escaped into the colon emoji format.
    ///   - value: A unique string value that will be passed to your app when this option is chosen. Maximum length for this field is 75 characters.
    ///   - description: A plain_text only text object that defines a line of descriptive text shown below the text field beside the radio button.
    ///   - descriptionEmoji: Indicates whether emojis in a text field should be escaped into the colon emoji format. Maximum length for the text object within this field is 75 characters.
    ///   - url: A URL to load in the user's browser when the option is clicked. The url attribute is only available in overflow menus. Maximum length for this field is 3000 characters. If you're using url, you'll still receive an interaction payload and will need to send an acknowledgement response.
    /// - Returns: Option composition object
    public static func plainTextOption(
        text: String,
        emoji: Bool? = nil,
        value: String,
        description: String? = nil,
        descriptionEmoji: Bool? = nil,
        url: String? = nil
    ) -> Self {
        .option(
            Option(
                text: .plainText(text: text, emoji: emoji),
                value: value,
                description: description.flatMap { .plainText(text: $0, emoji: descriptionEmoji) },
                url: url
            )
        )
    }
    
    /// An object that represents a single selectable item in a select menu, multi-select menu, checkbox group, radio button group, or overflow menu.
    /// Can be used in: radio buttons and checkboxes can use mrkdwn text objects.
    /// - Parameters:
    ///   - text: A text object that defines the text shown in the option on the menu.
    ///   - verbatim: When set to false (as is default) URLs will be auto-converted into links, conversation names will be link-ified, and certain mentions will be automatically parsed. Using a value of true will skip any preprocessing of this nature, although you can still include manual parsing strings.
    ///   - value: A unique string value that will be passed to your app when this option is chosen. Maximum length for this field is 75 characters.
    ///   - description: Indicates whether emojis in a text field should be escaped into the colon emoji format. Maximum length for the text object within this field is 75 characters.
    ///   - descriptionEmoji: Indicates whether emojis in a text field should be escaped into the colon emoji format.
    ///   - url: A URL to load in the user's browser when the option is clicked. The url attribute is only available in overflow menus. Maximum length for this field is 3000 characters. If you're using url, you'll still receive an interaction payload and will need to send an acknowledgement response.
    /// - Returns: Option composition object
    public static func markdownOption(
        text: String,
        verbatim: Bool? = nil,
        value: String,
        description: String? = nil,
        descriptionEmoji: Bool? = nil,
        url: String? = nil
    ) -> Self {
        .option(
            Option(
                text: .markdown(text: text, verbatim: verbatim),
                value: value,
                description: description.flatMap { .plainText(text: $0, emoji: descriptionEmoji) },
                url: url
            )
        )
    }
    
    /// Provides a way to group options in a select menu or multi-select menu.
    /// - Parameters:
    ///   - text: A plain_text only text object that defines the label shown above this group of options. Maximum length for the text in this field is 75 characters.
    ///   - emoji: Indicates whether emojis in a text field should be escaped into the colon emoji format.
    ///   - options: An array of option objects that belong to this specific group. Maximum of 100 items.
    /// - Returns: Option Group composition object
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
    
    /// Determines when a plain-text input element will return a block_actions interaction payload.
    /// - Parameter trigger_actions_on: An array of interaction types that you would like to receive a block_actions payload for.
    /// - Returns: Dispatch Action Configuration composition object
    public static func dispatchActionConfiguration(
        trigger_actions_on: [DispatchActionConfiguration.ActionTrigger]? = nil
    ) -> Self {
        .dispatchActionConfiguration(
            DispatchActionConfiguration(
                trigger_actions_on: trigger_actions_on
            )
        )
    }
    
    /// Provides a way to filter the list of options in a conversations select menu or conversations multi-select menu.
    ///
    /// Please note that while none of the fields above are individually required, you must supply at least one of these fields.
    /// - Parameters:
    ///   - include: Indicates which type of conversations should be included in the list. When this field is provided, any conversations that do not match will be excluded. You should provide an array of strings from the following options: im, mpim, private, and public. The array cannot be empty.
    ///   - exclude_external_shared_channels: Indicates whether to exclude external shared channels from conversation lists. Defaults to false.
    ///   - exclude_bot_users: Indicates whether to exclude bot users from conversation lists. Defaults to false.
    /// - Returns: Filter For Conversation List composition object
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
