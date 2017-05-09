// Change numbers to decimals for inputs involving money
$(function() {
  $donation_amount = $('#donation_amount_')
  if ($donation_amount.length > 0) {
    $donation_amount.on('blur', function(e) {
      amount = parseFloat($(this).val());
      if (Number.isInteger(amount)) {
        amount = (amount / 100).toFixed(2);
        $(this).val(amount)
      } else {
        amount = Math.round(amount * 100) / 100
        $(this).val(amount)
      }
    })
  }
});
