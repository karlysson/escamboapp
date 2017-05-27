class Checkout::PaymentsController < ApplicationController

  def create
    #Email: c60137540061723914447@sandbox.pagseguro.com.br
    #Senha: 172566587950BC06
    #Cartao: 4111111111111111 / Bandeira: VISA Válido até: 12/2030 CVV: 123

    ad = Ad.find(params[:ad_id])
    ad.processing!

    order = Order.create(ad: ad, buyer_id: current_member.id )
    order.waiting!

    payment = PagSeguro::PaymentRequest.new

    payment.reference = order.id
    payment.notification_url = checkout_notifications_url
    payment.redirect_url = site_ad_detail_url(ad)

    payment.items << {
        id: ad.id,
        description: ad.title,
        amount: ad.price.to_s.gsub(',' , '.')
    }

    response = payment.register

    if response.errors.any?
        redirect_to site_ad_detail_path(ad), alert: "Error ao processar compra... Entre em contato com o SAC (62) 98260-7432"
    else
        redirect_to response.url
    end
  end
end
