import Foundation

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
