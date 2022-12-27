//
//  CityPickerView.swift
//  AirFareFinder
//
//  Created by Sebastian Chab Vives on 15/12/2022.
//

import SwiftUI

var airports = SearchViewModel.loadAirports()

struct CityPickerView: View {
    
    @State private var searchText = ""
    @Binding var city:String
    
    @Binding var isPresented: Bool

    var body: some View {
           NavigationView {
               //List(filteredAirports, id: \.self) { a in
           
               
               List(filteredAirports) { a in
                  // Text(a.name)
                   let cityCode = a.airportCode ?? "n/a"
                   Button("\(a.description)") {
                       city = cityCode
                       isPresented = false
                    }
               }
               .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Look for something")
               .navigationTitle("Searching")
           }
       }

       var filteredAirports: [Airport] {
           if searchText.isEmpty {
               return airports
           } else {
//               return airports.filter { $0.name.contains(searchText) }
               return airports.filter {
                   $0.description.range(of: searchText, options: .caseInsensitive) != nil
               }

           }
       }
}

struct CityPickerView_Previews: PreviewProvider {
    static var previews: some View {
        CityPickerView(city: .constant("SAO"), isPresented: .constant(true))
    }
}
