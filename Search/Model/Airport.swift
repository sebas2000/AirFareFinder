//
//  Airport.swift
//  AirFareFinder
//
//  Created by Sebastian Chab Vives on 17/12/2022.
//

import Foundation


public struct Airport: Identifiable , Codable {    
    public let id = UUID()

    let airportCode: String
    let name: String
    let countryCode: String
    
    var description:String {String("\(airportCode) - \(name) - \(countryCode)")}

}
