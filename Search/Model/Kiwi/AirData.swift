//
//  Data.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on November 30, 2022
//
import Foundation

struct AirData: Codable {

	let id: String
	let flyFrom: String
	let flyTo: String
	let cityFrom: String
	let cityCodeFrom: String
	let cityTo: String
	let cityCodeTo: String
	let countryFrom: CountryFrom
	let countryTo: CountryTo
	let nightsInDest: Int?
	let quality: Double
	let distance: Double
	let duration: Duration?
	let price: Int
	let conversion: Conversion
  //  let bagsPrice: BagsPrice
    let bagsPrice: [String:Float]?
	let baglimit: Baglimit
	let availability: Availability
	let airlines: [String]
	let route: [Route]
	let bookingToken: String
	let facilitatedBookingAvailable: Bool
	let pnrCount: Int
	let hasAirportChange: Bool
	let technicalStops: Int
	let throwAwayTicketing: Bool
	let hiddenCityTicketing: Bool
	let virtualInterlining: Bool
	let localArrival: String
	let utcArrival: String
	let localDeparture: String
	let utcDeparture: String

}
