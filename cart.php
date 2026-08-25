<?php
if (session_status() === PHP_SESSION_NONE) session_start();
if ($_SERVER['REQUEST_METHOD']==='POST') {
    if(isset($_POST['remove'])) unset($_SESSION['cart'][(int)$_POST['remove']]);
    if(isset($_POST['update'])) foreach($_POST['qty'] as $id=>$qty)
        if(isset($_SESSION['cart'][$id])) $_SESSION['cart'][$id]['quantity']=max(1,(int)$qty);
    header("Location: cart.php"); exit;
}
$pageTitle="Sprint Gear | Shopping Cart"; include "includes/header.php";
$cart=$_SESSION['cart']??[]; $total=0;
foreach($cart as $i)$total += $i['price']*$i['quantity'];
?>
<section class="section"><div class="container">
<h1>Shopping Cart</h1>
<?php if(!$cart): ?>
<div class="panel"><p>Your cart is empty.</p><a class="btn" href="products.php">Continue Shopping</a></div>
<?php else: ?>
<div class="cart-layout">
<div>
<form method="post">
<table class="cart-table"><thead><tr><th>Product</th><th>Price</th><th>Qty</th><th>Subtotal</th><th></th></tr></thead><tbody>
<?php foreach($cart as $id=>$i): $sub=$i['price']*$i['quantity']; ?>
<tr><td><?= htmlspecialchars($i['name']) ?></td><td>Rs. <?= number_format($i['price'],2) ?></td>
<td><input class="qty" type="number" min="1" name="qty[<?= $id ?>]" value="<?= $i['quantity'] ?>"></td>
<td>Rs. <?= number_format($sub,2) ?></td><td><button class="btn danger" name="remove" value="<?= $id ?>">Remove</button></td></tr>
<?php endforeach; ?>
</tbody></table><br><button class="btn secondary" name="update" value="1">Update Cart</button>
</form>
</div>
<div class="summary"><h2>Cart Summary</h2><p>Total</p><h2>Rs. <?= number_format($total,2) ?></h2><a class="btn" href="checkout.php">Proceed to Checkout</a></div>
</div>
<?php endif; ?>
</div></section>
<?php include "includes/footer.php"; ?>