//
//  WatchedStockItemView.swift
//  Stonks
//
//  Created by Guillermo Zafra on 18/6/24.
//

import SwiftUI

struct WatchedStockItemView: View {
    
    private enum Layout {
        static let horizontalPadding: CGFloat = 6
        static let height: CGFloat = 44
    }
    
    @State public var state: StockItemState
    
    var body: some View {
        ZStack {
            Color(.white)
            VStack(alignment: .center, spacing: .zero) {
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                    Text(state.ticker)
                        .font(.body)
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text(state.pricePerShare)
                            .font(.body)
                        Text("\(state.dailyGrowthValue) (\(state.dailyGrowthPercent))")
                            .font(.caption)
                            .foregroundStyle(state.dailyGrowthIsPositive ? .green : .red)
                    }
                }
                .padding(.horizontal, Layout.horizontalPadding)
                .frame(height: Layout.height)
            }
        }
    }
}

#Preview {
    ZStack {
        Color(.gray)
        WatchedStockItemView(state: StockItemState.mockItem1())
            .frame(height: 50)
    }
}
