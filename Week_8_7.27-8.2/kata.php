<?php

//Array.diff
function arrayDiff($a, $b) {
    foreach ($b as $character) {
        if (in_array($character, $a)) {

            foreach($a as $index=>$val) {
                if ($val == $character) {
                    unset($a[$index]);
                }
            }
        }
    }
    array_splice($a, 0, 0);
    return $a;
}