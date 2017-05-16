import Foundation
import Glibc
func fitD(_ d: Date, _ size: Int, right: Bool = false) -> String {
	let df = DateFormatter()
	df.dateFormat = "MM-dd-yyyy"
	let dAsString = df.string(from: d)
	return fit(dAsString, size, right: right)
}

func fitI(_ i: Int, _ size: Int, right: Bool = false) -> String {
	let iAsString = "\(i)"
	let newLength = iAsString.characters.count
	return fit(iAsString, newLength > size ? newLength : size , right: right)
}

func fit(_ s: String,_ size: Int, right: Bool = true) -> String {
	var result = ""
	let sSize = s.characters.count
	if sSize == size {return s}
	var count = 0
	if size < size {
		for c in s.characters {
			if count < size {result.append(c)}
			count += 1
		}
		return result
	}
	result = s
	var addon = ""
	let num = size - sSize
	for _ in 0..<num {addon.append(" ")}
	if right{return result + addon}
	return addon + result

}
