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

extension BlockElement {
    /// Works with block types: Section Actions
    ///
    /// An interactive component that inserts a button. The button can be a trigger for anything from opening a simple link to starting a complex workflow.
    /// To use interactive components, you will need to make some changes to prepare your app. Read our guide to enabling interactivity.
    public struct Button: Encodable {
        /// The type of element. In this case type is always button.
        public let type: String
        /// A text object that defines the button's text. Can only be of type: plain_text.
        /// Maximum length for the text in this field is 75 characters.
        public let text: CompositionObject.Text
        /// An identifier for this action.
        /// You can use this when you receive an interaction payload to identify the source of the action.
        /// Should be unique among all other action_ids in the containing block.
        /// Maximum length for this field is 255 characters.
        public let action_id: String
        /// A URL to load in the user's browser when the button is clicked.
        /// Maximum length for this field is 3000 characters.
        /// If you're using url, you'll still receive an interaction payload and will need to send an acknowledgement response.
        public let url: String?
        /// The value to send along with the interaction payload.
        /// Maximum length for this field is 2000 characters.
        public let value: String?
        /// Decorates buttons with alternative visual color schemes. Use this option with restraint.
        /// If you don't include this field, the default button style will be used.
        public let style: Style?
        /// A confirm object that defines an optional confirmation dialog after the button is clicked.
        public let confirm: CompositionObject.ConfirmationDialog?
        
        init(
            text: CompositionObject.Text,
            action_id: String,
            url: String? = nil,
            value: String? = nil,
            style: Style? = nil,
            confirm: CompositionObject.ConfirmationDialog? = nil
        ) {
            self.type = "button"
            self.text = text
            self.action_id = action_id
            self.url = url
            self.value = value
            self.style = style
            self.confirm = confirm
        }
        
        public enum Style: String, Encodable {
            /// primary gives buttons a green outline and text, ideal for affirmation or confirmation actions. primary should only be used for one button within a set.
            case primary
            /// danger gives buttons a red outline and text, and should be used when the action is destructive.
            /// Use danger even more sparingly than primary.
            case danger
        }
    }
}

extension BlockElement {
    /// Works with block types: Section Actions Input
    ///
    /// A checkbox group that allows a user to choose multiple items from a list of possible options.
    /// Checkboxes are only supported in the following app surfaces: Home tabs, Modals, Messages
    /// To use interactive components like this, you will need to make some changes to prepare your app. Read our guide to enabling interactivity.
    public struct CheckboxGroup: Encodable {
        /// The type of element. In this case type is always checkboxes.
        public let type: String
        /// An identifier for the action triggered when the checkbox group is changed.
        /// You can use this when you receive an interaction payload to identify the source of the action.
        /// Should be unique among all other action_ids in the containing block.
        /// Maximum length for this field is 255 characters.
        public let action_id: String
        /// An array of option objects. A maximum of 10 options are allowed.
        public let options: [CompositionObject.Option]
        /// An array of option objects that exactly matches one or more of the options within options. These options will be selected when the checkbox group initially loads.
        public let initial_options: [CompositionObject.Option]?
        /// A confirm object that defines an optional confirmation dialog that appears after clicking one of the checkboxes in this element.
        public let confirm: CompositionObject.ConfirmationDialog?
        
        init(
            action_id: String,
            options: [CompositionObject.Option],
            initial_options: [CompositionObject.Option]? = nil,
            confirm: CompositionObject.ConfirmationDialog? = nil
        ) {
            self.type = "checkboxes"
            self.action_id = action_id
            self.options = options
            self.initial_options = initial_options
            self.confirm = confirm
        }
    }
}

extension BlockElement {
    /// Works with block types: Section Actions Input
    ///
    /// An element which lets users easily select a date from a calendar style UI.
    /// To use interactive components like this, you will need to make some changes to prepare your app. Read our guide to enabling interactivity.
    public struct DatePicker: Encodable {
        /// The type of element. In this case type is always datepicker.
        public let type: String
        /// An identifier for the action triggered when a menu option is selected.
        /// You can use this when you receive an interaction payload to identify the source of the action.
        /// Should be unique among all other action_ids in the containing block.
        /// Maximum length for this field is 255 characters.
        public let action_id: String
        /// A plain_text only text object that defines the placeholder text shown on the datepicker. Maximum length for the text in this field is 150 characters.
        public let placeholder: CompositionObject.Text?
        /// The initial date that is selected when the element is loaded.
        /// This should be in the format YYYY-MM-DD.
        public let initial_date: String?
        /// A confirm object that defines an optional confirmation dialog that appears after a date is selected.
        public let confirm: CompositionObject.ConfirmationDialog?
        
        init(
            action_id: String,
            placeholder: CompositionObject.Text? = nil,
            initial_date: Date? = nil,
            confirm: CompositionObject.ConfirmationDialog? = nil
        ) {
            self.type = "datepicker"
            self.action_id = action_id
            self.placeholder = placeholder
            self.initial_date = initial_date.flatMap { Self.formatter.string(from: $0) }
            self.confirm = confirm
        }
        
        static let formatter: DateFormatter = {
            let f = DateFormatter()
            f.dateFormat = "yyyy-MM-dd"
            return f
        }()
    }
}

extension BlockElement {
    /// Works with block types: Section Context
    ///
    /// An element to insert an image as part of a larger block of content.
    /// If you want a block with only an image in it, you're looking for the image block.
    public struct Image: Encodable {
        /// The type of element. In this case type is always image.
        public let type: String
        /// The URL of the image to be displayed.
        public let image_url: String
        /// A plain-text summary of the image. This should not contain any markup.
        public let alt_text: String
        
        init(
            image_url: String,
            alt_text: String
        ) {
            self.type = "image"
            self.image_url = image_url
            self.alt_text = alt_text
        }
    }
}

extension BlockElement {
    /// A multi-select menu allows a user to select multiple items from a list of options. Just like regular select menus, multi-select menus also include type-ahead functionality, where a user can type a part or all of an option string to filter the list.
    ///
    /// To use interactive components, you will need to make some changes to prepare your app. Read our guide to enabling interactivity.
    public enum MultiSelectMenu: Encodable {
        case staticList(StaticListOptions)
        case externalDataSourceList(ExternalDataSourceListOptions)
        case userList(UserListOptions)
        case conversationList(ConversationListOptions)
        case publicChannelList(PublicChannelListOptions)
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .staticList(let options): try container.encode(options)
            case .externalDataSourceList(let options): try container.encode(options)
            case .userList(let options): try container.encode(options)
            case .conversationList(let options): try container.encode(options)
            case .publicChannelList(let options): try container.encode(options)
            }
        }

        /// This is the simplest form of select menu, with a static list of options passed in when defining the element.
        ///
        /// Works with block types: Section, Input
        public struct StaticListOptions: Encodable {
            /// The type of element. In this case type is always multi_static_select.
            public let type: String
            /// A plain_text only text object that defines the placeholder text shown on the menu.
            /// Maximum length for the text in this field is 150 characters.
            public let placeholder: CompositionObject.Text
            /// An identifier for the action triggered when a menu option is selected.
            /// You can use this when you receive an interaction payload to identify the source of the action.
            /// Should be unique among all other action_ids in the containing block.
            /// Maximum length for this field is 255 characters.
            public let action_id: String
            /// An array of option objects. Maximum number of options is 100.
            /// If option_groups is specified, this field should not be.
            public let options: [CompositionObject.Option]?
            /// An array of option group objects. Maximum number of option groups is 100.
            /// If options is specified, this field should not be.
            public let option_groups: [CompositionObject.OptionGroup]?
            /// An array of option objects that exactly match one or more of the options within options or option_groups.
            /// These options will be selected when the menu initially loads.
            public let initial_options: [CompositionObject.Option]?
            /// A confirm object that defines an optional confirmation dialog that appears before the multi-select choices are submitted.
            public let confirm: CompositionObject.ConfirmationDialog?
            /// Specifies the maximum number of items that can be selected in the menu.
            /// Minimum number is 1.
            public let max_selected_items: Int?
            
            init(
                action_id: String,
                placeholder: CompositionObject.Text,
                options: [CompositionObject.Option]? = nil,
                option_groups: [CompositionObject.OptionGroup]? = nil,
                initial_options: [CompositionObject.Option]? = nil,
                confirm: CompositionObject.ConfirmationDialog? = nil,
                max_selected_items: Int? = nil
            ) {
                self.type = "multi_static_select"
                self.placeholder = placeholder
                self.action_id = action_id
                self.options = options
                self.option_groups = option_groups
                self.initial_options = initial_options
                self.confirm = confirm
                self.max_selected_items = max_selected_items
            }
            
            public static func withOptions(
                action_id: String,
                placeholder: CompositionObject.Text,
                options: [CompositionObject.Option],
                initial_options: [CompositionObject.Option]? = nil,
                confirm: CompositionObject.ConfirmationDialog? = nil,
                max_selected_items: Int? = nil
            ) -> Self {
                self.init(
                    action_id: action_id,
                    placeholder: placeholder,
                    options: options,
                    option_groups: nil,
                    initial_options: initial_options,
                    confirm: confirm,
                    max_selected_items: max_selected_items
                )
            }
            
            public static func withOptionGroups(
                action_id: String,
                placeholder: CompositionObject.Text,
                option_groups: [CompositionObject.OptionGroup],
                initial_options: [CompositionObject.Option]? = nil,
                confirm: CompositionObject.ConfirmationDialog? = nil,
                max_selected_items: Int? = nil
            ) -> Self {
                self.init(
                    action_id: action_id,
                    placeholder: placeholder,
                    options: nil,
                    option_groups: option_groups,
                    initial_options: initial_options,
                    confirm: confirm,
                    max_selected_items: max_selected_items
                )
            }
        }
        
        /// This menu will load its options from an external data source, allowing for a dynamic list of options.
        /// Setup
        /// To use this menu type, you'll need to configure your app first:
        /// - Goto your app's settings page and choose the Interactive Components feature menu.
        /// - Add a URL to the Options Load URL under Select Menus.
        /// - Save changes.
        /// Each time a menu of this type is opened or the user starts typing in the typeahead field, we'll send a request to your specified URL.
        /// Your app should return an HTTP 200 OK response, along with an application/json post body with an object containing either an options array, or an option_groups array. Here's an example response:
        /// ```json
        /// {
        ///   "options": [
        ///     {
        ///       "text": {
        ///         "type": "plain_text",
        ///         "text": "*this is plain_text text*"
        ///       },
        ///       "value": "value-0"
        ///     },
        ///     {
        ///       "text": {
        ///         "type": "plain_text",
        ///         "text": "*this is plain_text text*"
        ///       },
        ///       "value": "value-1"
        ///     },
        ///     {
        ///       "text": {
        ///         "type": "plain_text",
        ///         "text": "*this is plain_text text*"
        ///       },
        ///       "value": "value-2"
        ///     }
        ///   ]
        /// }
        /// ```
        ///
        /// Works with block types: Section, Input
        public struct ExternalDataSourceListOptions: Encodable {
            /// The type of element. In this case type is always multi_static_select.
            public let type: String
            /// A plain_text only text object that defines the placeholder text shown on the menu.
            /// Maximum length for the text in this field is 150 characters.
            public let placeholder: CompositionObject.Text
            /// An identifier for the action triggered when a menu option is selected.
            /// You can use this when you receive an interaction payload to identify the source of the action.
            /// Should be unique among all other action_ids in the containing block.
            /// Maximum length for this field is 255 characters.
            public let action_id: String
            /// When the typeahead field is used, a request will be sent on every character change.
            /// If you prefer fewer requests or more fully ideated queries, use the min_query_length attribute to tell Slack the fewest number of typed characters required before dispatch.
            /// The default value is 3.
            public let min_query_length: Int?
            /// An array of option objects that exactly match one or more of the options within options or option_groups.
            /// These options will be selected when the menu initially loads.
            public let initial_options: [CompositionObject.Option]?
            /// A confirm object that defines an optional confirmation dialog that appears before the multi-select choices are submitted.
            public let confirm: CompositionObject.ConfirmationDialog?
            /// Specifies the maximum number of items that can be selected in the menu.
            /// Minimum number is 1.
            public let max_selected_items: Int?
            
            public init(
                action_id: String,
                placeholder: CompositionObject.Text,
                min_query_length: Int? = nil,
                initial_options: [CompositionObject.Option]? = nil,
                confirm: CompositionObject.ConfirmationDialog? = nil,
                max_selected_items: Int? = nil
            ) {
                self.type = "multi_external_select"
                self.placeholder = placeholder
                self.action_id = action_id
                self.min_query_length = min_query_length
                self.initial_options = initial_options
                self.confirm = confirm
                self.max_selected_items = max_selected_items
            }
        }
        
        /// This multi-select menu will populate its options with a list of Slack users visible to the current user in the active workspace.
        ///
        /// Works with block types: Section, Input
        public struct UserListOptions: Encodable {
            /// The type of element. In this case type is always multi_static_select.
            public let type: String
            /// A plain_text only text object that defines the placeholder text shown on the menu.
            /// Maximum length for the text in this field is 150 characters.
            public let placeholder: CompositionObject.Text
            /// An identifier for the action triggered when a menu option is selected.
            /// You can use this when you receive an interaction payload to identify the source of the action.
            /// Should be unique among all other action_ids in the containing block.
            /// Maximum length for this field is 255 characters.
            public let action_id: String
            /// An array of user IDs of any valid users to be pre-selected when the menu loads.
            public let initial_users: [String]?
            /// A confirm object that defines an optional confirmation dialog that appears before the multi-select choices are submitted.
            public let confirm: CompositionObject.ConfirmationDialog?
            /// Specifies the maximum number of items that can be selected in the menu.
            /// Minimum number is 1.
            public let max_selected_items: Int?
            
            public init(
                action_id: String,
                placeholder: CompositionObject.Text,
                initial_users: [String]? = nil,
                confirm: CompositionObject.ConfirmationDialog? = nil,
                max_selected_items: Int? = nil
            ) {
                self.type = "multi_users_select"
                self.placeholder = placeholder
                self.action_id = action_id
                self.initial_users = initial_users
                self.confirm = confirm
                self.max_selected_items = max_selected_items
            }
        }
        
        /// This multi-select menu will populate its options with a list of public and private channels, DMs, and MPIMs visible to the current user in the active workspace.
        ///
        /// Works with block types: Section, Input
        public struct ConversationListOptions: Encodable {
            /// The type of element. In this case type is always multi_static_select.
            public let type: String
            /// A plain_text only text object that defines the placeholder text shown on the menu.
            /// Maximum length for the text in this field is 150 characters.
            public let placeholder: CompositionObject.Text
            /// An identifier for the action triggered when a menu option is selected.
            /// You can use this when you receive an interaction payload to identify the source of the action.
            /// Should be unique among all other action_ids in the containing block.
            /// Maximum length for this field is 255 characters.
            public let action_id: String
            /// An array of one or more IDs of any valid conversations to be pre-selected when the menu loads.
            /// If default_to_current_conversation is also supplied, initial_conversations will be ignored.
            public let initial_conversations: [String]?
            /// Pre-populates the select menu with the conversation that the user was viewing when they opened the modal, if available.
            /// Default is false.
            public let default_to_current_conversation: Bool?
            /// A confirm object that defines an optional confirmation dialog that appears before the multi-select choices are submitted.
            public let confirm: CompositionObject.ConfirmationDialog?
            /// Specifies the maximum number of items that can be selected in the menu.
            /// Minimum number is 1.
            public let max_selected_items: Int?
            /// A filter object that reduces the list of available conversations using the specified criteria.
            public let filter: CompositionObject.FilterForConversationList?
            
            public init(
                action_id: String,
                placeholder: CompositionObject.Text,
                initial_conversations: [String]? = nil,
                default_to_current_conversation: Bool? = nil,
                initial_options: [CompositionObject.Option]? = nil,
                confirm: CompositionObject.ConfirmationDialog? = nil,
                max_selected_items: Int? = nil,
                filter: CompositionObject.FilterForConversationList? = nil
            ) {
                self.type = "multi_conversations_select"
                self.placeholder = placeholder
                self.action_id = action_id
                self.initial_conversations = initial_conversations
                self.default_to_current_conversation = default_to_current_conversation
                self.confirm = confirm
                self.max_selected_items = max_selected_items
                self.filter = filter
            }
        }
        
        /// This multi-select menu will populate its options with a list of public channels visible to the current user in the active workspace.
        ///
        /// Works with block types: Section, Input
        public struct PublicChannelListOptions: Encodable {
            /// The type of element. In this case type is always multi_static_select.
            public let type: String
            /// A plain_text only text object that defines the placeholder text shown on the menu.
            /// Maximum length for the text in this field is 150 characters.
            public let placeholder: CompositionObject.Text
            /// An identifier for the action triggered when a menu option is selected.
            /// You can use this when you receive an interaction payload to identify the source of the action.
            /// Should be unique among all other action_ids in the containing block.
            /// Maximum length for this field is 255 characters.
            public let action_id: String
            /// An array of one or more IDs of any valid public channel to be pre-selected when the menu loads.
            public let initial_channels: [String]?
            /// A confirm object that defines an optional confirmation dialog that appears before the multi-select choices are submitted.
            public let confirm: CompositionObject.ConfirmationDialog?
            /// Specifies the maximum number of items that can be selected in the menu.
            /// Minimum number is 1.
            public let max_selected_items: Int?
            
            public init(
                action_id: String,
                placeholder: CompositionObject.Text,
                initial_channels: [String]? = nil,
                confirm: CompositionObject.ConfirmationDialog? = nil,
                max_selected_items: Int? = nil
            ) {
                self.type = "multi_channels_select"
                self.placeholder = placeholder
                self.action_id = action_id
                self.initial_channels = initial_channels
                self.confirm = confirm
                self.max_selected_items = max_selected_items
            }
        }
    }
}

extension BlockElement {
    /// This is like a cross between a button and a select menu - when a user clicks on this overflow button, they will be presented with a list of options to choose from.
    /// Unlike the select menu, there is no typeahead field, and the button always appears with an ellipsis ("…") rather than customisable text.
    ///
    /// Works with block types: Section, Actions
    /// As such, it is usually used if you want a more compact layout than a select menu, or to supply a list of less visually important actions after a row of buttons.
    /// You can also specify simple URL links as overflow menu options, instead of actions.
    /// To use interactive components like this, you will need to make some changes to prepare your app. Read our guide to enabling interactivity.
    public struct OverflowMenu: Encodable {
        /// The type of element. In this case type is always overflow.
        public let type: String
        /// An identifier for the action triggered when a menu option is selected.
        /// You can use this when you receive an interaction payload to identify the source of the action.
        /// Should be unique among all other action_ids in the containing block.
        /// Maximum length for this field is 255 characters.
        public let action_id: String
        /// An array of option objects to display in the menu. Maximum number of options is 5, minimum is 2.
        public let options: [CompositionObject.Option]
        /// A confirm object that defines an optional confirmation dialog that appears after a menu item is selected.
        public let confirm: CompositionObject.ConfirmationDialog?
        
        public init(
            action_id: String,
            options: [CompositionObject.Option],
            confirm: CompositionObject.ConfirmationDialog? = nil
        ) {
            self.type = "overflow"
            self.action_id = action_id
            self.options = options
            self.confirm = confirm
        }
    }
}

extension BlockElement {
    /// A plain-text input, similar to the HTML <input> tag, creates a field where a user can enter freeform data. It can appear as a single-line field or a larger textarea using the multiline flag.
    ///
    /// Works with block types: Input
    /// To use interactive components like this, you will need to make some changes to prepare your app. Read our guide to enabling interactivity.
    /// Plain-text input elements are supported in the following app surfaces: Home tabs, Messages, Modals
    /// To use plain-text input elements in modals, you will need to make some changes to prepare your app. Read about preparing your app for modals.
    public struct PlainTextInput: Encodable {
        /// The type of element. In this case type is always plain_text_input.
        public let type: String
        /// An identifier for the input value when the parent modal is submitted.
        /// You can use this when you receive a view_submission payload to identify the value of the input element.
        /// Should be unique among all other action_ids in the containing block.
        /// Maximum length for this field is 255 characters.
        public let action_id: String
        /// A plain_text only text object that defines the placeholder text shown in the plain-text input.
        /// Maximum length for the text in this field is 150 characters.
        public let placeholder: CompositionObject.Text
        /// The initial value in the plain-text input when it is loaded.
        public let initial_value: String?
        /// Indicates whether the input will be a single line (false) or a larger textarea (true).
        /// Defaults to false.
        public let multiline: Bool?
        /// The minimum length of input that the user must provide.
        /// If the user provides less, they will receive an error.
        /// Maximum value is 3000.
        public let min_length: Int?
        /// The maximum length of input that the user can provide.
        /// If the user provides more, they will receive an error.
        public let max_length: Int?
        /// A dispatch configuration object that determines when during text input the element returns a block_actions payload.
        public let dispatch_action_config: CompositionObject.DispatchActionConfiguration?
        
        init(
            action_id: String,
            placeholder: CompositionObject.Text,
            initial_value: String? = nil,
            multiline: Bool? = nil,
            min_length: Int? = nil,
            max_length: Int? = nil,
            dispatch_action_config: CompositionObject.DispatchActionConfiguration? = nil
        ) {
            self.type = "plain_text_input"
            self.action_id = action_id
            self.placeholder = placeholder
            self.initial_value = initial_value
            self.multiline = multiline
            self.min_length = min_length
            self.max_length = max_length
            self.dispatch_action_config = dispatch_action_config
        }
    }
}

extension BlockElement {
    /// A radio button group that allows a user to choose one item from a list of possible options.
    ///
    /// Works with block types: Section, Actions, Input
    /// Radio buttons are supported in the following app surfaces: Home tabs, Modals, Messages
    /// To use interactive components like this, you will need to make some changes to prepare your app. Read our guide to enabling interactivity.
    public struct RadioButtonGroup: Encodable {
        /// The type of element. In this case type is always radio_buttons.
        public let type: String
        /// An identifier for the action triggered when the radio button group is changed.
        /// You can use this when you receive an interaction payload to identify the source of the action.
        /// Should be unique among all other action_ids in the containing block.
        /// Maximum length for this field is 255 characters.
        public let action_id: String
        /// An array of option objects. A maximum of 10 options are allowed.
        public let options: [CompositionObject.Option]
        /// An option object that exactly matches one of the options within options.
        /// This option will be selected when the radio button group initially loads.
        public let initial_option: CompositionObject.Option?
        /// A confirm object that defines an optional confirmation dialog that appears after clicking one of the radio buttons in this element.
        public let confirm: CompositionObject.ConfirmationDialog?
        
        init(
            action_id: String,
            options: [CompositionObject.Option],
            initial_option: CompositionObject.Option? = nil,
            confirm: CompositionObject.ConfirmationDialog? = nil
        ) {
            self.type = "radio_buttons"
            self.action_id = action_id
            self.options = options
            self.initial_option = initial_option
            self.confirm = confirm
        }
    }
}

extension BlockElement {
    /// A select menu, just as with a standard HTML <select> tag, creates a drop down menu with a list of options for a user to choose.
    /// The select menu also includes type-ahead functionality, where a user can type a part or all of an option string to filter the list.
    ///
    /// To use interactive components, you will need to make some changes to prepare your app. Read our guide to enabling interactivity.
    public enum SelectMenu: Encodable {
        case staticList(StaticListOptions)
        case externalDataSourceList(ExternalDataSourceListOptions)
        case userList(UserListOptions)
        case conversationList(ConversationListOptions)
        case publicChannelList(PublicChannelListOptions)
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .staticList(let options): try container.encode(options)
            case .externalDataSourceList(let options): try container.encode(options)
            case .userList(let options): try container.encode(options)
            case .conversationList(let options): try container.encode(options)
            case .publicChannelList(let options): try container.encode(options)
            }
        }

        /// This is the simplest form of select menu, with a static list of options passed in when defining the element.
        ///
        /// Works with block types: Section, Actions, Input
        public struct StaticListOptions: Encodable {
            /// The type of element. In this case type is always multi_static_select.
            public let type: String
            /// A plain_text only text object that defines the placeholder text shown on the menu.
            /// Maximum length for the text in this field is 150 characters.
            public let placeholder: CompositionObject.Text
            /// An identifier for the action triggered when a menu option is selected.
            /// You can use this when you receive an interaction payload to identify the source of the action.
            /// Should be unique among all other action_ids in the containing block.
            /// Maximum length for this field is 255 characters.
            public let action_id: String
            /// An array of option objects. Maximum number of options is 100.
            /// If option_groups is specified, this field should not be.
            public let options: [CompositionObject.Option]?
            /// An array of option group objects. Maximum number of option groups is 100.
            /// If options is specified, this field should not be.
            public let option_groups: [CompositionObject.OptionGroup]?
            /// A single option that exactly matches one of the options within options or option_groups.
            /// This option will be selected when the menu initially loads.
            public let initial_option: CompositionObject.Option?
            /// A confirm object that defines an optional confirmation dialog that appears before the multi-select choices are submitted.
            public let confirm: CompositionObject.ConfirmationDialog?
            
            init(
                action_id: String,
                placeholder: CompositionObject.Text,
                options: [CompositionObject.Option]? = nil,
                option_groups: [CompositionObject.OptionGroup]? = nil,
                initial_option: CompositionObject.Option? = nil,
                confirm: CompositionObject.ConfirmationDialog? = nil
            ) {
                self.type = "static_select"
                self.placeholder = placeholder
                self.action_id = action_id
                self.options = options
                self.option_groups = option_groups
                self.initial_option = initial_option
                self.confirm = confirm
            }
            
            public static func withOptions(
                action_id: String,
                placeholder: CompositionObject.Text,
                options: [CompositionObject.Option]? = nil,
                initial_option: CompositionObject.Option? = nil,
                confirm: CompositionObject.ConfirmationDialog? = nil
            ) -> Self {
                self.init(
                    action_id: action_id,
                    placeholder: placeholder,
                    options: options,
                    option_groups: nil,
                    initial_option: initial_option,
                    confirm: confirm
                )
            }
            
            public static func withOptionGroups(
                action_id: String,
                placeholder: CompositionObject.Text,
                option_groups: [CompositionObject.OptionGroup]? = nil,
                initial_option: CompositionObject.Option? = nil,
                confirm: CompositionObject.ConfirmationDialog? = nil
            ) -> Self {
                self.init(
                    action_id: action_id,
                    placeholder: placeholder,
                    options: nil,
                    option_groups: option_groups,
                    initial_option: initial_option,
                    confirm: confirm
                )
            }
        }
        
        /// This menu will load its options from an external data source, allowing for a dynamic list of options.
        ///
        /// Setup
        /// To use this menu type, you'll need to configure your app first:
        /// - Goto your app's settings page and choose the Interactive Components feature menu.
        /// - Add a URL to the Options Load URL under Select Menus.
        /// - Save changes.
        /// Each time a menu of this type is opened or the user starts typing in the typeahead field, we'll send a request to your specified URL.
        /// Your app should return an HTTP 200 OK response, along with an application/json post body with an object containing either an options array, or an option_groups array. Here's an example response:
        /// ```json
        /// {
        ///   "options": [
        ///     {
        ///       "text": {
        ///         "type": "plain_text",
        ///         "text": "*this is plain_text text*"
        ///       },
        ///       "value": "value-0"
        ///     },
        ///     {
        ///       "text": {
        ///         "type": "plain_text",
        ///         "text": "*this is plain_text text*"
        ///       },
        ///       "value": "value-1"
        ///     },
        ///     {
        ///       "text": {
        ///         "type": "plain_text",
        ///         "text": "*this is plain_text text*"
        ///       },
        ///       "value": "value-2"
        ///     }
        ///   ]
        /// }
        /// ```
        ///
        /// Works with block types: Section, Actions, Input
        public struct ExternalDataSourceListOptions: Encodable {
            /// The type of element. In this case type is always multi_static_select.
            public let type: String
            /// A plain_text only text object that defines the placeholder text shown on the menu.
            /// Maximum length for the text in this field is 150 characters.
            public let placeholder: CompositionObject.Text
            /// An identifier for the action triggered when a menu option is selected.
            /// You can use this when you receive an interaction payload to identify the source of the action.
            /// Should be unique among all other action_ids in the containing block.
            /// Maximum length for this field is 255 characters.
            public let action_id: String
            /// When the typeahead field is used, a request will be sent on every character change.
            /// If you prefer fewer requests or more fully ideated queries, use the min_query_length attribute to tell Slack the fewest number of typed characters required before dispatch.
            /// The default value is 3.
            public let min_query_length: Int?
            /// A single option that exactly matches one of the options within the options or option_groups loaded from the external data source.
            /// This option will be selected when the menu initially loads.
            public let initial_option: CompositionObject.Option?
            /// A confirm object that defines an optional confirmation dialog that appears before the multi-select choices are submitted.
            public let confirm: CompositionObject.ConfirmationDialog?
            
            public init(
                action_id: String,
                placeholder: CompositionObject.Text,
                min_query_length: Int? = nil,
                initial_option: CompositionObject.Option? = nil,
                confirm: CompositionObject.ConfirmationDialog? = nil
            ) {
                self.type = "external_select"
                self.placeholder = placeholder
                self.action_id = action_id
                self.min_query_length = min_query_length
                self.initial_option = initial_option
                self.confirm = confirm
            }
        }
        
        /// This select menu will populate its options with a list of Slack users visible to the current user in the active workspace.
        ///
        /// Works with block types: Section, Action, Input
        public struct UserListOptions: Encodable {
            /// The type of element. In this case type is always multi_static_select.
            public let type: String
            /// A plain_text only text object that defines the placeholder text shown on the menu.
            /// Maximum length for the text in this field is 150 characters.
            public let placeholder: CompositionObject.Text
            /// An identifier for the action triggered when a menu option is selected.
            /// You can use this when you receive an interaction payload to identify the source of the action.
            /// Should be unique among all other action_ids in the containing block.
            /// Maximum length for this field is 255 characters.
            public let action_id: String
            /// The user ID of any valid user to be pre-selected when the menu loads.
            public let initial_user: String?
            /// A confirm object that defines an optional confirmation dialog that appears before the multi-select choices are submitted.
            public let confirm: CompositionObject.ConfirmationDialog?
            
            public init(
                action_id: String,
                placeholder: CompositionObject.Text,
                initial_user: String? = nil,
                confirm: CompositionObject.ConfirmationDialog? = nil
            ) {
                self.type = "users_select"
                self.placeholder = placeholder
                self.action_id = action_id
                self.initial_user = initial_user
                self.confirm = confirm
            }
        }
        
        /// This select menu will populate its options with a list of public and private channels, DMs, and MPIMs visible to the current user in the active workspace.
        ///
        /// Works with block types: Section, Input
        public struct ConversationListOptions: Encodable {
            /// The type of element. In this case type is always multi_static_select.
            public let type: String
            /// A plain_text only text object that defines the placeholder text shown on the menu.
            /// Maximum length for the text in this field is 150 characters.
            public let placeholder: CompositionObject.Text
            /// An identifier for the action triggered when a menu option is selected.
            /// You can use this when you receive an interaction payload to identify the source of the action.
            /// Should be unique among all other action_ids in the containing block.
            /// Maximum length for this field is 255 characters.
            public let action_id: String
            /// The ID of any valid conversation to be pre-selected when the menu loads.
            /// If default_to_current_conversation is also supplied, initial_conversation will take precedence.
            public let initial_conversation: String?
            /// Pre-populates the select menu with the conversation that the user was viewing when they opened the modal, if available.
            /// Default is false.
            public let default_to_current_conversation: Bool?
            /// A confirm object that defines an optional confirmation dialog that appears before the multi-select choices are submitted.
            public let confirm: CompositionObject.ConfirmationDialog?
            /// When set to true, the view_submission payload from the menu's parent view will contain a response_url.
            /// This response_url can be used for message responses.
            /// The target conversation for the message will be determined by the value of this select menu.
            ///
            /// This field only works with menus in input blocks in modals.
            public let response_url_enabled: Bool?
            /// A filter object that reduces the list of available conversations using the specified criteria.
            public let filter: CompositionObject.FilterForConversationList?
            
            public init(
                action_id: String,
                placeholder: CompositionObject.Text,
                initial_conversation: String? = nil,
                default_to_current_conversation: Bool? = nil,
                initial_options: [CompositionObject.Option]? = nil,
                confirm: CompositionObject.ConfirmationDialog? = nil,
                response_url_enabled: Bool? = nil,
                filter: CompositionObject.FilterForConversationList? = nil
            ) {
                self.type = "conversations_select"
                self.placeholder = placeholder
                self.action_id = action_id
                self.initial_conversation = initial_conversation
                self.default_to_current_conversation = default_to_current_conversation
                self.confirm = confirm
                self.response_url_enabled = response_url_enabled
                self.filter = filter
            }
        }
        
        /// This select menu will populate its options with a list of public channels visible to the current user in the active workspace.
        ///
        /// Works with block types: Section, Actions, Input
        public struct PublicChannelListOptions: Encodable {
            /// The type of element. In this case type is always multi_static_select.
            public let type: String
            /// A plain_text only text object that defines the placeholder text shown on the menu.
            /// Maximum length for the text in this field is 150 characters.
            public let placeholder: CompositionObject.Text
            /// An identifier for the action triggered when a menu option is selected.
            /// You can use this when you receive an interaction payload to identify the source of the action.
            /// Should be unique among all other action_ids in the containing block.
            /// Maximum length for this field is 255 characters.
            public let action_id: String
            /// An array of one or more IDs of any valid public channel to be pre-selected when the menu loads.
            public let initial_channel: String?
            /// A confirm object that defines an optional confirmation dialog that appears before the multi-select choices are submitted.
            public let confirm: CompositionObject.ConfirmationDialog?
            /// When set to true, the view_submission payload from the menu's parent view will contain a response_url.
            /// This response_url can be used for message responses.
            /// The target conversation for the message will be determined by the value of this select menu.
            ///
            /// This field only works with menus in input blocks in modals.
            public let response_url_enabled: Bool?
            
            public init(
                action_id: String,
                placeholder: CompositionObject.Text,
                initial_channel: String? = nil,
                confirm: CompositionObject.ConfirmationDialog? = nil,
                response_url_enabled: Bool? = nil
            ) {
                self.type = "channels_select"
                self.placeholder = placeholder
                self.action_id = action_id
                self.initial_channel = initial_channel
                self.confirm = confirm
                self.response_url_enabled = response_url_enabled
            }
        }
    }
}

extension BlockElement {
    /// An element which allows selection of a time of day.
    ///
    /// Works with block types: Section Actions Input
    ///
    /// Beta feature
    /// This is an in-development app feature that must be enabled in the Beta Features section of your app config before use.
    /// On desktop clients, this time picker will take the form of a dropdown list with free-text entry for precise choices. On mobile clients, the time picker will use native time picker UIs.
    ///
    /// To use interactive components like this, you will need to make some changes to prepare your app. Read our guide to enabling interactivity.
    public struct TimePicker: Encodable {
        /// The type of element. In this case type is always timepicker.
        public let type: String
        /// An identifier for the action triggered when a time is selected.
        /// You can use this when you receive an interaction payload to identify the source of the action.
        /// Should be unique among all other action_ids in the containing block.
        /// Maximum length for this field is 255 characters.
        public let action_id: String
        /// A plain_text only text object that defines the placeholder text shown on the timepicker.
        /// Maximum length for the text in this field is 150 characters.
        public let placeholder: CompositionObject.Text?
        /// The initial time that is selected when the element is loaded.
        /// This should be in the format HH:mm, where HH is the 24-hour format of an hour (00 to 23) and mm is minutes with leading zeros (00 to 59), for example 22:25 for 10:25pm.
        public let initial_time: String?
        /// A confirm object that defines an optional confirmation dialog that appears after a time is selected.
        public let confirm: CompositionObject.ConfirmationDialog?
        
        init(
            action_id: String,
            placeholder: CompositionObject.Text? = nil,
            initial_time: String? = nil,
            confirm: CompositionObject.ConfirmationDialog? = nil
        ) {
            self.type = "timepicker"
            self.action_id = action_id
            self.placeholder = placeholder
            self.initial_time = initial_time
            self.confirm = confirm
        }
    }
}
