import Foundation

/// Defines an HTTP API response.
public struct ErrorResponse {
    /// An Error object that contains information about the error.
    public let error: Error
    
    public init(error: Error) {
        self.error = error
    }
}

extension ErrorResponse {
    /// Object representing error information
    public struct Error {
        /// Error code.
        public let code: String
        /// Object representing the inner HTTP error.
        public let innerHttpError: InnerHttpError
        /// A description of the error.
        public let message: String
        
        public init(code: String, innerHttpError: InnerHttpError, message: String) {
            self.code = code
            self.innerHttpError = innerHttpError
            self.message = message
        }
    }
}
