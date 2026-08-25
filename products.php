<?php
require "config/database.php";
$pageTitle = "Sprint Gear | Products";
$q = trim($_GET['q'] ?? '');
if ($q !== '') {
    $stmt = $pdo->prepare("SELECT * FROM Product WHERE Product_Name LIKE ? ORDER BY Product_ID DESC");
    $stmt->execute(["%$q%"]);
    $products = $stmt->fetchAll();
} else {
    $products = $pdo->query("SELECT * FROM Product ORDER BY Product_ID DESC")->fetchAll();
}
include "includes/header.php";
?>
<section class="section">
<div class="container">
  <h1>Products</h1>
  <div class="toolbar">
    <p class="muted"><?= count($products) ?> product(s)</p>
    <form><input class="search" name="q" value="<?= htmlspecialchars($q) ?>" placeholder="Search products..."></form>
  </div>
  <div class="grid">
  <?php foreach($products as $p): ?>
    <article class="card">
      <div class="card-img">🏃‍♂️</div>
      <div class="card-body">
        <h3><?= htmlspecialchars($p['Product_Name']) ?></h3>
        <p class="muted"><?= htmlspecialchars($p['Description'] ?? '') ?></p>
        <p class="price">Rs. <?= number_format($p['Price'],2) ?></p>
        <a class="btn" href="product-details.php?id=<?= $p['Product_ID'] ?>">View Details</a>
      </div>
    </article>
  <?php endforeach; ?>
  </div>
</div>
</section>
<?php include "includes/footer.php"; ?>