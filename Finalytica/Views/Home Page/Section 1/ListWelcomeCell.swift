//
//  ListWelcomeCell.swift
//  Finalytica
//
//  Created by Eric Portela on 2023-01-16.
//

import SwiftUI

struct ListWelcomeCell: View {
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            
            Color(AppColors().purple).ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 15) {
                Text("Good morning admin!")
                    .font(.title2)
                    .bold()
                
                
                Text("Search to research a company on NYSE or Nasdaq!")
                    .font(.subheadline)
                
            }
            
            .foregroundColor(.white)
            .padding(15)
            
        }
        //.frame(width: UIScreen.main.bounds.size.width-40, height: 180)
        .cornerRadius(15)
        
        
    }
}

struct ListWelcomeCell_Previews: PreviewProvider {
    static var previews: some View {
        ListWelcomeCell()
    }
}
