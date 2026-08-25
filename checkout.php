<?php
require "config/database.php";
if (session_status() === PHP_SESSION_NONE) session_start();
$cart=$_SESSION['cart']??[];
if(!$cart){ header("Location: cart.php"); exit; }
$total=0; foreach($cart as $i)$total += $i['price']*$i['quantity'];
$message='';
if($_SERVER['REQUEST_METHOD']==='POST'){
    $userId=(int)($_POST['user_id']??0);
    $address=trim($_POST['address']??'');
    $method=$_POST['payment_method']??'Cash on Delivery';
    if($userId && $address){
        try{
            $pdo->beginTransaction();
            $s=$pdo->prepare("INSERT INTO `Order` (User_ID,Total_Amount,Status) VALUES (?,?,?)");
            $s->execute([$userId,$total,'Pending']); $orderId=$pdo->lastInsertId();
            $oi=$pdo->prepare("INSERT INTO Order_Item (Order_ID,Variant_ID,Quantity,Unit_Price) VALUES (?,?,?,?)");
            foreach($cart as $i) $oi->execute([$orderId,$i['variant_id'],$i['quantity'],$i['price']]);
            $pay=$pdo->prepare("INSERT INTO Payment (Order_ID,Payment_Method,Payment_Status,Amount) VALUES (?,?,?,?)");
            $pay->execute([$orderId,$method,$method==='Cash on Delivery'?'Pending':'Pending',$total]);
            $del=$pdo->prepare("INSERT INTO Delivery (Order_ID,Delivery_Address,Delivery_Status) VALUES (?,?,?)");
            $del->execute([$orderId,$address,'Pending']);
            $pdo->commit(); unset($_SESSION['cart']);
            $message="Order #$orderId placed successfully.";
            $cart=[]; $total=0;
        }catch(Exception $e){$pdo->rollBack();$message="Order failed: ".$e->getMessage();}
    } else $message="Please enter a valid User ID and delivery address.";
}
$pageTitle="Sprint Gear | Checkout"; include "includes/header.php";
?>
<section class="section"><div class="container">
<h1>Checkout</h1>
<?php if($message): ?><div class="alert"><?= htmlspecialchars($message) ?></div><?php endif; ?>
<?php if($cart): ?>
<div class="checkout-grid">
<div>
<form method="post">
<div class="panel"><h2>Customer & Delivery</h2>
<label>User ID</label><input type="number" name="user_id" min="1" required>
<label>Delivery Address</label><input name="address" required placeholder="Enter delivery address">
</div>
<div class="panel"><h2>Payment Method</h2>
<label><input type="radio" name="payment_method" value="Cash on Delivery" checked> Cash on Delivery</label>
<label><input type="radio" name="payment_method" value="Card Payment"> Card Payment</label>
</div>
<button class="btn" type="submit">Place Order</button>
</form>
</div>
<div class="summary"><h2>Order Summary</h2>
<?php foreach($cart as $i): ?><p><?= htmlspecialchars($i['name']) ?> × <?= $i['quantity'] ?> — Rs. <?= number_format($i['price']*$i['quantity'],2) ?></p><?php endforeach; ?>
<hr><h2>Total: Rs. <?= number_format($total,2) ?></h2></div>
</div>
<?php endif; ?>
</div></section>
<?php include "includes/footer.php"; ?>