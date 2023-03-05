//
//  IndiciesCell.swift
//  Finalytica
//
//  Created by Eric Portela on 2023-01-17.
//

import SwiftUI

struct IndiciesCell: View {
    var indexName: String
    var price: String
    var priceChange: String

    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color(AppColors().black)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(indexName)
                    .foregroundColor(.white)
                    .font(.subheadline)
                    .bold()
                
                Text(price)
                    .foregroundColor(Color(UIColor.lightGray.cgColor))
                    .font(.custom("HelveticaNeue", fixedSize: 12))
                
                Text(priceChange)
                    .foregroundColor(Color(AppColors().positive))
                    .font(.custom("HelveticaNeue", fixedSize: 12))
            }
            .padding(10)
            
        }
        .frame(width: 200, height: 80 )
        .cornerRadius(15)
        
        
    }
}

struct IndiciesCell_Previews: PreviewProvider {
    static var previews: some View {
        //IndiciesCell()
        IndiciesCell(indexName: "", price: "", priceChange: "")
    }
}
