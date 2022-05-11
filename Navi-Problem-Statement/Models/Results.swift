//
//  Results.swift
//  Navi-Problem-Statement
//
//  Created by Lakshay Saini on 11/05/22.
//

import Foundation

struct Results: Codable {
    let state: String
    let title: String
    let created_at: String
    let closed_at: String?
    let user: User
    
}
struct User: Codable {
    let avatar_url: String?
    let login: String
}
