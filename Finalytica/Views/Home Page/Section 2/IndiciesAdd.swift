//
//  IndiciesAdd.swift
//  Finalytica
//
//  Created by Eric Portela on 2023-01-18.
//

import SwiftUI

struct IndiciesAdd: View {
    var body: some View {
        ZStack {
            Color(cgColor: AppColors().black)
            Text("+")
                .foregroundColor(.white)
                .font(.title)
        }
        .frame(width: 80, height: 80)
        .cornerRadius(15)
        .shadow(color: .secondary, radius: 5)
    }
}

struct IndiciesAdd_Previews: PreviewProvider {
    static var previews: some View {
        IndiciesAdd()
    }
}
