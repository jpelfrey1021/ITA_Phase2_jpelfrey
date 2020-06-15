//drink about - 8kyu
function peopleWithAgeDrink(old) {
  let drink = ""
  switch(true) {
    case (old<14):
      drink += "drink toddy"
      break
    case (old<18):
      drink += "drink coke"
      break
    case (old<21):
      drink += "drink beer"
      break
    case (old>=21):
      drink = "drink whisky"
      break
  }
  return drink;
};

//Series of integers from m to n - 7kyu
function generateIntegers(m, n) {
  var result = []
  for (var i = m; i <= n; i++) {
    result.push(i)
  }
  return result
}


//Did we win the super bowl? - 7kyu
function didWeWin(plays){
  let score = 0
  plays.forEach(function(play) {
    if (play[1] === "sack") {
      score -= play[0]
    }
    if (play[1] === "pass" || play[1] === "run") {
      score += play[0]
    }
    if (play[1] === "turnover") {
      return
    }
    return score
    })
  if (score > 10 ) {
    return true
  } else {
    return false
  }
}


//responsible drinking - 7kyu
function hydrate(s) {
  s = s.split(" ")
  let options = ['1','2','3','4','5','6','7','8','9']
  let numbers = s.filter(element => options.includes(element))
  console.log(numbers)
  console.log(numbers)
  let sum = 0
  
  numbers.forEach(function(number) {
    number = parseInt(number)
    sum += number
  })
  
  if (sum===1) {
    return `1 glass of water`
  } else {
    return `${sum} glasses of water`
  }
}

//Remove First and Last Character Part Two - 8kyu
function array(arr){
  arr = arr.split(",")
  if (arr.length <= 2) {
    return null
  } else {
    arr.pop()
    arr.shift()
    return arr.join(' ')
  }
}
