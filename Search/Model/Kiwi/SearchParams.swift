//
//  SearchParams.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on November 30, 2022
//
import Foundation

struct SearchParams: Codable {
    enum CodingKeys: String, CodingKey {
        case toType,seats
        case flyFromType = "flyFrom_type"
    }
    
	let flyFromType: String?
	let toType: String
	let seats: Seats

}
