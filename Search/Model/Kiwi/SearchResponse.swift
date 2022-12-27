//
//  RootClass.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on November 30, 2022
//
import Foundation

public struct SearchResponse: Codable {

	let searchId: String?
	let currency: String
	let fxRate: Int?
	let data: [AirData]
	let Results: Int?
	let searchParams: SearchParams
	let allStopoverAirports: [String]
	let sortVersion: Int

}
