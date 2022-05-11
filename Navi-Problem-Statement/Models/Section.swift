//
//  Section.swift
//  Navi-Problem-Statement
//
//  Created by Lakshay Saini on 11/05/22.
//

import Foundation

class Section {
    let result: Results
    var isHidden: Bool = true
    
    init(result: Results, isOpened: Bool = true) {
        self.result = result
        self.isHidden = isOpened
    }
}
