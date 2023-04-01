---
layout: post
title: Php code to generate random images
tags: ["php", "random", "image", "composer"]
---

Php code for generating random images

```php
<?php
$colors = [
    '255_255_255', //white
    '255_0_0', //red
    '0_255_0', //green
    '0_0_255', //blue
];

$heights = [
    200,
    300,
    400,
    500,
    600,
    700,
    800
];

$widths = [
    200,
    300,
    400,
    500,
    600,
    700,
    800
];

function generateRandomString($length = 10) {
    $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    $charactersLength = strlen($characters);
    $randomString = '';
    for ($i = 0; $i < $length; $i++) {
        $randomString .= $characters[random_int(0, $charactersLength - 1)];
    }
    return $randomString;
}

/**
 * @return void
 */
function generateImages($width, $height, $color): void
{
    $colors = explode('_', $color);
    // Create a blank image with a width and height of 200 pixels
    $image = imagecreatetruecolor($width, $height);

    // Set the background color to white
    $backgroundColor = imagecolorallocate($image, $colors[0], $colors[1], $colors[2]);
    imagefill($image, 0, 0, $backgroundColor);

    // Draw a gray rectangle
    $drawColor = imagecolorallocate($image, 154, 146, 146);
    $offset = 5;
    for($i = 0; $i <= $offset; $i++) {
        $newOffset = $offset - $i;
        imagerectangle($image, $newOffset, $newOffset, $width - $newOffset, $height - $newOffset, $drawColor);
        imageline($image, $newOffset, $newOffset, $width - $newOffset, $height - $newOffset, $drawColor);
        imageline($image, $newOffset, $height - $newOffset, $width - $newOffset, $newOffset, $drawColor);
    }


    // Set the text color
    $textColor = imagecolorallocate($image, 0, 0, 0);
    $text = generateRandomString(30);
    imagestring($image, 10, 10, 50, $text, $textColor);

    // Save the image as a PNG file
    imagepng($image, "./test_gen_images/{$width}_{$height}_{$color}image.png");

    // Free up memory
    imagedestroy($image);
}


foreach ($colors as $color) {
    foreach ($widths as $width) {
        foreach ($heights as $height) {
            generateImages($width, $height , $color);
        }
    }
}

```

Generate image with grid. You need download the [arial.ttf](/assets/arial.ttf) font and save to same folder of the php script 

```php
<?php
$colors = [
    '255_255_255', //white
    '255_0_0', //red
    '0_255_0', //green
    '0_0_255', //blue
];

$heights = [
    800,
    900,
    1000,
    1200,
    1400
];

$widths = [
    800,
    900,
    1000,
    1200,
    1400
];

function generateRandomString($length = 10) {
    $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    $charactersLength = strlen($characters);
    $randomString = '';
    for ($i = 0; $i < $length; $i++) {
        $randomString .= $characters[random_int(0, $charactersLength - 1)];
    }
    return $randomString;
}

/**
 * @return void
 */
function generateImages($width, $height, $color): void
{
    $colors = explode('_', $color);
    // Create a blank image with a width and height of 200 pixels
    $image = imagecreatetruecolor($width, $height);

    // Set the background color to white
    $backgroundColor = imagecolorallocate($image, $colors[0], $colors[1], $colors[2]);
    imagefill($image, 0, 0, $backgroundColor);

    // Draw a gray rectangle
    $drawColor = imagecolorallocate($image, 154, 146, 146);
    $offset = 5;
    for($i = 0; $i <= $offset; $i++) {
        $newOffset = $offset - $i;
        imagerectangle($image, $newOffset, $newOffset, $width - $newOffset, $height - $newOffset, $drawColor);
        imageline($image, $newOffset, $newOffset, $width - $newOffset, $height - $newOffset, $drawColor);
        imageline($image, $newOffset, $height - $newOffset, $width - $newOffset, $newOffset, $drawColor);
    }

    //draw grid
    for($i = 0; $i <= $height; $i+=50) {
        imageline($image, 0, $i, $width, $i, $drawColor);
    }

    for($i = 0; $i <= $width; $i+=50) {
        imageline($image, $i, 0, $i, $height, $drawColor);
    }


    // Set the text color
    $textColor = imagecolorallocate($image, 0, 0, 0);
    $text = strtoupper(generateRandomString(30));
    $fontSize = $height / 2;
    $textY = $height - $fontSize / 2;

    imagettftext($image, $fontSize, 0,  10, $textY, $textColor, './arial.ttf', $text);

    // Save the image as a PNG file
    imagepng($image, "./test_gen_images/{$width}_{$height}_{$color}image.png");

    // Free up memory
    imagedestroy($image);
}


foreach ($colors as $color) {
    foreach ($widths as $width) {
        foreach ($heights as $height) {
            generateImages($width, $height , $color);
        }
    }
}
```
