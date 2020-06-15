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