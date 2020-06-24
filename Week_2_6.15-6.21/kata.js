//Risk (Game) : Battle Outcome
function battleOutcome( attacker , defender ) {
    // Add code here:
    attacker = attacker.sort(function(a, b){return a-b})
    defender = defender.sort(function(a, b){return a-b})
    
    while (attacker.length > defender.length) {
      attacker.shift()
    }
    
    while (attacker.length < defender.length) {
      defender.shift()
    }
  
    console.log(attacker)
    console.log(defender)
    
    let aLost = 0
    let dLost = 0
    
    attacker.forEach((roll,i) => {
      if (attacker[i] > defender[i]) {
        dLost += 1
      } else if (attacker[i] <= defender[i]) {
        aLost += 1
      }
    })
    return [aLost, dLost]
  }


//Abbreviate a Two Word Name
function abbrevName(name){
  name = name.toUpperCase().split(" ")
  return `${name[0][0]}.${name[1][0]}`
}  

//array plus array
function arrayPlusArray(arr1, arr2) {
  let sum = 0
  arr1.forEach(function(num) {
    sum += num
  })
  arr2.forEach(function(num) {
    sum += num
  })
  return sum
}


//Short Long Short
function solution(a, b){
  if (a.length > b.length) {
    return `${b}${a}${b}`
  } else {
    return `${a}${b}${a}`
  }
}

//For Twins: 2. Math operations
function iceBrickVolume(radius, bottleLength, rimLength) {
  let height = bottleLength - rimLength
  let width = radius * Math.sqrt(2)
  let volume = width*width*height
  return Math.round(volume)
}