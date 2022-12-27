//
//  Flights.swift
//  AirFareFinder
//
//  Created by Sebastian Chab Vives on 05/12/2022.
//

import SwiftUI

struct FlightsView: View {
    var viewModel : SearchViewModel
    var preview : Bool = false
    
    static var formatter: ISO8601DateFormatter = {
        var formatter = ISO8601DateFormatter()
        
        // GMT or UTC -> UTC is standard, GMT is TimeZone
        formatter.timeZone = TimeZone(abbreviation: "GMT")
        formatter.formatOptions = [.withInternetDateTime,
                                   .withDashSeparatorInDate,
                                   .withColonSeparatorInTime,
                                   .withTimeZone,
                                   .withFractionalSeconds]
        
        return formatter
    }()
    
    func  formatFlight(_ stringDate: String) -> String {
        let date = FlightsView.formatter.date(from: stringDate)!
        
        let calendar = Calendar.current
        
        // let day = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        // let seconds = calendar.component(.second, from: date)
        let formated = String("\(hour):\(minutes)")
        
        return formated
    }
    
    func formatMinutes(_ time: Int) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        //let seconds = Int(time) % 60
        //  return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
        return String(format:"%02i:%02i", hours, minutes)
    }
    
    func initVM() {
        
        do {
            let fileURL = Bundle.main.url(forResource:"sample", withExtension: "txt")!
            
            
            let data = try Data(contentsOf:  fileURL)
            let decoder =  JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            viewModel.response = try decoder.decode(SearchResponse.self, from: data)
        } catch {
            fatalError("Couldn't load:\n\(error)")
        }
    }
    
    var body: some View {
        
        
        List((viewModel.response!.data), id: \.id) { item in
            HStack{
                VStack(alignment: .leading){
                    HStack{
                        VStack{
                            Text(item.cityFrom)
                            Text(self.formatFlight(
                                item.localDeparture))
                            Text(item.cityTo)
                            Text(self.formatFlight(
                                item.localArrival))
                        }
                        VStack{
                          //  Text("\( item.route.count)")

                            StopsLine(number:  item.route.count).id(item.route.count)
                            HStack{
                                
                                ForEach(item.route , id: \.id) { route in
                                    Image(route.airline,
                                          label: Text("route.airline")).resizable()
                                        .frame(width: 30, height: 30)
                                    Text("\(route.flyFrom)-\(route.flyTo) ").font(.footnote)
                                }
                            }
                            
                        }
                        Spacer()
                        //let formatted = String(format: "$%d", )
                        Text("$\(item.price).00")
                        
                    }
                    
                    //let duration = Date(timeIntervalSince1970:  Double(item.duration?.total ?? 0))
                    let duration = item.duration?.total ?? 0
                    //Text("duracion: \(item.duration?.total ?? 0)")
                    Text("duracion: \(self.formatMinutes(duration))")
                    // Text(item.cityCodeFrom)
                    //Text(item.cityCodeTo)
                    //Text(item.airlines)
                }
            }
            
        }.listStyle(.plain)
            .onAppear() {
                if preview {
                    initVM()
                }
            }
    }
    
}
struct StopsLine: View {
    var number: Int = 0
    var range: Range<Int> {0..<number}
    
    var body: some View {
        ZStack{
            //Text("\(number)")
            Rectangle().frame(width: .infinity, height: 2)
            HStack{
                Spacer()
                ForEach(range) { _ in
                    Circle().frame(width: 7, height: 7)
                }
                Spacer()
                
            }
        }
    }
}

struct Flights_Previews: PreviewProvider {
    
    
    static var previews: some View {
        
        /*  do {
         var data = try Data(contentsOf: "sample.txt")
         let decoder =  JSONDecoder()
         decoder.keyDecodingStrategy = .convertFromSnakeCase
         
         viewModel.response = try decoder.decode(SearchResponse.self, from: data)
         
         } catch {
         fatalError("Couldn't load:\n\(error)")
         }*/
        
        var viewModel = SearchViewModel()
        
        FlightsView(viewModel: viewModel , preview: true)
    }
}
