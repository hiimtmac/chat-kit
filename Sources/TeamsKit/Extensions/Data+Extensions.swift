import Foundation
import Crypto

extension Data {
    /// Validate data against HMAC code
    /// - Parameters:
    ///   - code: base64 encoded HMAC token from request
    ///   - secret: key provided by Teams in base64 encoded format
    /// - Throws: if payload does not validate
    public func validate(code: String, withSecret secret: String) throws {
        guard let keyData = Data(base64Encoded: secret) else {
            throw ValidationError.secretKey
        }
        
        let hmac = HMAC<SHA256>.authenticationCode(
            for: self,
            using: SymmetricKey(data: keyData)
        )
                
        guard Data(hmac).base64EncodedString() == code else {
            throw ValidationError.mismatchedSignature
        }
    }
    
    public enum ValidationError: Error, LocalizedError {
        case secretKey
        case mismatchedSignature
        
        public var errorDescription: String? {
            switch self {
            case .secretKey: return "Secret not a valid base64 encoded string"
            case .mismatchedSignature: return "HMAC Validation Failure: Not a teams client"
            }
        }
    }
}
