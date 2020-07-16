<?
//Stop gninnipS My sdroW!
function spinWords(string $str): string {
  $array = explode(" ", $str);
  $final = [];
  foreach($array as $word) {
    if (strlen($word) < 5) {
      $final[] = $word;
    } else {
      $letters = str_split($word);
      $backwards = [];
      for ($i = count($letters) - 1; $i >= 0; $i--) {
        $backwards[] = $letters[$i];
      }
      $backwards = implode('', $backwards);
      $final[] = $backwards;
    }
  }
  $done = implode(' ', $final);
  return $done;
}

//Kill The Monsters!
function killMonsters($h, $m, $dm) {
  $hits = floor(($m-1) / 3);
  $damage = $dm * $hits;
  $health = $h - $damage;
  if ($health > 0) {
    return 'hits: ' . $hits . ', damage: ' . $damage . ', health: ' . $health;
  } else {
    return 'hero died';
  }
}

//Dan's great power generator
function danspower(int $num, int $power): int {
  $final = pow($num, $power);
  return $final % 2 == 0 ? $final : round($final, -1);
}

//Going to the cinema
function movie($card, $ticket, $perc) {
  $normal = 0;
  $cardprice = $card;
  $newTicket = $ticket;
  $number = 0;
  while (ceil($cardprice) >= $normal) {
    $normal += $ticket;
    $newTicket *= $perc;
    $cardprice += $newTicket;
    $number ++;
  }
  return $number;
}

//Help Green Lantern with his web site
function yellowBeGone($colorNameOrCode) {
  $color = $colorNameOrCode;
  
  if ($color[0] == "#") {
    $redHex = "{$color[1]}{$color[2]}";
    $greenHex = "{$color[3]}{$color[4]}";
    $blueHex = "{$color[5]}{$color[6]}";
    $red = hexdec($redHex);
    $green = hexdec($greenHex);
    $blue = hexdec($blueHex);
  }
  
  $color = strtolower($color);
  
  switch($color) {
      case "lemonchiffon":
        return "PaleGreen";
      case "gold":
        return "ForestGreen";
      case "khaki":
        return "LimeGreen";
      case "lightgoldenrodyellow":
        return "SpringGreen";
      case "lightyellow":
        return "MintCream";
      case "palegoldenrod":
        return "LightGreen";
      case "yellow":
        return "Lime";
      case ($red && $red > $blue && $green > $blue): 
        if ($red > $green) {
          return "#{$blueHex}{$redHex}{$greenHex}";
        } else {
          return "#{$blueHex}{$greenHex}{$redHex}";
        };
      default: return $colorNameOrCode;
  }
}

