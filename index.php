<?php
require "config/database.php";
$pageTitle = "Sprint Gear | Home";
include "includes/header.php";
$products = $pdo->query("SELECT Product_ID, Product_Name, Price, Description FROM Product WHERE Status IS NULL OR Status='Active' LIMIT 6")->fetchAll();
?>
<section class="hero">
  <div class="container hero-grid">
    <div>
      <p>SPORTS • PERFORMANCE • STYLE</p>
      <h1>Gear Up.<br>Move Fast.</h1>
      <p>Discover quality sports products designed for training, running and everyday performance.</p>
      <a class="btn" href="products.php">Shop Products</a>
    </div>
    <div class="hero-card"><div class="shoe">👟</div><h2>Run Your Best</h2><p>Performance gear made for your next goal.</p></div>
  </div>
</section>
<section class="section">
  <div class="container">
    <div class="section-title"><h2>Featured Products</h2><p class="muted">Popular items from Sprint Gear</p></div>
    <div class="grid">
      <?php foreach($products as $p): ?>
      <article class="card">
        <div class="card-img">🏃</div>
        <div class="card-body">
          <h3><?= htmlspecialchars($p['Product_Name']) ?></h3>
          <p class="muted"><?= htmlspecialchars($p['Description'] ?? '') ?></p>
          <p class="price">Rs. <?= number_format($p['Price'],2) ?></p>
          <a class="btn" href="product-details.php?id=<?= $p['Product_ID'] ?>">View Product</a>
        </div>
      </article>
      <?php endforeach; ?>
    </div>
  </div>
</section>
<?php include "includes/footer.php"; ?>