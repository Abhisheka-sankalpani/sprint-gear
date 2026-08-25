<?php
if (session_status() === PHP_SESSION_NONE) session_start();
$cartCount = 0;
if (!empty($_SESSION['cart'])) {
    foreach ($_SESSION['cart'] as $item) $cartCount += (int)$item['quantity'];
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><?= htmlspecialchars($pageTitle ?? 'Sprint Gear') ?></title>
<link rel="stylesheet" href="css/style.css">
</head>
<body>
<header class="header">
  <div class="container nav">
    <a class="logo" href="index.php">SPRINT<span>GEAR</span></a>
    <nav>
      <a href="index.php">Home</a>
      <a href="products.php">Products</a>
      <a href="cart.php">Cart <b class="cart-badge"><?= $cartCount ?></b></a>
      <a href="checkout.php">Checkout</a>
    </nav>
  </div>
</header>
<main>