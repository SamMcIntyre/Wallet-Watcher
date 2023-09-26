//
//  DefaultLoader.swift
//  Wallet Watcher
//
//  Created by Sam McIntyre on 9/26/23.
//

import Foundation

class DefaultLoader{
	//let defaults = UserDefaults.standard
	
	init(){
		//let defaults = UserDefaults.standard
		
		runOnLoad()
	}
	
	func runOnLoad(){
		let defaults = UserDefaults.standard
		
		//checking for first ever load
		if defaults.bool(forKey: "---------First Launch") == true{
			//second+ time
			defaults.set(true, forKey: "First Launch")
		} else {
			//first time
			defaults.set(true, forKey: "First Launch")
			
			//fill in some basic defaults
			defaults.setValue(0.18, forKey: "gratuity")
			defaults.setValue(0.00, forKey: "tax")
			defaults.setValue(250.00, forKey: "budget")
			defaults.setValue("", forKey: "purpose")
			defaults.setValue("", forKey: "location")
		}
	}
}
