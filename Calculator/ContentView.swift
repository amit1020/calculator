//
//  ContentView.swift
//  Calculator
//
//  Created by Amit Levi on 13/05/2022.
//

import SwiftUI
enum CalcButtons: String{
    case one = "1",two = "2",three="3",four="4",five="5",six="6",seven="7",eight="8",nine="9",zero="0"
    case add = "+"
    case subtract = "-"
    case divide = "/"
    case multiply = "*"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case precent = "%"
    case negative = "-/+"
}


struct ContentView: View {
    @State var Exercise: String = "0"
    @State var mode: String = ""
    @State var Num1: Double = 0
    @State var Num2: Double = 0
    @State var result: Double = 0
    let buttons: [[CalcButtons]] = [
        [.clear,.negative,.precent,.divide],
        [.seven,.eight,.nine,.multiply],
        [.four,.five,.six,.subtract],
        [.one,.two,.three,.add],
        [.zero,.decimal,.equal]
    ]
    var body: some View {
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all) //ignore from all the safe area - the edages of the screen
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Text(Exercise)
                        .bold()
                        .foregroundColor(.white)
                        .font(.system(size: 100))
                        
                    }
                    .padding()
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self){ item in
                            Button(action: {
                                self.didTap(item: item)
                                
                            }, label: {
                                Text(item.rawValue)
                                    .frame(
                                        width: self.buttonWidth(item: item),
                                        height: self.buttonHeight())
                                    .background(SetColor(item: item))
                                    .foregroundColor(.white)
                                    .cornerRadius(self.buttonWidth(item: item)/2)
                                    .font(.system(size: 32))
                            })
                        }
                    }
                    .padding(.bottom,3)
                }
            }
        }
    }
    
    func Equals_Function(){
        switch mode{
        case "+":
            result = Num1 + Num2
            Exercise = String(result)
        case "-":
            result = Num1 - Num2
            Exercise = String(result)
        case "*":
            result = Num1 * Num2
            Exercise = String(result)
        case "/":
            result = Num1 / Num2
            Exercise = String(result)
        default:
            result = 0
            Exercise = "Error"
        }
    }
    
    func didTap(item : CalcButtons){
        switch item.rawValue{
        case "=":
            Num2 = Double(Exercise) ?? 0
            Equals_Function()
        case "AC":
            Exercise = "0"
            mode = ""
            Num1 = 0
            Num2 = 0
            result = 0
        case "+":
            mode = "+"
            Num1 = Double(Exercise) ?? 0.0
            Exercise = "0"
        case "/":
            mode = "/"
            Num1 = Double(Exercise) ?? 0.0
            Exercise = "0"
        case "*":
            mode = "*"
            Num1 = Double(Exercise) ?? 0.0
            Exercise = "0"
        case "-":
            mode = "-"
            Num1 = Double(Exercise) ?? 0.0
            Exercise = "0"
        
        default:
            if Exercise == "0" || result > 0{
                Exercise = ""
            }
            result = 0
            Exercise+=item.rawValue
        }
    }
        

        
        
        
        
        
    
    
    func SetColor(item: CalcButtons) -> Color{
        switch item{
        case .clear,.negative,.precent:
            return Color(.lightGray)
        case .divide,.multiply,.subtract,.add,.equal:
            return Color.orange
        default:
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
        }
    }
    
    func buttonWidth(item: CalcButtons) -> CGFloat{
        if item == .zero {
            return (UIScreen.main.bounds.width - (5*12)) / 2
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    func buttonHeight() -> CGFloat{
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
