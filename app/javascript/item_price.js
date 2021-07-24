window.addEventListener('load', function(){
const priceInput = document.getElementById("item-price");
if (!priceInput){ return false;}
  priceInput.addEventListener('input', function() {
      const inputValue = priceInput.value
      const addTaxDom = document.getElementById("add-tax-price");
      addTaxDom.innerHTML = Math.floor(inputValue * 0.1);
      const profit = document.getElementById("profit");
      profit.innerHTML = inputValue - Math.floor(inputValue * 0.1);
})});