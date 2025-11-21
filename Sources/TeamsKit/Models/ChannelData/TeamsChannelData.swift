import Foundation

public struct TeamsChannelData: Codable {
    public let teamsChannelId: String
    public let teamsTeamId: String
    public let channel: ID
    public let team: ID
    public let tenant: ID
    
    public init(teamsChannelId: String, teamsTeamId: String, channel: ID, team: ID, tenant: ID) {
        self.teamsChannelId = teamsChannelId
        self.teamsTeamId = teamsTeamId
        self.channel = channel
        self.team = team
        self.tenant = tenant
    }
}
