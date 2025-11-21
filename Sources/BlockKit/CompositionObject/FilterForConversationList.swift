import Foundation

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
