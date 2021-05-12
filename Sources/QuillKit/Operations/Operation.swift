import Foundation

public protocol Operation {
    associatedtype Body
    associatedtype Response
    var route: Router { get }
}
