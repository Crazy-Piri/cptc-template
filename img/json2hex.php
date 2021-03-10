<?php

if ($argc != 3) {
    printf("Usage:\n");
    printf("%s input output\n", $argv[0]);
    exit;
}

$firmware_color = array(
    "000000",
    "000080",
    "0000FF ",
    "800000",
    "800080",
    "8000FF ",
    "FF0000",
    "FF0080",
    "FF00FF",
    "008000",
    "008080",
    "0080FF",
    "808000",
    "808080",
    "8080FF",
    "FF8000",
    "FF8080",
    "FF80FF",
    "00FF00 ",
    "00FF80",
    "00FFFF ",
    "80FF00",
    "80FF80",
    "80FFFF",
    "FFFF00",
    "FFFF80",
    "FFFFFF",
);

$body = file_get_contents($argv[1]);
$row = json_decode($body, 1);

$res = "";

foreach ($row["values"] as $value) {

    $value = trim($value);
    if (substr($value, 0, 2) == "0x") {
        $i = hexdec(substr($value, 2));
    } else {
        $i = intval($value);
    }

    $res = $res . $firmware_color[$i] . "\n";

}

file_put_contents($argv[2], $res);
