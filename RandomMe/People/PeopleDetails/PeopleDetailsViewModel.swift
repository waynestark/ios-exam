//
//  PeopleDetailsViewModel.swift
//  RandomMe
//
//  Created by Marwin Carino on 7/27/22.
//

import Foundation

class PeopleDetailsViewModel {
    private let people: People
    
    init(people: People) {
        self.people = people
    }
}

extension PeopleDetailsViewModel {
    var thumbnailImageURL: URL? {
        people.picture.large?.toURL()
    }
    
    var nameText: String {
        let trimmedTitle = people.name.title.trimmed
        let trimmedFirstName = people.name.first.trimmed
        let trimmedLastName = people.name.last.trimmed
        
        let title = trimmedTitle.isEmpty ? "" : "\(trimmedTitle). "
        let firstName = trimmedFirstName.isEmpty ? "" : "\(trimmedFirstName) "
        let lastName = trimmedLastName.isEmpty ? "" : "\(trimmedLastName)"
        
        return title + firstName + lastName
    }
    
    var phoneText: String {
        people.phone.trimmed
    }
    
    var emailText: String {
        people.email.trimmed
    }
    
    var addressText: String {
        let trimmedCity = people.location.city
        let trimmedState = people.location.state
        let trimmedCountry = people.location.country
        
        let city = trimmedCity.isEmpty ? "" : "\(trimmedCity), "
        let state = trimmedState.isEmpty ? "" : "\(trimmedState), "
        let country = trimmedCountry.isEmpty ? "" : "\(trimmedCountry)"
        
        return city + state + country
    }
    
    var birthDateText: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        if let date = dateFormatter.date(from: people.birthDate.date) {
            dateFormatter.dateStyle = .medium
            
            return dateFormatter.string(from: date) + " - " + ageText
        } else {
            return .empty
        }
    }
    
    var ageText: String {
        "\(people.birthDate.age) years old"
    }
}
