<?php
require "config/database.php";
if (session_status() === PHP_SESSION_NONE) session_start();
$id = (int)($_GET['id'] ?? 0);
$stmt = $pdo->prepare("SELECT * FROM Product WHERE Product_ID=?");
$stmt->execute([$id]);
$product = $stmt->fetch();
if (!$product) die("Product not found.");

$vs = $pdo->prepare("SELECT pv.*, s.Size_Name, c.Color_Name, g.Gender_Name, m.Material_Name
FROM Product_Variant pv
LEFT JOIN Size s ON pv.Size_ID=s.Size_ID
LEFT JOIN Color c ON pv.Color_ID=c.Color_ID
LEFT JOIN Gender g ON pv.Gender_ID=g.Gender_ID
LEFT JOIN Material m ON pv.Material_ID=m.Material_ID
WHERE pv.Product_ID=?");
$vs->execute([$id]); $variants=$vs->fetchAll();

if ($_SERVER['REQUEST_METHOD']==='POST') {
    $variantId=(int)$_POST['variant_id']; $qty=max(1,(int)$_POST['quantity']);
    $check=$pdo->prepare("SELECT pv.Variant_ID,pv.Price,p.Product_Name FROM Product_Variant pv JOIN Product p ON p.Product_ID=pv.Product_ID WHERE pv.Variant_ID=?");
    $check->execute([$variantId]); $v=$check->fetch();
    if($v){
        $_SESSION['cart'][$variantId] = [
            'variant_id'=>$variantId,'quantity'=>($_SESSION['cart'][$variantId]['quantity']??0)+$qty,
            'price'=>$v['Price'],'name'=>$v['Product_Name']
        ];
    }
    header("Location: cart.php"); exit;
}
$pageTitle="Sprint Gear | ". $product['Product_Name'];
include "includes/header.php";
?>
<section class="details"><div class="container details-grid">
  <div class="product-visual">👟</div>
  <div>
    <p class="muted">SPORTS PRODUCT</p>
    <h1><?= htmlspecialchars($product['Product_Name']) ?></h1>
    <p><?= htmlspecialchars($product['Description'] ?? '') ?></p>
    <h2 class="price">Rs. <?= number_format($product['Price'],2) ?></h2>
    <form method="post">
      <label>Product Variant</label>
      <select name="variant_id" required>
        <?php foreach($variants as $v): ?>
        <option value="<?= $v['Variant_ID'] ?>">
          <?= htmlspecialchars(($v['Size_Name']??'') . " | " . ($v['Color_Name']??'') . " | " . ($v['Gender_Name']??'')) ?>
          — Rs. <?= number_format($v['Price'],2) ?>
        </option>
        <?php endforeach; ?>
      </select>
      <label>Quantity</label><input class="qty" type="number" name="quantity" value="1" min="1">
      <br><br><button class="btn" type="submit">Add to Cart</button>
    </form>
  </div>
</div></section>
<?php include "includes/footer.php"; ?>