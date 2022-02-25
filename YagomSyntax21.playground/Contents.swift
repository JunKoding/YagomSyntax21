import Cocoa

// init, deinit - 인스턴스의 생성과 소멸

// init - 이니셜라이저
// deinit - 디이니셜라이저

// 프로퍼티 기본값

// 스위프트의 모든 인스턴스는 초기화와 동시에
// 모든 프로퍼티에 유효한 값이 할당되어 있어야 한다.
// 프로퍼티에 미리 기본값을 할당해 두면
// 인스턴스가 생성됨과 동시에 초기값을 지니게 된다.

class PersonA {
    // 모든 저장 프로퍼티에 기본값 할당
    var name: String = "unknown"
    var age: Int = 0
    var nickName: String = "nick"
}

let jun: PersonA = PersonA()
jun.name = "jun"
jun.age = 26
jun.nickName = "준규"





// init - 이니셜라이저

// 프로퍼티 기본값을 지정하기 어려운 경우에는
// 이니셜라이저를 통해 인스턴스가 가져야 할 초기값을 전달할 수 있다.

class PersonB {
    var name: String
    var age: Int
    var nickName: String
    
    // 이니셜라이저
    init(name: String, age: Int, nickName: String) {
        self.name = name
        self.age = age
        self.nickName = nickName
    }
}

let yuri: PersonB = PersonB(name: "yuri", age: 22, nickName: "유리")
// let yuri: PersonB = PersonB(name: "yuri", age: 22, nickName: "") -> 별명이 없는 경우 채우기 힘듦.





// 프로퍼티의 초기값이 꼭 필요 없을 때
// 옵셔널 사용!

class PersonC {
    var name: String
    var age: Int
    var nickName: String?
    
    // 1번도 가능
    init(name: String, age: Int, nickName: String?) {
        self.name = name
        self.age = age
        self.nickName = nickName
    }
    
    // 2번도 가능
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

/*
class PersonC {
    var name: String
    var age: Int
    var nickName: String?
    
    // 미리 만들어진 자신의 init을 가져올 수도 있다. 이때 convenience init을 사용
   convenience init(name: String, age: Int, nickName: String?) {
        self.init(name: name, age: age)
        self.nickName = nickName
    }
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}
*/

let yujin: PersonC = PersonC(name: "yujin", age: 20)
let eunbi: PersonC = PersonC(name: "eunbi", age: 28, nickName: "은비")

// 암시적 추출 옵셔널은
// 인스턴스 사용에 꼭 필요하지만
// 초기값을 할당하지 않고자 할 때 사용

class Puppy {
    var name: String
    var owner: PersonC!
    
    init(name: String) {
        self.name = name
    }
    
    func goOut() {
        print("\(name)가 주인 \(owner.name)과 산책을 합니다.")
    }
}

let happy: Puppy = Puppy(name: "happy")
// happy.goOut()
// 주인을 지정안했기 때문에 오류 발생.

happy.owner = yujin
happy.goOut()





// 실패가능한 이니셜라이저
// 이니셜라이저 매개변수로 전달되는 초기값이 잘못된 경우
// 인스턴스 생성에 실패할 수 있다.
// 인스턴스 생성에 실패하면 nil을 반환한다.
// 그래서 실패가능한 이니셜라이저의 반환타입은 옵셔널 타입이다.

class PersonD {
    var name: String
    var age: Int
    var nickName: String?
    
    init?(name: String, age: Int) {
        if (0...120).contains(age) == false {
            return nil
        }
        
        if name.count == 0 {
            return nil
        }
    
    self.name = name
    self.age = age
        
    }
}

// let minju: PersonD = PersonD(name: "miinju", age: 22)
let minju: PersonD? = PersonD(name: "minju", age: 22)
let sana: PersonD? = PersonD(name: "sana", age: 123)
let nayeon: PersonD? = PersonD(name: "", age: 28)

print(sana) // nil
print(nayeon) // nil





// deinit - 디이니셜라이저

// deinit은 클래스의 인스턴스가
// 메모리에서 해제되는 시점에 호출된다.
// 인스턴스가 해제되는 시점에 해야할 일을 구현할 수 있다.

class PersonE {
    var name: String
    var pet: Puppy?
    var child: PersonC
    
    init(name: String, child: PersonC) {
        self.name = name
        self.child = child
    }
    
    deinit {
        if let petName = pet?.name {
            print("\(name)가 \(child.name)에게 \(petName)를 인도한다.")
            self.pet?.owner = child
        }
    }
}

var donald: PersonE? = PersonE(name: "donald", child: yujin)
donald?.pet = happy
donald = nil // donald 인스턴스가 더이상 필요없으므로 메모리에서 해제된다.
// donald가 jenny에게 happy를 인도한다.
