window.addEventListener('load', function(){
  const price = document.getElementById("item-price");
  const commission = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");

  price.addEventListener("input", () => {
    const input_price = price.value;
    commission_value = Math.floor(input_price * 0.1);
    commission.innerHTML = commission_value;
    profit.innerHTML = Math.floor(input_price -  commission_value);
  })

});
