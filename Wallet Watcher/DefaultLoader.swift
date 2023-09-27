//
//  DefaultLoader.swift
//  Wallet Watcher
//
//  Created by Sam McIntyre on 9/26/23.
//

import Foundation

//defines a default loader, which simply loads in defaults, especially if there is no data in the system yet.
class DefaultLoader{
	
	init(){		
		runOnLoad()
	}
	
	func runOnLoad(){
		let defaults = UserDefaults.standard
		
		//checking for first ever load
		if defaults.bool(forKey: "First Launch") == true{
			//second+ time
			defaults.set(true, forKey: "First Launch")
		} else {
			//first time
			defaults.set(true, forKey: "First Launch")
			
			//fill in some basic defaults
			defaults.setValue(0.18, forKey: "gratuity")
			defaults.setValue(0.00, forKey: "tax")
			defaults.setValue(200.00, forKey: "budget")
			defaults.setValue("", forKey: "purpose")
			defaults.setValue("", forKey: "location")
		}
	}
}
