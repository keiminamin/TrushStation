//
//  Garbage.swift
//  TrushStation
//
//  Created by 長島啓太朗 on 2023/09/18.
//

import Foundation
import RealmSwift

class Garbage :Object{
    @Persisted var trushLongtitude :Double = 0
    @Persisted var trushLatitude :Double = 0
    @Persisted var number :Int = 0
    @Persisted var isBurnableGarbage :Bool = false
    @Persisted var isIncombustibleGarbage :Bool = false
    @Persisted var isPetBottle :Bool = false
    @Persisted var isEmptyCan :Bool = false
    @Persisted var id:Int = 0
}
