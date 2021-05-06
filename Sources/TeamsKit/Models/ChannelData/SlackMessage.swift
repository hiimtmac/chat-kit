import Foundation

/// Send full fidelity Slack messages
/// To create a full-fidelity Slack message, set the Activity object's channelData property to a JSON object that specifies Slack messages, Slack attachments, and/or Slack buttons.
public struct SlackMessage: Encodable {
    // https://docs.microsoft.com/en-us/previous-versions/azure/bot-service/rest-api/bot-framework-rest-connector-channeldata?view=azure-bot-service-3.0#create-a-full-fidelity-slack-message
    // https://api.slack.com/messaging
    // https://api.slack.com/messaging/composing/layouts#attachments
    // https://api.slack.com/legacy/message-buttons
}
