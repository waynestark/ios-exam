//
//  PeopleTableCellViewModel.swift
//  RandomMe
//
//  Created by Marwin Carino on 7/27/22.
//

import Foundation

struct PeopleTableCellViewModel {
    let thumbnail: String
    let name: Name
    let phone: String
    let email: String
    let location: Location
}

extension PeopleTableCellViewModel {
    var thumbnailURL: URL? {
        thumbnail.toURL()
    }
    
    var nameText: String {
        let trimmedTitle = name.title.trimmed
        let trimmedFirstName = name.first.trimmed
        let trimmedLastName = name.last.trimmed
        
        let title = trimmedTitle.isEmpty ? "" : "\(trimmedTitle). "
        let firstName = trimmedFirstName.isEmpty ? "" : "\(trimmedFirstName) "
        let lastName = trimmedLastName.isEmpty ? "" : "\(trimmedLastName)"
        
        return title + firstName + lastName
    }
    
    var phoneText: String {
        phone.trimmed
    }
    
    var emailText: String {
        email.trimmed
    }
    
    var addressText: String {
        let trimmedCity = location.city
        let trimmedState = location.state
        let trimmedCountry = location.country
        
        let city = trimmedCity.isEmpty ? "" : "\(trimmedCity), "
        let state = trimmedState.isEmpty ? "" : "\(trimmedState), "
        let country = trimmedCountry.isEmpty ? "" : "\(trimmedCountry)"
        
        return city + state + country
    }
}
