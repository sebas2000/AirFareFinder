//
//  Route.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on November 30, 2022
//
import Foundation

struct Route: Codable {

	let id: String
	let combinationId: String?
	let flyFrom: String
	let flyTo: String
	let cityFrom: String
	let cityCodeFrom: String
	let cityTo: String
	let cityCodeTo: String
	let airline: String
	let flightNo: Int?
	let operatingCarrier: String
	let operatingFlightNo: String?
	let fareBasis: String?
	let fareCategory: String
	let fareClasses: String
	let fareFamily: String
	let returnField: Int?
	let bagsRecheckRequired: Bool
	let viConnection: Bool
	let guarantee: Bool
	let equipment: String?
	let vehicleType: String
	let localArrival: String
	let utcArrival: String
	let localDeparture: String
	let utcDeparture: String

}
