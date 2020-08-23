//
//  ADPOmodel.swift
//  APOD
//
//  Created by Thomas Kellough on 8/23/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import Foundation

struct APOD: Decodable {
    let title: String
    let date: String
    let explanation: String
    let hdurl: String
    let url: String
    let copyright: String?
}
