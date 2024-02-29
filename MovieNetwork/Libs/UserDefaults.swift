//
//  UserDefaults.swift
//  MovieNetwork
//
//  Created by Victorien Druon on 20/02/2024.
//

import Foundation

func markUserAsOnboarded() {
    UserDefaults.standard.set(true, forKey: "isOnBoarded")
}
