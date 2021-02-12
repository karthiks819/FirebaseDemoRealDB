//
//  CustomerDataModel.swift
//  FirebaseDBDemo
//
//  Created by Karthik on 10/02/21.
//

import Foundation
class CustomerDataModel {
    let index: Int
    let uid: String
    let isActive: Bool
    let balance: String
    let age: Int
    let eyeColor, name, gender, company: String
    let email, phone, address, about: String
    let friends: [Friend]

    init(index: Int, uid: String, isActive: Bool, balance: String, age: Int, eyeColor: String, name: String, gender: String, company: String, email: String, phone: String, address: String, about: String, friends: [Friend]) {
        self.index = index
        self.uid = uid
        self.isActive = isActive
        self.balance = balance
        self.age = age
        self.eyeColor = eyeColor
        self.name = name
        self.gender = gender
        self.company = company
        self.email = email
        self.phone = phone
        self.address = address
        self.about = about
        self.friends = friends
    }
}

// MARK: - Friend
class Friend {
    let id: Int
    let name: String

    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
