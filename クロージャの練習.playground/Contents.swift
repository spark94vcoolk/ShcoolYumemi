import UIKit

//var greeting = "Hello, playground"

//
//func calkTryangelArea(width: Int,height: Int) {
//   print(width * height / 2)
//}
//
//let calculater: (Int, Int) -> Int = { (width, height) in
//    let area = width * height / 2
//    return are
//        // クロージャの実行
//        let result = calculater(3, 4)
//        // 結果をprintで表示
//        print(result)
//    }

//funcAddFUnction

let addNumbar: (Int, Int) -> Int = { (a,b) in
    //return a + b だけでも良い
    let  result = a + b
    return result
}
let add = addNumbar(3,5)
print(add)




let greeting: (String) -> String = { (name) in
    //上のnameに（）はいらない
    return "こんにちは,\(name)!"
}
let greetingName = greeting("山本先生")
print(greetingName)




enum DivisionError:Error {
    case divisionByZero
}

func divide(num01: Int, num02:Int) -> Result<Int, DivisionError> {
    if num02 != 0 {
        return .success (num01 / num02)
    } else {
        return .failure (DivisionError.divisionByZero)
    }
}
let calc = divide(num01: 10, num02: 0)
switch calc {
case .success(let answer):
    print(answer)
case .failure(let error):
    print(error)
}
