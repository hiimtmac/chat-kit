import Foundation

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
