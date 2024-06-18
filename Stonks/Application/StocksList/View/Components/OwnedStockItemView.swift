//
//  OwnedStockItemView.swift
//  Stonks
//
//  Created by Guillermo Zafra on 18/6/24.
//

import SwiftUI

struct OwnedStockItemView: View {
    
    private enum Layout {
        static let horizontalPadding: CGFloat = 6
        static let height: CGFloat = 44
    }
    
    @State public var state: StockItemState
    @State var isCollapsed: Bool = true
    
    var body: some View {
        ZStack {
            Color(.white)
            VStack(alignment: .center, spacing: .zero) {
                mainView
                extendedView
            }
        }.onTapGesture {
            withAnimation {
                isCollapsed.toggle()
            }
        }
        .modifier(AnimatingCellHeight(height: isCollapsed ? 50 : 100))
    }
    
    var mainView: some View {
        HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
            Text(state.ticker)
                .font(.body)
            Spacer()
            VStack(alignment: .trailing) {
                Text(state.totalValue)
                    .font(.body)
                Text("\(state.dailyGrowthValue) (\(state.dailyGrowthPercent))")
                    .font(.caption)
                    .foregroundStyle(state.dailyGrowthIsPositive ? .green : .red)
            }
        }
        .padding(.horizontal, Layout.horizontalPadding)
        .padding(.vertical, 3)
    }
    
    var extendedView: some View {
        VStack {
            Divider()
            HStack {
                Text("Shares: \(state.shares)")
                Spacer()
                Text("Price per share: ")
            }.font(.caption)
            HStack {
                Text("Total W/L: \(state.totalGrowthValue)")
                    .foregroundStyle(state.totalGrowthIsPositive ? .green : .red)
                Spacer()
                Text("Percent W/L: \(state.totalGrowthPercent)")
                    .foregroundStyle(state.totalGrowthIsPositive ? .green : .red)
            }.font(.caption)
        }
        .frame(height: isCollapsed ? 0 : nil, alignment: .center)
        .clipped()
        .padding(.horizontal, Layout.horizontalPadding)
        .padding(.vertical, 3)
    }
}

#Preview {
    ZStack {
        Color(.gray)
        OwnedStockItemView(state: StockItemState.mockItem1())
//            .frame(height: 50)
    }
}
