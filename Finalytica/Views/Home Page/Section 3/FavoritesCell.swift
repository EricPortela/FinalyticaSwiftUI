//
//  FavoritesCell.swift
//  Finalytica
//
//  Created by Eric Portela on 2023-01-20.
//

import SwiftUI

struct FavoritesCell: View {
    
    var symbol: String
    var price: String
    var pctChange: String
    var eps: String
    var mCap: String
    
    var body: some View {
        ZStack(alignment: .center) {
            //Color(AppColors().black)
            
            HStack(spacing: (UIScreen.main.bounds.size.width/5)-50) {
                Text(symbol)
                    .bold()
                
                Text(price)
                
                Text(pctChange)

                Text(eps)
                
                Text(mCap)

            }
            //.foregroundColor(.white)
            
        }
        
        .frame(height: 60)
    }
}

struct FavoritesCell_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesCell(symbol: "-", price: "-", pctChange: "-", eps: "-", mCap: "-")
    }
}
