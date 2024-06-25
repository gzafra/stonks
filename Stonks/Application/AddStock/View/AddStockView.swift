//
//  AddStockView.swift
//  Stonks
//
//  Created by Guillermo Zafra on 21/6/24.
//

import SwiftUI

struct AddStockView<ViewModel: AddStockViewModelProtocol>: View  {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Text(self.viewModel.ticker).font(.title)
            transactionType
            datePicker
            quantityShares
            currencyType
            pricePerShare
            commission
            Spacer()
            Button("Add") {
                self.viewModel.onAdd()
            }
        }.padding()
    }
    
    var transactionType: some View {
        HStack {
            Text("Transaction")
            Spacer()
            Picker("Order type", selection: $viewModel.transactionSelection) {
                ForEach(TransactionType.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(.menu)
        }
    }
    
    var datePicker: some View {
        HStack {
            Text("Date")
            Spacer()
            DatePicker("",
                       selection: $viewModel.selectedDate,
                       displayedComponents: .date)
        }
    }
    
    var currencyType: some View {
        HStack {
            Text("Currency")
            Spacer()
            Picker("Currency", selection: $viewModel.selectedCurrency) {
                ForEach(CurrencyType.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(.menu)
        }
    }
    
    var quantityShares: some View {
        HStack {
            Text("# Shares")
            Spacer()
            TextField("", text: $viewModel.numShares)
                .textFieldStyle(.roundedBorder)
                .frame(maxWidth: 100)
        }
    }
    
    var pricePerShare: some View {
        HStack {
            Text("Price per share")
            Spacer()
            TextField("", text: $viewModel.pricePerShare)
                .textFieldStyle(.roundedBorder)
                .frame(maxWidth: 100)
        }
    }
    
    var commission: some View {
        HStack {
            Text("Commissions")
            Spacer()
            TextField("", text: $viewModel.commission)
                .textFieldStyle(.roundedBorder)
                .frame(maxWidth: 100)
        }
    }
}

#Preview {
    AddStockView(viewModel: StubAddStockViewModel())
}


private class StubAddStockViewModel: AddStockViewModelProtocol {
    var ticker: String = "AAPL"
    var numShares: String = "5"
    var pricePerShare: String = "5,5"
    var commission: String = "1"
    var transactionSelection: TransactionType = .buy
    var selectedDate: Date = Date()
    var selectedCurrency: CurrencyType = .usd
    func onAdd() {}
}
