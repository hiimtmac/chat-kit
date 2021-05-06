import Foundation

public protocol Operation {
    associatedtype Body
    associatedtype Response
    var route: Router { get }
}

public protocol ConversationOperation: Operation {
    
}

public protocol AttachmentOperation: Operation {
    
}
