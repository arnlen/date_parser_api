class PaymentMethodsController < ApplicationController

  def parse
    source_payment_method = payment_method_params['payment_method']

    render json: {
      source: source_payment_method,
      payment_method: find_payment_method(source_payment_method)
    }
  end

  private

  def find_payment_method(source_payment_method)
    return '' unless source_payment_method

    source_payment_method.downcase!

    return 'cb' if PaymentMethods::CB_METHOD.include?(source_payment_method)
    return 'virement' if PaymentMethods::TRANSFER_METHOD.include?(source_payment_method)
    return 'prélèvement' if PaymentMethods::DEBIT_METHOD.include?(source_payment_method)

    ''
  end

  def payment_method_params
    params.permit(:payment_method)
  end

end
