# chat-kit

A description of this package.

> pre-release and subject to change

## Teams

### Outgoing Webhook

[See here](https://docs.microsoft.com/en-us/microsoftteams/platform/webhooks-and-connectors/how-to/add-outgoing-webhook) how to setup a outgoing webhook

#### Validate Teams Clients

Make sure to validate the post body to make sure it actually comes from a teams client. This can be done using an extension on `Data`:

```swift
Data("my data".utf8).validate(
    code: hmacCode, // this will come in header Authorization: "HMAC sd...d="
    withSecret: teamsSecret // this comes from teams when you setup webhook
)
```

> [Verify the outgoing webhook hmac token](https://docs.microsoft.com/en-us/microsoftteams/platform/webhooks-and-connectors/how-to/add-outgoing-webhook#2-create-a-method-to-verify-the-outgoing-webhook-hmac-token)

### Decoding Activity

Decode post body `Activity` from teams using the custom `JSONDecoder.teams` decoder (handles that way microsoft encodes their dates/timestamps)

```swift
let message = try req.content.decode(Activity.self, using: JSONDecoder.teams)
```

### Incoming webhook

[See here](https://docs.microsoft.com/en-us/microsoftteams/platform/webhooks-and-connectors/how-to/add-incoming-webhook) how to setup a incoming webhook

> Make sure to add `365` to the url teams gives you (outlook.office365.com... teams made a url with outlook.office.com... for me)

Post the data of the message to the webhook url

Working:

- `O365ConnectorCard`

## Slack
