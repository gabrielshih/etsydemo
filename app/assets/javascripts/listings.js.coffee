jQuery ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  listing.setupForm()

listing =
  setupForm: ->
    # This if statement below, makes Coffeescript validate the bank account
    # info only if it sees more than 6 fields. Because Coffeescript does not have access to the 
    # database, instead it checks the number of fields present. 
    # In our views/_form.html.erb, we had the bank account fields only show if
    # there was no recipient ID in User/current_user.
    # We put the input fields as "6" because our 4 plus 2 hidden ones that Rails always 
    # puts in as default. 
    if $('input').length > 6
      $('#new_listing').submit ->
        $('input[type=submit]').attr('disabled', true)
        Stripe.bankAccount.createToken($('#new_listing'), listing.handleStripeResponse)
        false

  handleStripeResponse: (status, response) ->
    if status == 200
      $('#new_listing').append($('<input type="hidden" name="stripeToken" />').val(response.id))
      $('#new_listing')[0].submit()
    else
      $('#stripe_error').text(response.error.message).show()
      $('input[type=submit]').attr('disabled', false)
