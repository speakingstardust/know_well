class SignaturesController < ApplicationController
  before_action :set_signature, only: [:destroy]

  def new
    @jig_work_order = JigWorkOrder.find(params[:jig_work_order][:jig_work_order_id])
    @signature = Signature.new(jig_work_order: @jig_work_order)
  end

  def create 
    @signature = Signature.new(signature_params)
    @jig_work_order = JigWorkOrder.find(params[:signature][:jig_work_order_id]) 
    if @signature.save
      redirect_to @jig_work_order, notice: "#{@signature.kind} Signature saved"
    else 
      render :new
    end
  end

  def destroy

  end

  private
    def set_signature
      @signature = Signature.find(params[:id])
    end

    def signature_params
      params.require(:signature).permit(:name, :signature, :jig_work_order_id, :kind)  
    end
end
