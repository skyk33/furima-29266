function profit() {
  const sales_price = document.getElementById("item-price");
  const sales_commission = document.getElementById("add-tax-price");
  const profit_price = document.getElementById("profit");

  sales_price.addEventListener("change", () => {
    inputValue = parseInt(sales_price.value);
    sales_commission.innerHTML = inputValue * 0.1;
    profit_price.innerHTML = inputValue - (sales_commission.innerHTML);
  })
};

window.addEventListener("load", profit);
