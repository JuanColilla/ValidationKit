//
//  Validated.swift
//  
//
//  Created by Juan Colilla on 7/3/23.
//

import Foundation

/// ValidationState allows us to bind validated fields with reactive Textfields.
public enum ValidationState: Equatable {
    case idle
    case valid
    case locked
    case notValid(ValidationError)
}

/// Validated is a PropertyWrapper to help us validate Strings looking for a specific kind of value pattern.
@propertyWrapper
public struct Validated {
    
    // Properties
    private var value: String
    private var validators: [Validator]
    public var validationState: ValidationState = .idle
    // ----------------
    
    // Wrapped Value
    public var wrappedValue: String {
        get { value }
        set {
            value = newValue
            validate()
        }
    }
    // ----------------
    
    // Initializer
    public init(_ validators: Validator...,value: String = "") {
        self.validators = validators
        self.value = value
        validate()
    }
    // ----------------
    
    // Validation Function
    private mutating func validate() {
        
        var validations: [ValidatedString] = []
        
        validators.forEach { validator in
            switch validator {
            case .email:
                validations.append(Validated.email(value))
            case .notEmpty:
                validations.append(Validated.notEmpty(value))
            case .phone:
                validations.append(Validated.phone(value))
            case .idDoc:
                validations.append(Validated.idDoc(value))
            case .password:
                validations.append(Validated.password(value))
            case .minLenght(let lenght):
                validations.append(Validated.minLenght(value, lenght))
            case .maxLenght(let lenght):
                validations.append(Validated.maxLenght(value, lenght))
            }
        }
        
        for validation in validations {
            if case .failure(let failure) = validation {
                validationState = .notValid(failure)
                break
            } else {
                validationState = .valid
            }
        }
    }
    // ----------------
}



extension Validated: Equatable {
    public static func == (lhs: Validated, rhs: Validated) -> Bool {
        if lhs.value == rhs.value &&
            lhs.validationState == rhs.validationState &&
            lhs.validators == rhs.validators &&
            lhs.wrappedValue == rhs.wrappedValue {
            return true
        } else {
            return false
        }
    }
}
