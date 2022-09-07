//
//  Closures.swift
//  Contacts
//
//  Created by Cielo Reyes on 9/6/22.
//

import Foundation

typealias VoidResult = () -> Void
typealias ErrorResult = (Error) -> Void
typealias APIResult = ([Person]) -> Void
typealias DetailResult = (Person) -> Void
