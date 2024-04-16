# ios-exam

## Goal of the exam ##
To assess a developer's skills in terms of developing iOS apps and decision-making on solving common development tasks.

## Tasks ##

- Fork this repository
- Create an iOS Swift 5 project with the following features:
    - Uses Model-View ViewModel Design Pattern or Other Design Pattern Just Indicate what design pattern did you use
    - Uses Clean Architecture
    - Uses Modularization
    - Uses UIKit for layout
    - Loads and shows a list of Persons from a remote source (can be from some random source / such as https://randomuser.me)
    - Caches the loaded of avatar image 
    - Prevents any loading from the remote source if the cache is available
    - Save the loaded list of Persons to local database
    - Prevents any loading from the remote source if the local database is available
    - Swipe to refresh (Force update the cache data and storage data)
    - Loading more data when scrolling down bottom.
    - Shows the full details of a Person on a separate screen
    - Set the list title via click the avatar image on details page with back behavior
    - Each `Person` must have the following data: or use the API data  from https://randomuser.me
        - Avatar image
        - First name
        - Last name
        - Birthday
        - Age (derived from Birthday)
        - Email address
        - Mobile number
        - Address
        - Contact person
        - Contact person's phone number
- Send an email once done to arjay.paulino@cybilltek.com  CC. ysabel.garcesa@cybilltek.com

Any libraries or tools of the developer's choosing may be used.

## Optional requirements ##

- Changes are committed following Git Flow
- Unit tests
- UI tests
- iOS Design Guidelines
- Adaptive User Interfaces
- RxSwift / RxCocoa technology
