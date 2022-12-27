//
//  Search.swift
//  AirFareFinder
//
//  Created by Sebastian Chab Vives on 03/12/2022.
//

import SwiftUI

struct SearchView: View {
  //  @ObservedObject var chaptersVM = ChaptersViewModel()

    @ObservedObject var viewModel = SearchViewModel()
    @State var origin:String = ""
    @State var destination:String = ""
    @State var showCityPicker = false
    @State var showCityPickerTo = false

    @State var searching = false
    @State var showResults = false
    
    @State var dateFrom: Date = Date()
    @State var dateTo: Date = Date()


    var body: some View {
        NavigationView {

        VStack {
            Text("Air Fare Finder")
            Spacer()
            
//            if !showResults {

            HStack {
//                TextField(  "Meme Text",
//                            text: $origin,
//                            prompt: Text("Origen")
//                ).textFieldStyle(.roundedBorder)
//                .textCase(.uppercase)
                Spacer()

                Button("Origin  \(origin)") {
                    showCityPicker.toggle()
                    
                }.buttonStyle(.borderedProminent)
                    .clipShape(Capsule())
                .sheet(isPresented: $showCityPicker){
                    CityPickerView(city: $origin, isPresented: $showCityPicker)
                }
                Spacer()
                
                Button("Destination \(destination)") {
                    showCityPickerTo.toggle()
                    
                }.buttonStyle(.borderedProminent)
                    .clipShape(Capsule())
                .sheet(isPresented: $showCityPickerTo){
                    CityPickerView(city: $destination, isPresented: $showCityPickerTo)
                }
                Spacer()

                
            }
            Spacer()
            HStack(){
                Spacer(minLength: 40)
                VStack {
                    DatePicker("Departure Date", selection: $dateFrom, displayedComponents: .date)
                        .id(dateFrom)     // << workarround format

                    DatePicker("Return Date", selection: $dateTo,in: dateFrom..., displayedComponents: .date)
                        .id(dateTo)

                }
                Spacer(minLength: 40)
            }
                

            Spacer()
            Button("Search") {
                searching = true
                Task() {
                    var query = SearchQuery(from: origin, to: destination, dateFrom: dateFrom, dateTo: dateTo)
                    await viewModel.search( query: query)
                    showResults = true
                }
                
            }
//            } else {
                NavigationLink(destination:  FlightsView(viewModel: viewModel), isActive: $showResults) { EmptyView() }

                 
                
//                List((viewModel.response!.data), id: \.id) { item in
//                    VStack(alignment: .leading){
//                        Text(item.cityCodeFrom)
//                        //Text(item.cityCodeTo)
//                        Text(String(item.price))
//
//                    }
//
//                }
//            }
            Spacer()
        }
        }
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
