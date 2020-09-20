//
//  ObservableHelpers.swift
//  LeknesTests
//
//  Created by Rajesh Billakanti on 20/4/20.
//  Copyright © 2020 Rajesh Billakanti. All rights reserved.
//

import Foundation

import RxSwift
import RxTest

public struct ObservableHelpers {
    public static func latestValueFrom<T>(observable: Observable<T>,
                                          disposeBag: DisposeBag) -> T? {
        return latestValueFrom(observable: observable,
                               disposeBag: disposeBag,
                               executeBlock: nil)
    }

    public static func latestValueFrom<T>(observable: Observable<T>,
                                          disposeBag: DisposeBag,
                                          executeBlock: (() -> Void)?) -> T? {
        let events = self.events(from: observable,
                                 disposeBag: disposeBag,
                                 executeBlock: executeBlock)
        return events.last?.value.element
    }

    public static func events<T>(from observable: Observable<T>,
                                 disposeBag: DisposeBag,
                                 executeBlock: (() -> Void)?) -> [Recorded<Event<T>>] {
        let testScheduler = TestScheduler(initialClock: 0)
        let testObserver = testScheduler.createObserver(T.self)

        observable
            .bind(to: testObserver)
            .disposed(by: disposeBag)

        if let executeBlock = executeBlock { executeBlock() }

        return testObserver.events
    }
}
