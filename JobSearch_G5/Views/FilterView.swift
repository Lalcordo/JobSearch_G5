//
//  FilterView.swift
//  JobSearch_G5
//
//  Created by Julius Dejon on 2024-03-13.
//

import SwiftUI

struct FilterView: View {
    let geoOptions: [GeoOption] = loadGeoOptions()
    @Binding var selectedGeoOption: GeoOption?

    var body: some View {
        VStack(alignment: .leading) {
            Text("Filters").font(.title)
            HStack {
                Text("Selected Region: \(selectedGeoOption?.label ?? "")")
                Spacer()
                Picker("Geo", selection: $selectedGeoOption) {
                    ForEach(geoOptions) { option in
                        Text(option.label).tag(option as GeoOption?)
                    }
                }
                .pickerStyle(.menu)
                .padding()
            
            }
        }.padding()
    } // body
    

    
    static func loadGeoOptions() -> [GeoOption] {
        return [
            GeoOption(value: "", label: "🌐 Anywhere", parent: nil),
            GeoOption(value: "apac", label: "🌏 APAC", parent: nil),
            GeoOption(value: "australia", label: "🇦🇺 Australia", parent: "apac"),
            GeoOption(value: "china", label: "🇨🇳 China", parent: "apac"),
            GeoOption(value: "japan", label: "🇯🇵 Japan", parent: "apac"),
            GeoOption(value: "new-zealand", label: "🇳🇿 New Zealand", parent: "apac"),
            GeoOption(value: "philippines", label: "🇵🇭 Philippines", parent: "apac"),
            GeoOption(value: "singapore", label: "🇸🇬 Singapore", parent: "apac"),
            GeoOption(value: "south-korea", label: "🇰🇷 South Korea", parent: "apac"),
            GeoOption(value: "thailand", label: "🇹🇭 Thailand", parent: "apac"),
            GeoOption(value: "vietnam", label: "🇻🇳 Vietnam", parent: "apac"),
            GeoOption(value: "emea", label: "🌍 EMEA", parent: nil),
            GeoOption(value: "europe", label: "🇪🇺 Europe", parent: "emea"),
            GeoOption(value: "austria", label: "🇦🇹 Austria", parent: "europe"),
            GeoOption(value: "belgium", label: "🇧🇪 Belgium", parent: "europe"),
            GeoOption(value: "bulgaria", label: "🇧🇬 Bulgaria", parent: "europe"),
            GeoOption(value: "croatia", label: "🇭🇷 Croatia", parent: "europe"),
            GeoOption(value: "cyprus", label: "🇨🇾 Cyprus", parent: "europe"),
            GeoOption(value: "czechia", label: "🇨🇿 Czechia", parent: "europe"),
            GeoOption(value: "denmark", label: "🇩🇰 Denmark", parent: "europe"),
            GeoOption(value: "estonia", label: "🇪🇪 Estonia", parent: "europe"),
            GeoOption(value: "finland", label: "🇫🇮 Finland", parent: "europe"),
            GeoOption(value: "france", label: "🇫🇷 France", parent: "europe"),
            GeoOption(value: "germany", label: "🇩🇪 Germany", parent: "europe"),
            GeoOption(value: "greece", label: "🇬🇷 Greece", parent: "europe"),
            GeoOption(value: "hungary", label: "🇭🇺 Hungary", parent: "europe"),
            GeoOption(value: "ireland", label: "🇮🇪 Ireland", parent: "europe"),
            GeoOption(value: "italy", label: "🇮🇹 Italy", parent: "europe"),
            GeoOption(value: "latvia", label: "🇱🇻 Latvia", parent: "europe"),
            GeoOption(value: "lithuania", label: "🇱🇹 Lithuania", parent: "europe"),
            GeoOption(value: "netherlands", label: "🇳🇱 Netherlands", parent: "europe"),
            GeoOption(value: "norway", label: "🇳🇴 Norway", parent: "europe"),
            GeoOption(value: "poland", label: "🇵🇱 Poland", parent: "europe"),
            GeoOption(value: "portugal", label: "🇵🇹 Portugal", parent: "europe"),
            GeoOption(value: "romania", label: "🇷🇴 Romania", parent: "europe"),
            GeoOption(value: "slovakia", label: "🇸🇰 Slovakia", parent: "europe"),
            GeoOption(value: "slovenia", label: "🇸🇮 Slovenia", parent: "europe"),
            GeoOption(value: "spain", label: "🇪🇸 Spain", parent: "europe"),
            GeoOption(value: "sweden", label: "🇸🇪 Sweden", parent: "europe"),
            GeoOption(value: "switzerland", label: "🇨🇭 Switzerland", parent: "europe"),
            GeoOption(value: "uk", label: "🇬🇧 UK", parent: "europe"),
            GeoOption(value: "israel", label: "🇮🇱 Israel", parent: "emea"),
            GeoOption(value: "turkiye", label: "🇹🇷 Türkiye", parent: "emea"),
            GeoOption(value: "united-arab-emirates", label: "🇦🇪 United Arab Emirates", parent: "emea"),
            GeoOption(value: "latam", label: "🌎 LATAM", parent: nil),
            GeoOption(value: "argentina", label: "🇦🇷 Argentina", parent: "latam"),
            GeoOption(value: "brazil", label: "🇧🇷 Brazil", parent: "latam"),
            GeoOption(value: "costa-rica", label: "🇨🇷 Costa Rica", parent: "latam"),
            GeoOption(value: "mexico", label: "🇲🇽 Mexico", parent: "latam"),
            GeoOption(value: "canada", label: "🇨🇦 Canada", parent: nil),
            GeoOption(value: "usa", label: "🇺🇸 USA", parent: nil)
            
        ]
    }
}

struct GeoOption: Identifiable, Hashable {
    let id = UUID()
    let value: String
    let label: String
    let parent: String?
}
