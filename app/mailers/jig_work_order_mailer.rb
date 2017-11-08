class JigWorkOrderMailer < ApplicationMailer
  default from: 'noreply@autochemind.com'

  def jig_work_order_created(user, jig_work_order)
    @user = user
    @jig_work_order = jig_work_order
    mail to: @user.email, subject: "New Jig Work Order for #{@jig_work_order.customer.name}"
  end 

  def jig_work_order_verified(user, jig_work_order)
    @user = user
    @jig_work_order = jig_work_order
    mail to: @user.email, subject: "Jig Work Order for #{@jig_work_order.customer.name} Verified"
  end

  def jig_work_order_shipped(user, jig_work_order)
    @user = user
    @jig_work_order = jig_work_order
    attachments.inline['autochem_industrial.png'] = File.read("#{Rails.root}/app/assets/images/autochem_industrial.png")
    mail to: @user.email, subject: "Jig Work Order for #{ @jig_work_order.customer.name } Shipped"
  end
end
