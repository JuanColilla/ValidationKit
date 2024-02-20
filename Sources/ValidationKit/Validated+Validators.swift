//
//  Validated+Validators.swift
//
//
//  Created by Juan Colilla on 7/3/23.
//

import Foundation

// To add more validations write a new case, its relative function and the respective case inside "Validated.validate()"
/// Available validations for @Validated
public enum Validator: Equatable {
    case email
    case phone
    case idDoc
    case notEmpty
    case password
    case minLenght(Int)
    case maxLenght(Int)
}

/// Errors for when a value do not pass the validation.
public enum ValidationError: Error {
    case none
    case notAnEmail
    case notAPhone
    case notValidID
    case notANumber
    case emptyValue
    case passwordNotValid
    case minLenghtNotSatisfied
    case maxLenghtOverpassed
}

// Here is where all validators are written.
public extension Validated {
    
    typealias ValidatedString = Result<String, ValidationError>
    
    static func email(_ value: String) -> ValidatedString {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: value) ? .success(value) : .failure(.notAnEmail)
    }
    
    static func phone(_ value: String) -> ValidatedString {
        let phoneRegex = "[0-9]{4,}"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phonePredicate.evaluate(with: value) ? .success(value) : .failure(.notAPhone)
    }
    
    static func spanishID(_ value: String) -> ValidatedString {
        let idDocRegex = "[A-Z0-9]{7,}"
        let idDocPredicate = NSPredicate(format: "SELF MATCHES %@", idDocRegex)
        return idDocPredicate.evaluate(with: value.uppercased()) ? .success(value.uppercased()) : .failure(.notValidID)
    }
    
    static func notEmpty(_ value: String) -> ValidatedString {
        return value.count > 0 ? .success(value) : .failure(.emptyValue)
    }
    
    static func defaultPassword(_ value: String) -> ValidatedString {
        let passRegex = "^(?=.*[\"~`!@#\\$%^&*()_\\-+={\\[\\]}|:;\"'<,>.?/¡¿¬€\"])(?=.*\\d).{8,16}$"
        let passPredicate = NSPredicate(format: "SELF MATCHES %@", passRegex)
        return passPredicate.evaluate(with: value) ? .success(value) : .failure(.passwordNotValid)
    }
    
    static func minLenght(_ value: String,_ minLenght: Int) -> Result<String, ValidationError> {
        if value.count < minLenght {
            return .failure(.minLenghtNotSatisfied)
        } else {
            return .success(value)
        }
    }
    
    static func maxLenght(_ value: String,_ maxLenght: Int) -> ValidatedString {
        if value.count > maxLenght {
            return .failure(.maxLenghtOverpassed)
        } else {
            return .success(value)
        }
    }
    
}
