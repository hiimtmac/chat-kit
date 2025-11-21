import Foundation

public enum BlockElement: Encodable {
    case button(Button)
    case checkboxGroup(CheckboxGroup)
    case datePicker(DatePicker)
    case image(Image)
    case multiSelectMenu(MultiSelectMenu)
    case overflowMenu(OverflowMenu)
    case plainTextInput(PlainTextInput)
    case radioButtonGroup(RadioButtonGroup)
    case selectMenu(SelectMenu)
    case timePicker(TimePicker)
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .button(let object): try container.encode(object)
        case .checkboxGroup(let object): try container.encode(object)
        case .datePicker(let object): try container.encode(object)
        case .image(let object): try container.encode(object)
        case .multiSelectMenu(let object): try container.encode(object)
        case .overflowMenu(let object): try container.encode(object)
        case .plainTextInput(let object): try container.encode(object)
        case .radioButtonGroup(let object): try container.encode(object)
        case .selectMenu(let object): try container.encode(object)
        case .timePicker(let object): try container.encode(object)
        }
    }
    
    /// Works with block types: Section Actions
    ///
    /// An interactive component that inserts a button. The button can be a trigger for anything from opening a simple link to starting a complex workflow.
    /// - Parameters:
    ///   - text: A text object that defines the button's text. Can only be of type: plain_text. Maximum length for the text in this field is 75 characters.
    ///   - emoji: Indicates whether emojis in a text field should be escaped into the colon emoji format.
    ///   - action_id: An identifier for this action. You can use this when you receive an interaction payload to identify the source of the action. Should be unique among all other action_ids in the containing block. Maximum length for this field is 255 characters.
    ///   - url: A URL to load in the user's browser when the button is clicked. Maximum length for this field is 3000 characters. If you're using url, you'll still receive an interaction payload and will need to send an acknowledgement response.
    ///   - value: The value to send along with the interaction payload. Maximum length for this field is 2000 characters.
    ///   - style: Decorates buttons with alternative visual color schemes. Use this option with restraint. If you don't include this field, the default button style will be used.
    ///   - confirm: A confirm object that defines an optional confirmation dialog after the button is clicked.
    /// - Returns: Button block element
    public static func button(
        text: String,
        emoji: Bool? = nil,
        action_id: String,
        url: String? = nil,
        value: String? = nil,
        style: Button.Style? = nil,
        confirm: CompositionObject.ConfirmationDialog? = nil
    ) -> Self {
        .button(
            Button(
                text: .plainText(text: text, emoji: emoji),
                action_id: action_id,
                url: url,
                value: value,
                style: style,
                confirm: confirm
            )
        )
    }
    
    /// A checkbox group that allows a user to choose multiple items from a list of possible options.
    ///
    /// Checkboxes are only supported in the following app surfaces: Home tabs, Modals, Messages
    /// Works with block types: Section, Actions, Input
    /// - Parameters:
    ///   - action_id: An identifier for this action. You can use this when you receive an interaction payload to identify the source of the action. Should be unique among all other action_ids in the containing block. Maximum length for this field is 255 characters.
    ///   - options: An array of option objects. A maximum of 10 options are allowed.
    ///   - initial_options: An array of option objects that exactly matches one or more of the options within options. These options will be selected when the checkbox group initially loads.
    ///   - confirm: A confirm object that defines an optional confirmation dialog after the button is clicked.
    /// - Returns: Checkbox Group block element
    public static func checkboxGroup(
        action_id: String,
        options: [CompositionObject.Option],
        initial_options: [CompositionObject.Option]? = nil,
        confirm: CompositionObject.ConfirmationDialog? = nil
    ) -> Self {
        .checkboxGroup(
            CheckboxGroup(
                action_id: action_id,
                options: options,
                initial_options: initial_options,
                confirm: confirm
            )
        )
    }
    
    /// An element which lets users easily select a date from a calendar style UI.
    ///
    /// Works with block types: Section, Actions, Input
    /// - Parameters:
    ///   - action_id: An identifier for this action. You can use this when you receive an interaction payload to identify the source of the action. Should be unique among all other action_ids in the containing block. Maximum length for this field is 255 characters.
    ///   - placeholder: A plain_text only text object that defines the placeholder text shown on the datepicker. Maximum length for the text in this field is 150 characters.
    ///   - placeholderEmoji: Indicates whether emojis in a text field should be escaped into the colon emoji format.
    ///   - initial_date: The initial date that is selected when the element is loaded.
    ///   - confirm: A confirm object that defines an optional confirmation dialog after the button is clicked.
    /// - Returns: Date Picker block element
    public static func datePicker(
        action_id: String,
        placeholder: String? = nil,
        placeholderEmoji: Bool? = nil,
        initial_date: Date? = nil,
        confirm: CompositionObject.ConfirmationDialog? = nil
    ) -> Self {
        .datePicker(
            DatePicker(
                action_id: action_id,
                placeholder: placeholder.flatMap { .plainText(text: $0, emoji: placeholderEmoji) },
                initial_date: initial_date,
                confirm: confirm
            )
        )
    }
    
    /// An element to insert an image as part of a larger block of content.
    ///
    /// Works with block types: Section Context
    /// If you want a block with only an image in it, you're looking for the image block.
    /// - Parameters:
    ///   - image_url: The URL of the image to be displayed.
    ///   - alt_text: A plain-text summary of the image. This should not contain any markup.
    /// - Returns: Image block element
    public static func image(
        image_url: String,
        alt_text: String
    ) -> Self {
        .image(
            Image(
                image_url: image_url,
                alt_text: alt_text
            )
        )
    }
    
    /// This is like a cross between a button and a select menu - when a user clicks on this overflow button, they will be presented with a list of options to choose from.
    /// Unlike the select menu, there is no typeahead field, and the button always appears with an ellipsis ("…") rather than customisable text.
    ///
    /// Works with block types: Section, Actions
    /// As such, it is usually used if you want a more compact layout than a select menu, or to supply a list of less visually important actions after a row of buttons.
    /// You can also specify simple URL links as overflow menu options, instead of actions.
    /// To use interactive components like this, you will need to make some changes to prepare your app. Read our guide to enabling interactivity.
    /// - Parameters:
    ///   - action_id: An identifier for this action. You can use this when you receive an interaction payload to identify the source of the action. Should be unique among all other action_ids in the containing block. Maximum length for this field is 255 characters.
    ///   - options: An array of option objects to display in the menu. Maximum number of options is 5, minimum is 2.
    ///   - confirm: A confirm object that defines an optional confirmation dialog after the button is clicked.
    /// - Returns: Overflow Menu block element
    public static func overflowMenu(
        action_id: String,
        options: [CompositionObject.Option],
        confirm: CompositionObject.ConfirmationDialog? = nil
    ) -> Self {
        .overflowMenu(
            OverflowMenu(
                action_id: action_id,
                options: options,
                confirm: confirm
            )
        )
    }
    
    /// A plain-text input, similar to the HTML <input> tag, creates a field where a user can enter freeform data. It can appear as a single-line field or a larger textarea using the multiline flag.
    ///
    /// Works with block types: Input
    /// To use interactive components like this, you will need to make some changes to prepare your app. Read our guide to enabling interactivity.
    /// Plain-text input elements are supported in the following app surfaces: Home tabs, Messages, Modals
    /// To use plain-text input elements in modals, you will need to make some changes to prepare your app. Read about preparing your app for modals.
    /// - Parameters:
    ///   - action_id: An identifier for this action. You can use this when you receive an interaction payload to identify the source of the action. Should be unique among all other action_ids in the containing block. Maximum length for this field is 255 characters.
    ///   - placeholder: A plain_text only text object that defines the placeholder text shown in the plain-text input. Maximum length for the text in this field is 150 characters.
    ///   - placeholderEmoji: Indicates whether emojis in a text field should be escaped into the colon emoji format.
    ///   - initial_value: The initial value in the plain-text input when it is loaded.
    ///   - multiline: Indicates whether the input will be a single line (false) or a larger textarea (true). Defaults to false.
    ///   - min_length: The minimum length of input that the user must provide. If the user provides less, they will receive an error. Maximum value is 3000.
    ///   - max_length: The maximum length of input that the user can provide. If the user provides more, they will receive an error.
    ///   - dispatch_action_config: A dispatch configuration object that determines when during text input the element returns a block_actions payload.
    /// - Returns: Plain Text Input block element
    public static func plainTextInput(
        action_id: String,
        placeholder: String,
        placeholderEmoji: Bool? = nil,
        initial_value: String? = nil,
        multiline: Bool? = nil,
        min_length: Int? = nil,
        max_length: Int? = nil,
        dispatch_action_config: CompositionObject.DispatchActionConfiguration? = nil
    ) -> Self {
        .plainTextInput(
            PlainTextInput(
                action_id: action_id,
                placeholder: .plainText(text: placeholder, emoji: placeholderEmoji),
                initial_value: initial_value,
                multiline: multiline,
                min_length: min_length,
                max_length: max_length,
                dispatch_action_config: dispatch_action_config
            )
        )
    }
    
    /// A radio button group that allows a user to choose one item from a list of possible options.
    ///
    /// Works with block types: Section, Actions, Input
    /// Radio buttons are supported in the following app surfaces: Home tabs, Modals, Messages
    /// To use interactive components like this, you will need to make some changes to prepare your app. Read our guide to enabling interactivity.
    /// - Parameters:
    ///   - action_id: An identifier for this action. You can use this when you receive an interaction payload to identify the source of the action. Should be unique among all other action_ids in the containing block. Maximum length for this field is 255 characters.
    ///   - options: An array of option objects. A maximum of 10 options are allowed.
    ///   - initial_option: An option object that exactly matches one of the options within options. This option will be selected when the radio button group initially loads.
    ///   - confirm: A confirm object that defines an optional confirmation dialog after the button is clicked.
    /// - Returns: Radio Button Group block element
    public static func radioButtonGroup(
        action_id: String,
        options: [CompositionObject.Option],
        initial_option: CompositionObject.Option? = nil,
        confirm: CompositionObject.ConfirmationDialog? = nil
    ) -> Self {
        .radioButtonGroup(
            RadioButtonGroup(
                action_id: action_id,
                options: options,
                initial_option: initial_option,
                confirm: confirm
            )
        )
    }
    
    /// An element which allows selection of a time of day.
    ///
    /// Works with block types: Section, Actions, Input
    ///
    /// Beta feature
    /// This is an in-development app feature that must be enabled in the Beta Features section of your app config before use.
    /// On desktop clients, this time picker will take the form of a dropdown list with free-text entry for precise choices. On mobile clients, the time picker will use native time picker UIs.
    ///
    /// To use interactive components like this, you will need to make some changes to prepare your app. Read our guide to enabling interactivity.
    /// - Parameters:
    ///   - action_id: An identifier for this action. You can use this when you receive an interaction payload to identify the source of the action. Should be unique among all other action_ids in the containing block. Maximum length for this field is 255 characters.
    ///   - placeholder: A plain_text only text object that defines the placeholder text shown on the timepicker. Maximum length for the text in this field is 150 characters.
    ///   - placeholderEmoji: Indicates whether emojis in a text field should be escaped into the colon emoji format.
    ///   - initial_time: The initial time that is selected when the element is loaded. This should be in the format HH:mm, where HH is the 24-hour format of an hour (00 to 23) and mm is minutes with leading zeros (00 to 59), for example 22:25 for 10:25pm.
    ///   - confirm: A confirm object that defines an optional confirmation dialog after the button is clicked.
    /// - Returns: Time Picker block element
    public static func timePicker(
        action_id: String,
        placeholder: String?,
        placeholderEmoji: Bool? = nil,
        initial_time: String? = nil,
        confirm: CompositionObject.ConfirmationDialog? = nil
    ) -> Self {
        .timePicker(
            TimePicker(
                action_id: action_id,
                placeholder: placeholder.flatMap { .plainText(text: $0, emoji: placeholderEmoji) },
                initial_time: initial_time,
                confirm: confirm
            )
        )
    }
}
