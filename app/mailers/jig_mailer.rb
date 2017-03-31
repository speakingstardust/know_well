class JigMailer < ApplicationMailer
  default from: 'noreply@autochemind.com'

  def new_jig_created(user, jig) 
    @user = user 
    @jig = jig
    mail to: @user.email, subject: "New Jig Created for #{@jig.customer.name}"
  end
end
