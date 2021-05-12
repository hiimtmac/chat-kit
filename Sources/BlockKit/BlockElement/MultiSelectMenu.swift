import Foundation

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
