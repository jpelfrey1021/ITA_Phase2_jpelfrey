<?

//Pre-FizzBuzz Workout #1

function pre_fizz($n) {
  $numbers = [];
  for ($i = 1; $i <= $n; $i++) {
    $numbers[] = $i;
  }
  return $numbers;
}


//simple calculator
function calculator($a, $b, $sign) {
  if (is_string($a) || is_string($b)) {
    return "unknown value";
  } else if (is_numeric($a) && is_numeric($b))  {
    switch ($sign) {
      case "+" :
        return $a + $b;
        break;
      case "-":
        return $a - $b;
        break;
      case "*":
        return $a * $b;
        break;
      case "/":
        return $a / $b;
        break;
      default:
        return "unknown value";
    }
  } else {
    return "unknown value";
  }
}


//Remove the time
function shortenToDate($longDate) {
  $parts = explode(",", $longDate);
  return $parts[0];
}


//L1: Set Alarm
function setAlarm(bool $employed, bool $vacation): bool {
  return ($employed && ! $vacation);
}


//Is this my tail?
function equivalent($body, $char) {
  $animal = str_split($body);
  return ($char == $animal[count($animal) - 1]);
}


//Total amount of points
function points(array $games): int {
  $score = 0; 
  
  foreach ($games as $game) {
    $x = substr($game, 0, 1);
    $y = substr($game, 2, 1);
    
    if ($x > $y) {
      $score = $score + 3;
    } elseif ($x < $y) {
      $score = $score;
    } elseif ($x == $y) {
      $score = $score + 1;
    }
  }
  return $score;
}